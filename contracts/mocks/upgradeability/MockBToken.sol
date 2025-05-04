// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {BToken} from '../../protocol/tokenization/BToken.sol';
import {IPool} from '../../interfaces/IPool.sol';

contract MockBToken is BToken {
  constructor(IPool pool) BToken(pool) {}

  function getRevision() internal pure override returns (uint256) {
    return 0x2;
  }
}
