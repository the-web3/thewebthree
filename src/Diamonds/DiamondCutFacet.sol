// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./DiamondStorage.sol";

contract DiamondCutFacet {
    enum FacetCutAction {
        Add,
        Replace,
        Remove
    }

    struct FacetCut {
        address facetAddress;
        FacetCutAction action;
        bytes4[] functionSelectors;
    }

    function diamondCut(FacetCut[] calldata _diamondCut) external {
        DiamondStorage.DiamondStorageStruct storage ds = DiamondStorage.diamondStorage();

        for (uint256 i; i < _diamondCut.length; i++) {
            FacetCut memory cut = _diamondCut[i];
            if (cut.action == FacetCutAction.Add) {
                for (uint256 j; j < cut.functionSelectors.length; j++) {
                    bytes4 selector = cut.functionSelectors[j];
                    require(ds.selectorToFacet[selector].facetAddress == address(0), "Selector already exists");
                    ds.selectorToFacet[selector] = DiamondStorage.Facet(cut.facetAddress, cut.functionSelectors);
                }
            }
        }
    }
}
