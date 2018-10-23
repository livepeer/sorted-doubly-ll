'use strict';

module.exports = {
  networks: {
    local: {
      host: 'localhost',
      port: 9545,
      gas: 8000000,
      network_id: '*'
    },
    ganache: {
      host: 'localhost',
      port: 8545,
      gas: 8000000,
      network_id: '*'
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};