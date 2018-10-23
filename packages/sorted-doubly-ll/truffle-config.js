'use strict';

const KeystoreProvider = require("truffle-keystore-provider")
const Web3 = require("web3")

const memoizeProviderCreator = () => {
  let keystoreProviders = {}

  return (account, dataDir, providerUrl, readOnly) => {
      if (readOnly) {
          return new Web3.providers.HttpProvider(providerUrl)
      } else {
          if (providerUrl in keystoreProviders) {
              return keystoreProviders[providerUrl]
          } else {
              const provider = new KeystoreProvider(account, dataDir, providerUrl)
              keystoreProviders[providerUrl] = provider
              return provider
          }
      }
  }
}

const createProvider = memoizeProviderCreator()

module.exports = {
  networks: {
    local: {
      host: 'localhost',
      port: 9545,
      gas: 8000000,
      network_id: '*'
    },
    rinkeby: {
      provider: () => {
        return createProvider(process.env.RINKEBY_ACCOUNT, process.env.DATA_DIR, "https://rinkeby.infura.io", process.READ_ONLY)
      },
      network_id: 4,
      gas: 8000000
    },
    kovan: {
      provider: () => {
        return createProvider(process.env.KOVAN_ACCOUNT, process.env.DATA_DIR, "https://kovan.infura.io", process.READ_ONLY)
      },
      network_id: 42,
      gas: 8000000
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};