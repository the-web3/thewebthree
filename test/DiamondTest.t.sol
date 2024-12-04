pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Diamonds/Diamond.sol";
import "../src/Diamonds/DiamondCutFacet.sol";
import "../src/Diamonds/ExampleFacet.sol";

contract DiamondTest is Test {
    Diamond public diamond;
    DiamondCutFacet public diamondCutFacet;
    ExampleFacet public exampleFacet;

    function setUp() public {
        diamond = new Diamond();
        diamondCutFacet = new DiamondCutFacet();
        exampleFacet = new ExampleFacet();

        DiamondCutFacet.FacetCut[] memory cut;
        bytes4[] memory selectors;
        selectors[0] = ExampleFacet.exampleFunction.selector;
        DiamondCutFacet.FacetCut memory cutItem = DiamondCutFacet.FacetCut({
            facetAddress: address(exampleFacet),
            action: DiamondCutFacet.FacetCutAction.Add,
            functionSelectors: selectors
        });
        cut[0] = cutItem;
        diamondCutFacet.diamondCut(cut);
    }

    function testExampleFunction() public {
        bytes memory data = abi.encodeWithSelector(ExampleFacet.exampleFunction.selector);
        (bool success, bytes memory result) = address(diamond).call(data);
        assertTrue(success);
        assertEq(abi.decode(result, (string)), "Hello from ExampleFacet!");
    }
}
