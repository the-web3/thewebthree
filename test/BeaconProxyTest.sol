// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/beacons/Beacon.sol";
import "../src/beacons/BeaconProxy.sol";
import "../src/beacons/Logic.sol";
import "../src/beacons/NewLogic.sol";

contract BeaconProxyTest is Test {
    Beacon public beacon;
    BeaconProxy public proxy;
    Logic public logic;
    NewLogic public newLogic;

    function setUp() public {
        logic = new Logic();
        beacon = new Beacon(address(logic));
        proxy = new BeaconProxy(address(beacon));
    }

    function testLogicFunctionality() public {
        (bool success, ) = address(proxy).call(abi.encodeWithSignature("increment()"));
        assertTrue(success);

        (, bytes memory result) = address(proxy).call(abi.encodeWithSignature("getCounter()"));
        uint256 counter = abi.decode(result, (uint256));
        assertEq(counter, 1);
    }

    function testUpgrade() public {
        newLogic = new NewLogic();
        beacon.upgrade(address(newLogic));

        (bool success, ) = address(proxy).call(abi.encodeWithSignature("increment()"));
        assertTrue(success);

        (, bytes memory result) = address(proxy).call(abi.encodeWithSignature("getCounter()"));
        uint256 counter = abi.decode(result, (uint256));
        assertEq(counter, 2);
    }
}
