// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./HasContractURI.sol";
import "./HasSecondarySaleFees.sol";
import "./HasSecondarySale.sol";

/**
 * @title Full ERC721 Token with support for baseURI
 * This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
abstract contract ERC721Base is
    HasSecondarySaleFees,
    HasSecondarySale,
    ERC721,
    HasContractURI
{
    // Token name
    // Now in openzeppelin ERC721
    // string public override name;

    // Token symbol
    // Now in openzeppelin ERC721
    // string public override symbol;

    using SafeMath for uint256;

    struct Fee {
        address payable recipient;
        uint256 value;
    }

    // id => fees
    mapping(uint256 => Fee[]) public fees;

    /// @dev sale is primary or secondary
    mapping(uint256 => bool) public isSecondarySale;

    // Max count of fees
    uint256 maxFeesCount = 100;

    // Optional mapping for token URIs
    mapping (uint256 => string) private _tokenURIs;

    // Base URI
    string private _baseURIextended;

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor(
        string memory _name,
        string memory _symbol,
        string memory contractURI,
        string memory _baseURI
    ) HasContractURI(contractURI) ERC721(_name, _symbol) {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
        _setBaseURI(_baseURI);
    }

    function getFeeRecipients(uint256 id)
        public
        view
        override
        returns (address payable[] memory)
    {
        Fee[] memory _fees = fees[id];
        address payable[] memory result = new address payable[](_fees.length);
        for (uint256 i = 0; i < _fees.length; i++) {
            result[i] = _fees[i].recipient;
        }
        return result;
    }

    function getFeeBps(uint256 id) public view override returns (uint256[] memory) {
        Fee[] memory _fees = fees[id];
        uint256[] memory result = new uint256[](_fees.length);
        for (uint256 i = 0; i < _fees.length; i++) {
            result[i] = _fees[i].value;
        }
        return result;
    }

    function checkSecondarySale(uint256 id) public view override returns(bool) {
        return isSecondarySale[id];
    }

    function setSecondarySale(uint256 id) public override {
        isSecondarySale[id] = true;
    }

    function _mint(
        address to,
        uint256 tokenId,
        Fee[] memory _fees
    ) internal {
        require(
            _fees.length <= maxFeesCount,
            "Amount of fee recipients can't exceed 100"
        );

        uint256 sumFeeBps = 0;
        for (uint256 i = 0; i < _fees.length; i++) {
            sumFeeBps = sumFeeBps.add(_fees[i].value);
        }

        require(
            sumFeeBps <= 10000,
            "Total fee bps should not exceed 10000"
        );

        _mint(to, tokenId);
        address[] memory recipients = new address[](_fees.length);
        uint256[] memory bps = new uint256[](_fees.length);
        for (uint256 i = 0; i < _fees.length; i++) {
            require(
                _fees[i].recipient != address(0x0),
                "Recipient should be present"
            );
            require(_fees[i].value != 0, "Fee value should be positive");
            fees[tokenId].push(_fees[i]);
            recipients[i] = _fees[i].recipient;
            bps[i] = _fees[i].value;
        }
        if (_fees.length > 0) {
            emit SecondarySaleFees(tokenId, recipients, bps);
        }
    }

    /**
     * @dev Internal function to set the base URI for all token IDs. It is
     * automatically added as a prefix to the value returned in {tokenURI},
     * or to the token ID if {tokenURI} is empty.
     */
    function _setBaseURI(string memory baseURI_) internal virtual {
        _baseURIextended = baseURI_;
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC165Storage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}