// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Logic {
    uint256 public counter;

    function increment() external {
        counter += 1;
    }

    function getCounter() external view returns (uint256) {
        return counter;
    }
}
