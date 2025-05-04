// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

interface IDIAOracleV2{
    function getValue(string memory) external view returns (uint128, uint128);
}

contract DIAIntegrationTemplate {
    address public ORACLE;
    string  public _KEY_;
    uint128 public latestPrice; 
    uint128 public timestampOflatestPrice;

    constructor(string memory key, address oracle) {
        _KEY_ = string.concat(key, "/USD");
        ORACLE = oracle;
    }

    function getPriceInfo(string memory key) external returns (uint128, uint128){
        (latestPrice, timestampOflatestPrice) = IDIAOracleV2(ORACLE).getValue(key);
        return (latestPrice, timestampOflatestPrice);
    }

    function latestAnswer() external view returns (uint128) {
        uint128 price;
        (price,) = IDIAOracleV2(ORACLE).getValue(_KEY_);
        return price;
    }
   
    function checkPriceAge(uint128 maxTimePassed) external view returns (bool inTime){
         if((block.timestamp - timestampOflatestPrice) < maxTimePassed){
             inTime = true;
         } else {
             inTime = false;
         }
    }

    function aggregator() external view returns (address) {
        return address(this);
    }
}