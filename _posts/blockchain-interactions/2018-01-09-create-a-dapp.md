---
date: 2018-01-01
title: Create a DApp
description: Reference for creating your own Decentralized App
redirect_from:
  - /decentraland/api/
categories:
  - blockchain-interactions
type: Document
set: blockchain-interactions
set_order: 9
---

You can create your own decentralized apps (Dapps) to interface with Decentraland's smart contracts and expose their functionality in more elaborate and friendlier ways.

## What is a Dapp

that call our smart contracts
A dapp can include a front end, a cache, or be just a plain call to the contracts

## Decentraland smart contracts

Decentraland has written and maintains a number of smart contracts that are meant to interact with LAND and MANA tokens.

This includes creating an estate out of several parcels, mortgaging parcels, and MANA itself is defined by a smart contract.

- [Decentraland smart contracts](https://contracts.decentraland.org/addresses.json):
  You can find a full list for each of our contracts and their addresses.

Note that each contract has a production version in _mainnet_ and a test version in _ropsten_ and that they each has a different address.

You can read the full code of each contract, as it's public information on the blockchain. For example, you can find the contract by name on [Etherscan](https://etherscan.io/contractsVerified) to read its contents.

## Dapp boilerplate code

- [Boilerplate code](https://github.com/decentraland/dapp-boilerplate): This Boilerplate code can be a great starting point for building your own Dapp.

## Helper libraries

While building our own Dapps internally, we put together some helper libraries that you might also find useful.

- [Decentraland-eth](https://github.com/decentraland/decentraland-eth): This is a low level library with utility functions to work with the Ethereum blockchain.

- [Decentraland-dapps](https://github.com/decentraland/decentraland-dapps): This is a higher level library with common modules for Dapps. The modules in this library are built using `Decentraland-eth`.

## Sample Dapps

Below are links to the full code of several Dapps that we built, these might help you build your own:

- [Canilla](https://github.com/decentraland/canilla): This simple Dapp provides free Ropsten MANA.

- [Gate](https://github.com/decentraland/gate): This Dapp simple Dapp adds a token to your wallet that whitelists you and certifies that you can use the Decentraland client.

- [Marketplace](https://github.com/decentraland/marketplace): This is the full application that runs the Decentraland [Marketplace](https://market.decentraland.org/)

## Dapp testing framework

To test your Dapp before launching it into production, we recommend testing it first.

- [Dappeteer](https://github.com/decentraland/dappeteer): We put this framework together to help you run tests on your Dapp.
