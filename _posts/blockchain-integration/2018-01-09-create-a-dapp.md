---
date: 2018-01-01
title: Create a dApp
description: Reference for creating your own Decentralized App
categories:
  - blockchain-integration
type: Document
redirect_from:
  - /blockchain-interactions/create-a-dapp
---

You can create your own decentralized apps (dApps) to interface with Decentraland's smart contracts and expose their functionality in more elaborate and friendlier ways.

## What is a dApp

A decentralized application, or dApp, is one that runs on a distributed peer to peer network rather than from a central server.

In the context of blockchain, a dApp uses smart contracts and possibly a P2P network, instead of a Web API service. A dApp may also expose a front end and cache information from the blockchain temporarily, but its output is ultimately reflected on-chain.

See [this site](https://blockchainhub.net/decentralized-applications-dapps/) for a more complete overview about dApps.

## Decentraland smart contracts

Decentraland has written and maintains a number of smart contracts that interact with LAND and MANA tokens.

LAND and MANA tokens themselves are defined by the _LANDregistry_ and _MANAtoken_ contracts respectively. The list also includes more specific contracts like creating an estate out of several parcels or mortgaging parcels.

- [Decentraland smart contracts](https://contracts.decentraland.org/addresses.json):
  You can find a full list of each of our contracts and their addresses.

Note that each contract has a production version in _mainnet_ and a test version in _ropsten_ and that each has a different address.

You can read the full code of each contract, as it's public information on the blockchain. For example, you can find the contract by name on [Etherscan](https://etherscan.io/contractsVerified) to read its contents.

## dApp boilerplate code

- [Boilerplate code](https://github.com/decentraland/dapp-boilerplate): This Boilerplate code can be a great starting point for building your own dApp.

## Helper libraries

While building our own dApps internally, we put together some helper libraries that you might also find useful.

- [Decentraland-eth](https://github.com/decentraland/decentraland-eth): This is a low level library with utility functions to work with the Ethereum blockchain.

- [Decentraland-dapps](https://github.com/decentraland/decentraland-dapps): This is a higher level library with common modules for dApps. The modules in this library are built using `Decentraland-eth`.

- [Decentraland UI](https://ui.decentraland.org/): This library contains a selection of reusable UI elements that are included in Decentraland's projects.

## Sample dApps

Below are links to the full code of several dApps that we built around Decentraland, these might help you build your own:

- [Canilla](https://github.com/decentraland/canilla): This basic dApp provides free Ropsten MANA.

- [Gate](https://github.com/decentraland/gate): This basic dApp creates an invitation NFT that was used when Decentraland was in a closed beta stage. In the early days, whitelisted players that held this NFT were the only ones able to enter the metaverse.

- [Marketplace](https://github.com/decentraland/marketplace): This is the full application that runs the Decentraland [Marketplace](https://market.decentraland.org/). To make it run fast, it requires a database and a backend server connected to the Ethereum network to create indexes with information about LAND.

## dApp testing framework

Before launching your dApp into production, we recommend testing it first.

- [dAppeteer](https://github.com/decentraland/dappeteer): We put this framework together to help you run tests on your dApp.
