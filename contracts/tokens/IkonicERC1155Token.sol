pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;
// SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

import "./ERC1155Base.sol";

contract IkonicERC1155Token is ERC1155Base {
    
    using ECDSA for bytes32;

    string public name;
    string public symbol;

    /**
     * @dev Constructor Function
     * @param _name name of the token ex: Rarible
     * @param _symbol symbol of the token ex: RARI
     * @param _contractURI URI of contract ex: https://api-mainnet.rarible.com/contractMetadata/{address}
     * @param _tokenURIPrefix token URI Prefix
     * @param _uri ex: https://ipfs.ikonic.com
    */
    constructor(string memory _name, string memory _symbol, string memory _contractURI, string memory _tokenURIPrefix, string memory _uri) ERC1155Base(_contractURI, _tokenURIPrefix, _uri) {
        name = _name;
        symbol = _symbol;

        _registerInterface(bytes4(keccak256('MINT_WITH_ADDRESS')));
    }

    function mint(uint256 _tokenId, Fee[] memory _fees, uint256 _supply, string memory _uri) public {
        _mint(_tokenId, _fees, _supply, _uri);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155Base) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}