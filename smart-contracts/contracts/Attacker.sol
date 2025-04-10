// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vulnerable.sol";

contract Attacker {
    Vulnerable public vul;
    address public owner;

    constructor(address _vulnerableAddress) {
        vulnerable = Vulnerable(_vulnerableAddress);
        owner = msg.sender;
    }
}