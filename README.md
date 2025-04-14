# Solidity
Task 2: Proof of Concept Exploit

Recreate the vulnerability described in the GitHub issue mentioned earlier (code-423n4/2022-04-phuture-findings issue #19).

## Goal:
The objective of this task is to recreate the vulnerability described in the GitHub issue code-423n4/2022-04-phuture-findings issue #19. Specifically, the goal is to demonstrate how Attacker (Bob) can exploit the minting permission of Miner (Alice) by successfully calling vToken.mint() before Alice, thereby minting tokens using Alice’s asset.

## SETUP

1. Clone https://github.com/s0phia-le/Solidity.git on Remix IDE
2. Compile these files in this exact order: 
   - DummyAsset.sol
   - DummyRegistry.sol
   - vToken.sol
   - Exploit.sol 

## DEPLOYMENT

1. Deploy the following contracts: DummyAsset.sol, DummyRegistry.sol, and vToken.sol
2. Copy the addresses of the deployed contracts and paste them into the parameters required to deploy Exploit.sol
3. Under the deployed vToken contract, call grantRole with DEFAULT_ADMIN_ROLE hash listed below and the address of Exploit.sol to grant Exploit the admin permission
4. Under the deployed Exploit contract, call stageOne and stageTwo in order to execute the exploit.


## ROLE IDENTIFIERS

DEFAULT_ADMIN_ROLE = 0x0000000000000000000000000000000000000000000000000000000000000000

INDEX_ROLE = 0x766aece2fe0909e4a1f0fe06a20b32886c389ee499ca4246e7e1b80b53562a84


## StageTwo Revert Error for vToken Minting Vulnerability:
The goal of StageTwo was to demonstrate the exploit where Attacker (Bob) calls vToken.mint() before Miner (Alice), successfully exploiting Alice’s asset and minting permission. This vulnerability was detailed in the GitHub issue code-423n4/2022-04-phuture-findings issue #19. 

## EXPLOIT OUTLINE & PROGRESS:
I successfully understood the general vulnerability in the smart contract’s vToken.mint() function, where the minting logic can be exploited by Attacker (Bob) if they act before Alice in a certain sequence of calls.

To set the stage, I managed to reproduce the scenario where Alice calls createOrReturnVTokenOf() with her asset, which was correctly linked to the vToken. This set up the correct context for testing the minting function.

## CHALLENGES FACED:
The exploit relies heavily on timing and sequence of operations. While the exploit's theory works, executing it within the constraints of the testing environment was difficult. Since Remix IDE does not provide full control over asynchronous transactions in the same way as a local development setup might, ensuring that Bob’s mint call was processed before Alice’s was not straightforward.

The vToken contracts and the supporting contracts (like Alice’s asset) were complex to interact with in an exploit scenario. Some of the functions related to minting and asset management required careful sequencing, which I was not able to execute fully in the time available.

## WHY I DIDN'T FINISH:
Due to the tight time frame and the complexity of orchestrating the sequence of calls to trigger the exploit, I was not able to fully complete the exploit demonstration in a working script. The main challenge was the lack of synchronization between Alice’s and Bob’s calls in the Remix IDE environment, where race conditions are harder to simulate.

While I was able to integrate and test the key components of the exploit, the actual minting vulnerability was dependent on conditions I was unable to simulate perfectly due to missing integration between vToken contract and Alice's asset context.

## CONCLUSION:
The exploit scenario works theoretically and is close to being fully functional. However, the main issue lies in correctly simulating the timing of the transactions between Alice and Bob.

If given more time, I would focus on setting up a more controlled testing environment (potentially using Hardhat) to handle the asynchronous nature of the transactions and allow me to simulate race conditions more effectively.

Despite not completing the full exploit, I was able to make significant progress toward reproducing the vulnerability and identifying key areas where further adjustments could lead to a successful exploit demonstration.

