// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import {Script, console} from "forge-std/Script.sol";
import "../src/TheWebThree.sol";


contract TheWebThreeScript is Script {
    ProxyAdmin public theWebThreeProxyAdmin;
    TheWebThree public theWebThree;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        uint256 totalSupply = 1000000000000 * 1e18;

        vm.startBroadcast(deployerPrivateKey);

        theWebThreeProxyAdmin = new ProxyAdmin(deployerAddress);

        console.log("The Web3 ProxyAdmin:", address(theWebThreeProxyAdmin));

        theWebThree = new TheWebThree();

        TransparentUpgradeableProxy proxytheWebThreen = new TransparentUpgradeableProxy(
            address(theWebThree),
            address(theWebThreeProxyAdmin),
            abi.encodeWithSelector(theWebThree.initialize.selector, totalSupply, deployerAddress)
        );
        console.log("TransparentUpgradeableProxy deployed at:", address(proxytheWebThreen));

        vm.stopBroadcast();
    }
}
