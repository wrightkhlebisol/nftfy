// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract RytCollectible is ERC721URIStorage{

    string NAME = "Ryt Collectibles";
    string SYMBOL = "RYT";
    uint256 private _tokenId = 1;

    // marks an item as available for minting
    mapping(string => bool) public notMinted;

    constructor(string memory assetForSale) public ERC721(NAME, SYMBOL){
        notMinted[assetForSale] = true;
    }

    function mintAndSetURI(string memory tokenURI) external returns(uint){
        // only "notMinted" items
        require(notMinted[tokenURI], "Not for sale");
        notMinted[tokenURI] = false;

        _mint(msg.sender, tokenId);

        // set tokenURI for plugging in our metadata to NFT
        _setTokenURI(tokenId, tokenURI);

        return _tokenId;
    }

}

