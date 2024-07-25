require('dotenv').config({ path: './Teste.env' });
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: {
    version: "0.8.24", // Versão principal
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    },
    overrides: {
      "contracts/Lock.sol": {
        version: "0.8.24",
        settings: {}
      },
      "contracts/NFT.sol": {
        version: "0.8.24",
        settings: {}
      },
      // Adicione outras versões conforme necessário
      "@openzeppelin/contracts/*": {
        version: "0.8.20",
        settings: {}
      }
    }
  },
  networks: {
    bsctestnet: {
      url: process.env.BSC_TESTNET_URL,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
