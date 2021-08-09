// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract TransferProxy {
    function erc721safeTransferFrom(
        IERC721 token,
        address from,
        address to,
        uint tokenId
    ) external {
        token.safeTransferFrom(from, to, tokenId);
    }

    function erc1155safeTransferFrom(
        IERC1155 token,
        address _from,
        address _to,
        uint _id,
        uint _value,
        bytes calldata _data
    ) external {
        token.safeTransferFrom(_from, _to, _id, _value, _data);
    }
}