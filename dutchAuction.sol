// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1 ;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract dutchAuction  {
    address private owner;
    address payable public immutable seller;
    uint public immutable Price;
    bool public immutable hasExpiry;
    uint public immutable expiresAt;
    IERC20 private tokenAddress;
    
    /** @dev Constructor to set some constant values .
      * @param _Price The price of 1 token in eth (Price = 1 means 0.001 eth).
      * @param _hasExpiry A boolean value that will tell if the auction has an expiry.
      * @param _DURATION The duration after which auction will end.
      * @param _tokenAddress The address of the ERC20 token contract.
      */
    constructor(
        uint _Price,
        bool _hasExpiry,
        uint _DURATION,
        IERC20 _tokenAddress
    ) {
        seller = payable(msg.sender);
        Price = _Price * 10 ** 15 ;
        expiresAt = block.timestamp + (_DURATION * 1 days);
        tokenAddress = _tokenAddress ;
        owner = msg.sender;
        hasExpiry = _hasExpiry;
    }
    
    /** @dev Buy the token .
      * @param amount The amount of ERC20 to be transfered.
      * @param from Address of the owner's wallet.
      * @param to Address of the buyer's wallet.
      * @notice This function transfers tokens from the owner's wallet to another
      * wallet while taking a charge of Price per token .
      */

    function buyToken(uint amount , address from , address to) external payable {
        if(hasExpiry){
        require(block.timestamp < expiresAt , "This auction has ended");
        } else {
        uint amt =  Price * amount ;
        require(msg.value >= amt, "The amount of ETH sent is less than the price of token");
        tokenAddress.approve(from, amount * 10 ** 18);
        tokenAddress.transferFrom(from, to, amount * 10 ** 18);  
        uint refund = msg.value - amt;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
           }
        } 
    }
    
    /** @dev Withdraw from this contract .
      * @param amount The amount of ERC20 to be burned.
      * @param amount The amount of ERC20 to be burned.
      * @notice This function transfers eth.
      */

    function withdraw(uint amount, address payable destAddr) public {
        require(msg.sender == owner, "Only owner can withdraw funds"); 
        require(amount <= address(this).balance, "Insufficient funds");
        destAddr.transfer(amount);
    }
}