// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Beacon {
    address private implementation;

    event Upgraded(address indexed newImplementation);

    constructor(address _initialImplementation) {
        implementation = _initialImplementation;
    }

    function getImplementation() external view returns (address) {
        return implementation;
    }

    function upgrade(address _newImplementation) external {
        require(_newImplementation != address(0), "Implementation cannot be zero address");
        implementation = _newImplementation;
        emit Upgraded(_newImplementation);
    }
}
