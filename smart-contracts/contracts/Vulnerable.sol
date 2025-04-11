// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable {

    mapping(address => uint256) public balances;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // You can define this function to return the contract's address explicitly
    function getAddress() public view returns (address) {
        return address(this);
    }

    // This is the vulnerable donate function
    function donate() external payable {
        balances[msg.sender] += msg.value;
    }

    // Vulnerable withdraw function
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Not the owner");
        // This is the vulnerability: Transfer without updating state first!
        payable(owner).transfer(amount);
    }

    receive() external payable {}

    // Temporary function to change ownership (for testing purposes)
    function setOwner(address newOwner) external {
        require(msg.sender == owner, "Not the owner");
        owner = newOwner;
    }
}
