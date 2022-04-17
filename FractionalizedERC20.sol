// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1 ;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FractionalizedERC20 is ERC20, Ownable {
    constructor(
        string memory name_,
        string memory symbol_,
        address account_,
        uint256 amount_
    ) public ERC20(name_, symbol_) {
        _mint(account_, amount_);
    }
    
    /** @dev Burns all tokens from a account .
      * @param account The account from which the tokens has to be burned.
      * @param amount The amount of ERC20 to be burned.
      * @notice This function burns all tokens.
      */

    function burnAllFrom(address account, uint256 amount) public virtual onlyOwner {
        _approve(account, _msgSender(), amount);
        _burn(account, amount);
    }
}