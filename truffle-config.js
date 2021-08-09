const HDWalletProvider = require("@truffle/hdwallet-provider");
const secretTestnet = require("./secret.testnet.json");
const secretDevelopment = require("./secret.development.json");
require('dotenv').config();

module.exports = {
  networks: {
    development: {
      // provider: () =>
      //   new HDWalletProvider(
      //     secretDevelopment.mnemonic,
      //     `http://localhost:8545`
      //   ),
      host: "127.0.0.1", // Localhost (default: none)
      port: 8545, // Standard BSC port (default: none)
      network_id: "*", // Any network (default: none)
      timeoutBlocks: 400
    },
    rinkeby: {
      provider: () =>
        new HDWalletProvider(
          secretTestnet.mnemonic,
          process.env.INFURA_ID
        ),
      network_id: 4
      // timeoutBlocks: 400,
    }
  },
  compilers: {
    solc: {
      version: "^0.8.0",
      settings: {          // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: true,
          runs: 1
        }
      //  evmVersion: "byzantium"
      }
    }
  },

  plugins: [
    'truffle-plugin-verify'
  ],

  api_keys: {
    etherscan: process.env.ETHERSCAN_API_KEY
  }
};