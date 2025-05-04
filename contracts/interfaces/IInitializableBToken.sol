// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import {IIncentivesController} from './IIncentivesController.sol';
import {IPool} from './IPool.sol';

/**
 * @title IInitializableBToken
 * @author Aave
 * @notice Interface for the initialize function on BToken
 */
interface IInitializableBToken {
  /**
   * @dev Emitted when an bToken is initialized
   * @param underlyingAsset The address of the underlying asset
   * @param pool The address of the associated pool
   * @param treasury The address of the treasury
   * @param incentivesController The address of the incentives controller for this bToken
   * @param bTokenDecimals The decimals of the underlying
   * @param bTokenName The name of the bToken
   * @param bTokenSymbol The symbol of the bToken
   * @param params A set of encoded parameters for additional initialization
   */
  event Initialized(
    address indexed underlyingAsset,
    address indexed pool,
    address treasury,
    address incentivesController,
    uint8 bTokenDecimals,
    string bTokenName,
    string bTokenSymbol,
    bytes params
  );

  /**
   * @notice Initializes the bToken
   * @param pool The pool contract that is initializing this contract
   * @param treasury The address of the Aave treasury, receiving the fees on this bToken
   * @param underlyingAsset The address of the underlying asset of this bToken (E.g. WETH for aWETH)
   * @param incentivesController The smart contract managing potential incentives distribution
   * @param bTokenDecimals The decimals of the bToken, same as the underlying asset's
   * @param bTokenName The name of the bToken
   * @param bTokenSymbol The symbol of the bToken
   * @param params A set of encoded parameters for additional initialization
   */
  function initialize(
    IPool pool,
    address treasury,
    address underlyingAsset,
    IIncentivesController incentivesController,
    uint8 bTokenDecimals,
    string calldata bTokenName,
    string calldata bTokenSymbol,
    bytes calldata params
  ) external;
}
