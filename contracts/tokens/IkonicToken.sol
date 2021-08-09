// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract IkonicToken is ERC20 {
    using SafeMath for uint256;

    uint256 private _totalSupply;
    uint8 public _decimals = 18;
    string public _name = 'Ikonic Token';
    string public _symbol = 'IKONIC';

    constructor() ERC20(_name, _symbol) {
        _totalSupply = 15 * 10e8 * 10e18; // 1.5B
        _mint(msg.sender, _totalSupply);
    }

    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }
}
