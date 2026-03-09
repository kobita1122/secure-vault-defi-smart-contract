// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "./SimpleVault.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockToken is ERC20 {
    constructor() ERC20("Mock", "MCK") {
        _mint(msg.sender, 1000000 ether);
    }
}

contract SimpleVaultTest is Test {
    SimpleVault public vault;
    MockToken public asset;
    address public user = address(1);

    function setUp() public {
        asset = new MockToken();
        vault = new SimpleVault(asset);
        asset.transfer(user, 1000 ether);
    }

    function testDeposit() public {
        vm.startPrank(user);
        asset.approve(address(vault), 100 ether);
        vault.deposit(100 ether, user);
        vm.stopPrank();

        assertEq(vault.balanceOf(user), 100 ether);
        assertEq(asset.balanceOf(address(vault)), 100 ether);
    }

    function testWithdrawal() public {
        vm.startPrank(user);
        asset.approve(address(vault), 100 ether);
        vault.deposit(100 ether, user);
        vault.withdraw(50 ether, user, user);
        vm.stopPrank();

        assertEq(asset.balanceOf(user), 950 ether);
    }
}
