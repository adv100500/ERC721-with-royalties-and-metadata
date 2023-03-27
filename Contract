pragma solidity >=0.6.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AngryOwl is ERC721URIStorage, ERC721Royalty, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address payable royaltiesAddress;

    constructor() ERC721("AngryOwl", "AngryOwl") {
        _setDefaultRoyalty(msg.sender, 1000);
    }

    function awardItem(address player, string memory tokenURIlink) public onlyOwner returns (uint256)                
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURIlink);

        return newItemId;
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721,ERC721URIStorage) returns (string memory){
        return super.tokenURI(tokenId);
    }


    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721,ERC721Royalty) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
    function _burn(uint256 tokenId) internal virtual override(ERC721URIStorage,ERC721Royalty) {
        super._burn(tokenId);
        _resetTokenRoyalty(tokenId);
    }    
 
}
