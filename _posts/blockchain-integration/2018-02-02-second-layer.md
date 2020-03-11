---
date: 2018-02-07
title: Second Layer Blockchain
description: Use the Matic sidechain in your scene to enable much faster and cheaper blockchain transactions.
categories:
  - blockchain-integration
type: Document
set: blockchain-integration
set_order: 8
---

Any transaction that affects the blockchain takes time to complete, and costs gas. Both these things are obstacles to making blockchain gaming popular, because players usually don't have the patience to wait that long for their actions to take effect, and aren't willing to spend money on many transactions as they play.

A common workaround is to keep most of the game-play off-chain, and only carry out blockchain transactions for key events, like earning a game item or registering a high score.

However, another way to overcome these limitations, as well as other scalability issues that are inherent to blockchains, is to rely on a _second layer_ blockchain, also called a _side_chain_.

A second layer is another blockchain that sits as an intermediary between a decentralized app and the main chain, this layer is more lightweight and can therefore provide faster responses and at a much lower gas cost.

Instead of making transactions directly into the main chain, transactions are done on the side chain, and then it's the duty of the side-chain to eventually sync these changes with the main chain.

The side-chain is able to provide faster responses because it's a smaller network with less nodes. The transactions that are carried out in the second layer are initially less secure, but they are eventually committed to the main chain in bulks, and all of the security checks of the main chain can be enforced there.

The side chain is also able to lower individual transaction costs significantly because it groups many transactions into a single one when syncing with the main chain. So the gas that would need to be payed for one transaction on the main chain can be divided over several thousand transactions.

Also, when syncing with the mainchain, several redundant transactions can be avoided entirely, further reducing transaction costs. For example, if Alice transfers 1 Eth to Bob, and then Bob transfers 1 Eth to Carol, then those two transactions can be simplified into one, by registering that Alice transfers directly to Carol.

Decentraland has a partnership with [Matic](https://matic.network/), who provide their own side chain on Ethereum. Their side chain can be used by scenes to support fast and very cheap transactions.

In order to use Matic, players must set their Metamask account up to use Matic network. This adds some friction to the process, but the usability of this experience should improve over time.

## Add Matic support to a scene

To easily make use of the Matic sidechain in your scene, you can leverage the free `decentral-api`, created by [Decentral.io](https://decentral.io).

You can read all about how to implement it in your scene in [their documentation page](https://www.decentral.io/docs/dcl/overview/).

## Test Matic in a scene

In order to use the Matic testnet, you should first have:

- Ether in Ropsten network. You can obtain it for free from various external faucets like [this one](https://faucet.ropsten.be/).

- MANA in Ropsten network. You can obtain it for free here [MANA faucet](https://faucet.decentraland.today/).

Then you must configure your Metanask account to include the Matic Testnet.

To do this:

1. Switch networks on Metamask by clicking on the name of the current network and select _Custom RPC_ at the bottom of the dropdown.
2. Fill in 'Matic Testnet' as _Network name_ and _https://testnet2.matic.network_ as _New RPC URL_
3. Click 'Save' to add this new network to Metamask

Decentral.io has a great step by step wizard to help you configure this. You can find it by goig [here](https://decentral.games/) and clicking on _Play Now_.
