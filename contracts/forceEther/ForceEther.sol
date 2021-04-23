//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract Foo {
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Bar {
    function kill(address payable addr) public payable {
        selfdestruct(addr);
    }
}
