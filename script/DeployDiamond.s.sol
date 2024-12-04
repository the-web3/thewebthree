pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Diamonds/Diamond.sol";
import "../src/Diamonds/DiamondCutFacet.sol";
import "../src/Diamonds/ExampleFacet.sol";

contract DeployDiamond is Script {
    function run() external {
        vm.startBroadcast();

        Diamond diamond = new Diamond();
        DiamondCutFacet diamondCutFacet = new DiamondCutFacet();
        ExampleFacet exampleFacet = new ExampleFacet();

        DiamondCutFacet.FacetCut [] memory cut;
        bytes4[] memory selectors;
        selectors[0] = ExampleFacet.exampleFunction.selector;

        DiamondCutFacet.FacetCut memory cutItem = DiamondCutFacet.FacetCut({
            facetAddress: address(exampleFacet),
            action: DiamondCutFacet.FacetCutAction.Add,
            functionSelectors: selectors
        });
        cut[0] = cutItem;

        diamondCutFacet.diamondCut(cut);

        vm.stopBroadcast();
    }
}
