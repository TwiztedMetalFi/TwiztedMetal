// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./LiquidityPool.sol";

contract PoolFactory {
    address public owner;
    mapping(address => address) public getPool;
    address[] public allPools;

    event PoolCreated(address indexed token, address pool);

    constructor() {
        owner = msg.sender;
    }

    function createPool(address token, address chainlinkFeed) external returns (address pool) {
        require(getPool[token] == address(0), "Pool exists");
        pool = address(new LiquidityPool(token, chainlinkFeed));
        getPool[token] = pool;
        allPools.push(pool);
        emit PoolCreated(token, pool);
    }

    function allPoolsLength() external view returns (uint256) {
        return allPools.length;
    }
}
