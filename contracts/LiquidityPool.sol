// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract LiquidityPool {
    address public token;
    AggregatorV3Interface public priceFeed;
    mapping(address => uint256) public liquidity;

    event Swapped(address indexed user, uint256 amountIn, uint256 amountOut);
    event LiquidityAdded(address indexed provider, uint256 amount);
    event LiquidityRemoved(address indexed provider, uint256 amount);

    constructor(address _token, address _feed) {
        token = _token;
        priceFeed = AggregatorV3Interface(_feed);
    }

    function addLiquidity(uint256 amount) external {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        liquidity[msg.sender] += amount;
        emit LiquidityAdded(msg.sender, amount);
    }

    function removeLiquidity(uint256 amount) external {
        require(liquidity[msg.sender] >= amount, "Not enough");
        liquidity[msg.sender] -= amount;
        IERC20(token).transfer(msg.sender, amount);
        emit LiquidityRemoved(msg.sender, amount);
    }

    function getEthPrice() public view returns (uint256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price);
    }

    function swapToEth(uint256 amount) external {
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer fail");
        uint256 ethAmount = amount * getEthPrice() / 1e8; // Chainlink feed decimals
        (bool sent,) = msg.sender.call{value: ethAmount}("");
        require(sent, "ETH send fail");
        emit Swapped(msg.sender, amount, ethAmount);
    }

    receive() external payable {}
}
