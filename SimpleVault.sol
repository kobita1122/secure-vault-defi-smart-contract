// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title SimpleVault
 * @dev A production-ready ERC-4626 vault for managing yield-bearing assets.
 */
contract SimpleVault is ERC4626 {
    constructor(IERC20 asset) ERC4626(asset) ERC20("Vault Token", "vTKN") {}

    /**
     * @dev Hook that is called before any transfer of tokens. 
     * This can be extended to include custom yield strategies.
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        super._beforeTokenTransfer(from, to, amount);
    }
}
