// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./DiamondStorage.sol";

contract Diamond {
    constructor() {}

    fallback() external payable {
        DiamondStorage.DiamondStorageStruct storage ds = DiamondStorage.diamondStorage();
        DiamondStorage.Facet memory facet = ds.selectorToFacet[msg.sig];
        require(facet.facetAddress != address(0), "Function does not exist");
        address facetAddress = facet.facetAddress;

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), facetAddress, 0, calldatasize(), 0, 0)
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
