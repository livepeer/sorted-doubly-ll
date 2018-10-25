# Fundraising Leaderboard _fundraising-leaderboard_

> An example application using the sorted doubly linked list EVM package to implement a bare bones fundraiser that tracks top contributors.

> Note: This project is purely for demonstration purposes.

## Build

Install [zos](https://github.com/zeppelinos/zos)

```sh
npm install -g zos
```

## Testing

```sh
npm run test
```

# Deploying

Push project to a local network

```sh
zos push --deploy-dependencies --network local
```

Publish project to a local network

```sh
zos publish --network local
```

Create an instance of the FundraisingLeaderboard contract for the published project on a local network

```sh
zos create FundraisingLeaderboard --init initialize --args <APP_ADDRESS> <BENEFICIARY_ADDRESS> <MAX_CONTRIBUTORS> --network local
```