// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable {
    mapping(address => uint256) public balances;

    function donate() external payable {
        balances[msg.sender] += msg.value;
    }
}