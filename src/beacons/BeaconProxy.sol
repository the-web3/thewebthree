// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Beacon.sol";

contract BeaconProxy {
    address public immutable beacon;

    constructor(address _beacon) {
        beacon = _beacon;
    }

    fallback() external payable {
        address implementation = Beacon(beacon).getImplementation();
        require(implementation != address(0), "Implementation not set");

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
}
