// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SuperToken.sol";

interface ILayerZeroEndpoint {
    function send(
        uint16 _dstChainId,
        bytes calldata _destination,
        bytes calldata _payload,
        address payable _refundAddress,
        address _zroPaymentAddress,
        bytes calldata _adapterParams
    ) external payable;
}

contract BridgeAdapter {
    SuperToken public token;
    address public owner;
    ILayerZeroEndpoint public lzEndpoint;
    uint16 public solanaChainId;
    bytes public solanaReceiver;

    event BridgeToSolana(address indexed user, uint256 amount);

    constructor(
        address _token,
        address _lzEndpoint,
        uint16 _solanaChainId,
        bytes memory _solanaReceiver
    ) {
        token = SuperToken(_token);
        lzEndpoint = ILayerZeroEndpoint(_lzEndpoint);
        solanaChainId = _solanaChainId;
        solanaReceiver = _solanaReceiver;
        owner = msg.sender;
    }

    function bridgeToSolana(uint256 amount) external payable {
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        token.burn(address(this), amount);

        bytes memory payload = abi.encode(msg.sender, amount);
        lzEndpoint.send{value: msg.value}(
            solanaChainId,
            solanaReceiver,
            payload,
            payable(msg.sender),
            address(0),
            bytes("")
        );

        emit BridgeToSolana(msg.sender, amount);
    }

    // Receive tokens minted from Solana bridge
    function receiveFromSolana(address user, uint256 amount) external {
        require(msg.sender == owner, "Only bridge operator");
        token.mint(user, amount);
    }
}