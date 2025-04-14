// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";
import "contracts/interfaces/IIndexRegistry.sol";

/// @title DummyRegistry
/// @notice A mock implementation that fulfills the interfaces of IAccessControl and IIndexRegistry for testing purposes.
/// @dev This contract provides stubbed-out logic to simulate expected behaviors without enforcing real permissions or logic.
contract DummyRegistry is ERC165, IAccessControl, IIndexRegistry {

    // === IAccessControl Dummy Implementations ===

    /// @notice Always returns true for any role and account.
    /// @dev Used to bypass access control checks in a test/mock setup.
    function hasRole(bytes32, address) external pure override returns (bool) {
        return true;
    }

    /// @notice Returns a dummy admin role (0x00) for any queried role.
    /// @dev This is a placeholder with no actual role hierarchy enforcement.
    function getRoleAdmin(bytes32) external pure override returns (bytes32) {
        return 0x00;
    }

    /// @notice Dummy grantRole function — does nothing.
    /// @dev Included only to satisfy the IAccessControl interface.
    function grantRole(bytes32, address) external pure override {}

    /// @notice Dummy revokeRole function — does nothing.
    /// @dev Included only to satisfy the IAccessControl interface.
    function revokeRole(bytes32, address) external pure override {}

    /// @notice Dummy renounceRole function — does nothing.
    /// @dev Included only to satisfy the IAccessControl interface.
    function renounceRole(bytes32, address) external pure override {}

    // === IIndexRegistry Dummy Implementations ===

    /// @notice Returns address(0) as the dummy index logic address.
    /// @dev Placeholder for index logic, used for mock purposes only.
    function indexLogic() external pure override returns (address) {
        return address(0);
    }

    /// @notice Dummy registerIndex function — does nothing.
    /// @dev Used to simulate index registration without storing any data.
    function registerIndex(address, IIndexFactory.NameDetails calldata) external pure override {}

    /// @notice Returns 0 as the maximum number of index components.
    /// @dev Meant to simulate a system with no support for components.
    function maxComponents() external pure override returns (uint) {
        return 0;
    }

    /// @notice Returns zeroed market caps for any input list and a total cap of 0.
    /// @param _assets List of asset addresses.
    /// @return An array of 0s for market caps and total market cap of 0.
    function marketCapsOf(address[] calldata _assets)
        external
        pure
        override
        returns (uint[] memory, uint)
    {
        uint[] memory empty = new uint[](_assets.length);
        return (empty, 0);
    }

    /// @notice Returns 0 as the dummy total market capitalization.
    /// @dev Used when no actual market cap data is needed.
    function totalMarketCap() external pure override returns (uint) {
        return 0;
    }

    /// @notice Returns address(0) as the dummy price oracle.
    /// @dev Used in mocks to satisfy dependency on a price oracle.
    function priceOracle() external pure override returns (address) {
        return address(0);
    }

    /// @notice Returns address(0) as the dummy orderer address.
    /// @dev Placeholder with no operational logic.
    function orderer() external pure override returns (address) {
        return address(0);
    }

    /// @notice Returns address(0) as the dummy fee pool.
    /// @dev Used in mocks to simulate fee pool dependency.
    function feePool() external pure override returns (address) {
        return address(0);
    }

    // === ERC165 Interface Support ===

    /// @notice Checks if the contract supports a given interface ID.
    /// @param interfaceId The interface identifier (as per ERC165).
    /// @return True if supported; otherwise, false.
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC165)
        returns (bool)
    {
        return interfaceId == type(IAccessControl).interfaceId ||
            interfaceId == type(IIndexRegistry).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    // === Custom Utility Function ===

    /// @notice Checks if the contract supports all the given interface IDs.
    /// @param interfaceIds Array of interface IDs to check.
    /// @return True if all interfaces are supported; otherwise, false.
    function supportsAllInterfaces(bytes4[] memory interfaceIds) external view returns (bool) {
        for (uint i = 0; i < interfaceIds.length; i++) {
            if (!supportsInterface(interfaceIds[i])) {
                return false;
            }
        }
        return true;
    }
}
