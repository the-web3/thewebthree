// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/beacons/Beacon.sol";
import "../src/beacons/BeaconProxy.sol";
import "../src/beacons/Logic.sol";

contract DeployBeaconProxy is Script {
    function run() external {
        vm.startBroadcast();

        Logic logic = new Logic();

        Beacon beacon = new Beacon(address(logic));

        BeaconProxy proxy = new BeaconProxy(address(beacon));

        vm.stopBroadcast();

        console.log("Logic deployed at:", address(logic));
        console.log("Beacon deployed at:", address(beacon));
        console.log("Proxy deployed at:", address(proxy));
    }
}
