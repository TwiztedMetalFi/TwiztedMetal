// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SuperToken is ERC20 {
    address public owner;

    constructor(uint256 initialSupply) ERC20("SuperToken", "SUPER") {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == owner, "Only owner");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        require(msg.sender == owner, "Only owner");
        _burn(from, amount);
    }
}
