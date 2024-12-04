// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


library DiamondStorage {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.storage");

    struct Facet {
        address facetAddress;
        bytes4[] functionSelectors;
    }

    struct DiamondStorageStruct {
        mapping(bytes4 => Facet) selectorToFacet;
        mapping(address => bytes4[]) facetToSelectors;
    }

    function diamondStorage() internal pure returns (DiamondStorageStruct storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
