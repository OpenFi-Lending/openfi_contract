// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {IIncentivesController} from '../../interfaces/IIncentivesController.sol';

contract MockIncentivesController is IIncentivesController {
  function handleAction(address, uint256, uint256) external override {}
}
