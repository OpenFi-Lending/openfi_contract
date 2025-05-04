// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {DIAIntegrationTemplate} from './DIAIntegrationTemplate.sol';
import {Errors} from '../../protocol/libraries/helpers/Errors.sol';
import {IACLManager} from '../../interfaces/IACLManager.sol';
import {IPoolAddressesProvider} from '../../interfaces/IPoolAddressesProvider.sol';

interface IPriceOracleGetter {
  /**
   * @notice Returns the asset price in the base currency
   * @param asset The address of the asset
   * @return The price of the asset
   */
  function getAssetPrice(address asset) external view returns (uint256);
}


contract DIAIntegrationOracle is IPriceOracleGetter {
    IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;

    // Map of asset price sources (asset => priceSource)
    mapping(address => DIAIntegrationTemplate) private assetsSources;

    constructor(
        IPoolAddressesProvider provider,
        address[] memory assets,
        address[] memory sources
    ) {
        ADDRESSES_PROVIDER = provider;
        _setAssetsSources(assets, sources);
    }

    /**
     * @dev Only asset listing or pool admin can call functions marked by this modifier.
     */
    modifier onlyAssetListingOrPoolAdmins() {
        _onlyAssetListingOrPoolAdmins();
        _;
    }

    function _onlyAssetListingOrPoolAdmins() internal view {
        IACLManager aclManager = IACLManager(ADDRESSES_PROVIDER.getACLManager());
        require(
        aclManager.isAssetListingAdmin(msg.sender) || aclManager.isPoolAdmin(msg.sender),
        Errors.CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN
        );
    }

    function setAssetSources(
        address[] calldata assets,
        address[] calldata sources
    ) external onlyAssetListingOrPoolAdmins {
        _setAssetsSources(assets, sources);
    }
    
    function _setAssetsSources(address[] memory assets, address[] memory sources) internal {
        require(assets.length == sources.length, Errors.INCONSISTENT_PARAMS_LENGTH);
        for (uint256 i = 0; i < assets.length; i++) {
        assetsSources[assets[i]] = DIAIntegrationTemplate(sources[i]);
        }
    }

    function getAssetPrice(address asset) public view override returns (uint256) {
        DIAIntegrationTemplate source = assetsSources[asset];
        if (address(source) == address(0)) {
            return 0;
        } else {
            return source.latestAnswer();
        }
    }

}