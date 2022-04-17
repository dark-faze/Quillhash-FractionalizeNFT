// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1 ;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721URIStorage {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  constructor() ERC721 ("FakeNFT", "TP") {}
  
  /**  @dev Mints an NFT.
    *  @param tokenURI I have used a url to a json for example.
    *  @notice Mints an NFT to the msg.sender's address.
    */

  function createToken(string memory tokenURI) public returns (uint) {
    _tokenIds.increment(); 
    uint256 newItemId = _tokenIds.current();

    _mint(msg.sender, newItemId);
    _setTokenURI(newItemId, tokenURI);
    return newItemId; 
  }
}