// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Satisfies vToken's initializer parameter requirement. Exploit.sol doesn't interact with DummyAsset
contract DummyAsset {
    // Can be completely empty if not used by vToken
}
