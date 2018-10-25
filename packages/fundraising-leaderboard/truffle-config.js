'use strict';

module.exports = {
  networks: {
    local: {
      host: 'localhost',
      port: 8545,
      gasPrice: 10e9,
      network_id: '*'
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
}