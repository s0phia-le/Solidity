// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable {
    mapping(address => uint256) public balances;

    function donate() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");

        // Vulnerable line: seting ETH before updating balance
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Ether");
        balances[msg.sender] -= amount;
    }
}