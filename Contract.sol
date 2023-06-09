pragma solidity >=0.6.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//URIStorage for storing metadata, Enumerable for enumerating through indexes and ids, Royalty for setting royalty fees, Ownable to allow minting only to owner
contract SuperOwl is ERC721URIStorage, ERC721Enumerable, ERC721Royalty, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("SuperOwl", "SuperOwl") {
    // set royalty at 10% for all minted NFTs, expressed in basis points
        _setDefaultRoyalty(msg.sender, 1000);
    }
    // Mint NFT:
    function awardItem(address player, string memory tokenURIlink) public onlyOwner returns (uint256)                
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        // Set metadata:
        _setTokenURI(newItemId, tokenURIlink);

        return newItemId;
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721,ERC721URIStorage) returns (string memory){
        return super.tokenURI(tokenId);
    }


    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721,ERC721Royalty,ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
    function _burn(uint256 tokenId) internal virtual override(ERC721,ERC721URIStorage,ERC721Royalty) {
        super._burn(tokenId);
        _resetTokenRoyalty(tokenId);
    }    

        function _beforeTokenTransfer(
        address from,
        address to,
        uint256 firstTokenId,
        uint256 batchSize
    ) internal virtual override(ERC721,ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, firstTokenId, batchSize);

    }
 
}
