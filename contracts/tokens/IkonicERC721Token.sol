// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

import "./ERC721Base.sol";

/**
 * @title IkonicERC721Token
 * @dev anyone can mint token.
 */
contract IkonicERC721Token is
    IERC721,
    IERC721Metadata,
    ERC721Burnable,
    ERC721Base,
    Ownable
{
    using ECDSA for bytes32;

    /**
     * @dev Constructor Function
     * @param _name name of the token ex: Rarible
     * @param _symbol symbol of the token ex: RARI
     * @param _contractURI URI of contract ex: https://api-mainnet.rarible.com/contractMetadata/{address}
     * @param _baseURI ex: https://ipfs.ikonic.com
    */
    constructor(
        string memory _name,
        string memory _symbol,
        string memory _contractURI,
        string memory _baseURI
    ) ERC721Base(_name, _symbol, _contractURI, _baseURI) {
        _registerInterface(bytes4(keccak256("MINT_WITH_ADDRESS")));
    }

    function mint(
        uint256 _tokenId,
        Fee[] memory _fees,
        string memory _tokenURI
    ) public {
        _mint(msg.sender, _tokenId, _fees);
        _setTokenURI(_tokenId, _tokenURI);
    }

    function setBaseURI(string memory _baseURI) public onlyOwner {
        _setBaseURI(_baseURI);
    }

    function setContractURI(string memory _contractURI) public onlyOwner {
        _setContractURI(_contractURI);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Base, ERC721, IERC165) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
