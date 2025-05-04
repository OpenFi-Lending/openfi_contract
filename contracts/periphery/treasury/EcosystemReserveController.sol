// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Ownable} from '../../dependencies/openzeppelin/contracts/Ownable.sol';
import {IStreamable} from './interfaces/IStreamable.sol';
import {IAdminControlledEcosystemReserve} from './interfaces/IAdminControlledEcosystemReserve.sol';
import {IEcosystemReserveController} from './interfaces/IEcosystemReserveController.sol';
import {IERC20} from '../../dependencies/openzeppelin/contracts/IERC20.sol';

contract EcosystemReserveController is Ownable, IEcosystemReserveController {
  /**
   * @notice Constructor.
   * @param GovShortTimelock The address of the Aave's governance executor, owning this contract
   */
  constructor(address GovShortTimelock) {
    transferOwnership(GovShortTimelock);
  }

  /// @inheritdoc IEcosystemReserveController
  function approve(
    address collector,
    IERC20 token,
    address recipient,
    uint256 amount
  ) external onlyOwner {
    IAdminControlledEcosystemReserve(collector).approve(token, recipient, amount);
  }

  /// @inheritdoc IEcosystemReserveController
  function transfer(
    address collector,
    IERC20 token,
    address recipient,
    uint256 amount
  ) external onlyOwner {
    IAdminControlledEcosystemReserve(collector).transfer(token, recipient, amount);
  }

  /// @inheritdoc IEcosystemReserveController
  function createStream(
    address collector,
    address recipient,
    uint256 deposit,
    IERC20 tokenAddress,
    uint256 startTime,
    uint256 stopTime
  ) external onlyOwner returns (uint256) {
    return
      IStreamable(collector).createStream(
        recipient,
        deposit,
        address(tokenAddress),
        startTime,
        stopTime
      );
  }

  /// @inheritdoc IEcosystemReserveController
  function withdrawFromStream(
    address collector,
    uint256 streamId,
    uint256 funds
  ) external onlyOwner returns (bool) {
    return IStreamable(collector).withdrawFromStream(streamId, funds);
  }

  /// @inheritdoc IEcosystemReserveController
  function cancelStream(address collector, uint256 streamId) external onlyOwner returns (bool) {
    return IStreamable(collector).cancelStream(streamId);
  }
}
