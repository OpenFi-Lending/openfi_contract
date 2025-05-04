// import * as dotenv from "dotenv";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
require("dotenv").config();

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.8.13",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      },
    ]
  },
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true,
    },
    pharosdev: {
      url: "https://devnet.dplabs-internal.com",
      accounts: [process.env.PRIVATE_KEY || ""],
      gas: 5000000,
    },
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
    bob: { default: 1 },
    alice: { default: 2 },
    sam: { default: 3 },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: {
    },
    customChains: [
    ]
  },
  mocha: {
    timeout: 0,
    bail: true,
  },
  sourcify: {
    enabled: false
  },
};

export default config;
