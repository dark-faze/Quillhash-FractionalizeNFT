// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1 ;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./FractionalizedERC20.sol";

/** @title NFT Fractionalize */
contract Fractionalize is IERC721Receiver {
    address public nftAddress;
    mapping(uint256 => address) public erc20s;
    
    /* nft's contract address will be stored 
       in nftAddress.
     */
    constructor(address _nft) {
        nftAddress = _nft;
    }
    
    /** @dev Locks an nft and mints ERC20 tokens.
      * @param tokenId The tokenId of the corresponding NFT from the contract.
      * @param amount The amount of ERC20 to be minted.
      * @notice This function transfers the NFT from msg.sender to this contract,
      * then mints ERC20 tokens . ( Locking just means that the nft can't be sent to 
      * another address whithout calling unlockAndRedeem.
      */

    function lockAndMint(
        uint256 tokenId, 
        uint256 amount
        ) public {

        require(erc20s[tokenId] == address(0), "exists");
        IERC721(nftAddress).safeTransferFrom(msg.sender, address(this), tokenId);
        FractionalizedERC20 erc20 = new FractionalizedERC20("Fractionalized NFT", "frNFT", msg.sender, amount* 10 ** 18);
        erc20s[tokenId] = address(erc20);
    }

     /** @dev Unlocks an nft and burns ERC20 tokens.
      *  @param tokenId The tokenId of the corresponding NFT from the contract.
      *  @notice This function transfers the NFT from this contract to msg.sender ,
      *  then burns his ERC20 tokens which should be the total supply that was minted before.
      */

    function unlockAndRedeem(uint256 tokenId) public {
        address erc20 = erc20s[tokenId];
        require(erc20 != address(0), "nft not locked");
        uint256 totalSupply = FractionalizedERC20(erc20).totalSupply();
        require(totalSupply != 0, "totalSupply should not be zero");

        delete erc20s[tokenId];
        FractionalizedERC20(erc20).burnAllFrom(msg.sender, totalSupply);
        IERC721(nftAddress).safeTransferFrom(address(this), msg.sender, tokenId);
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}