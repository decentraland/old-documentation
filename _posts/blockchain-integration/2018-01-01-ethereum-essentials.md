---
date: 2018-01-01
title: Ethereum essentials
description: How Decentraland uses the Ethereum blockchain.
categories:
  - blockchain-integration
type: Document
redirect_from:
  - /blockchain-interactions/ethereum-essentials
---

All blockchains are in essence decentralized databases that are distributed among the machines of a network. Transactions are grouped into “blocks” and processed sequentially to form a _chain_ of events.

Ethereum is one of the most popular blockchains. What sets it apart from others, such as Bitcoin, is that it uses the blockchain as storage for more than just a record of currency transactions. Ethereum can store more complex information to distinguish different kinds of tokens or even handle unique tokens with specific characteristics. The Ethereum blockchain also runs smart contracts, these allow to execute more complex transactions that can also depend on agreed upon events.

Decentraland uses the Ethereum blockchain to record the ownership of the digital assets, and other tradable items that can be read and reacted to by a 3D scene.

The blockchain isn’t used to store the scene state, player position or anything that needs to change in real time as a player interacts with a scene, all of that is either stored locally on each player's machine, or on a private server owned by the scene owner. The developers of each scene must choose what information is worth storing on the blockchain, and what to store in a private server.

## Wallets

Ethereum tokens are held by wallets. An Ethereum wallet can hold various tokens, including Ether, MANA, LAND, and other tokens that may be used by games or experiences in Decentraland.

There are many wallet providers where you can hold Decentraland tokens. To use the Marketplace, or to enter Decentraland, you must use a wallet that is integrated to your web browser, so we recommend that you use:

- [Metamask](https://metamask.io/)
- [Trezor](https://trezor.io/)/[Ledger](https://www.ledger.com/) hardware wallets

Every wallet has a public and a private key. The hash of your public key is your wallet’s unique address, used to route transactions and identify a player. Your private key is used by your wallet to sign each transaction that you send to the network and certify that it was truly sent by you. Your private key is also used to restore your wallet in case you forget your password, so keep it in a safe place and don’t share it with anyone.

In Decentraland, player identities are built around wallets. Since wallet public keys are unique, your scene can use them to identify a Decentraland user in a persistent way. Wallets can also hold different tokens that can give a player a unique avatar, a wearable item, permissions to enter scenes that choose to restrict access, a special weapon to use in a game, etc.

## Transactions

Transactions make changes to the information that’s stored in the blockchain. Typical transactions involve tokens changing owners, for example user A giving his LAND token to user B in exchange for an amount of MANA tokens. In the Ethereum network, however, a transaction can also mean changing the information that’s stored about a token without changing its owner. For example, changing the description of a parcel, or merging several parcels into an Estate.

All transactions that occur in Ethereum’s main chain have a cost that is paid in Ether tokens. This fee is referred to as the ‘gas’ fee, and it’s paid to the network user that ‘mines’ the transaction.

When you request a transaction to take place, you set the gas price that you’re willing to pay for the transaction to be mined. Transactions that offer higher prices get mined faster, since miners give these priority. Market prices for these transactions oscillate regularly, they tend to be more expensive when there is a higher usage of the network. Make sure that what you offer isn’t below the market price, otherwise your transaction could remain in an unprocessed pool indefinitely.

All transactions must be signed by an Ethereum address, using the addresse’s private key. This is what certifies that the transaction was carried out by that address.

#### Transaction validation

Blockchain transactions aren’t immediate, they require time to be “mined” by one of the nodes in the network, and then to be propagated throughout the rest of the machines. The more transactions that are being requested by the network, the more time they take to be validated.

In brief terms, this is how a transaction is validated:

1. A new transaction occurs, it goes into a pool of unconfirmed transactions.
2. One of the machines in the network successfully solves an algorithm to mine a new “block” containing a handful of transactions from this pool, including this one. It attaches this new block to the end of the chain.
3. The block is shared with other machines of the network. Each machine verifies that each transaction in a block is valid and checks the block’s hash to ensure it’s legitimate, then it adds it to its own version of the chain.
4. The new block is propagated throughout the whole network. There’s a universally shared understanding that this transaction has taken place.

#### Sidechains

Decentraland is partnering with [Matic](https://matic.network/) to create a _sidechain_ (a special kind of blockchain) that will be able to handle transactions faster and cheaper than the main Ethereum network. This sidechain will be ideal for in-game transactions, as changes can occur closer to real time and at a very low cost. For transactions that involve valuable items, we’ll still recommend the main Ethereum chain, as it will be more secure.

Each developer working on a scene will be able to choose whether to use the mainchain, the sidechain or a combination of both for different transactions.

The sidechain will be kept interoperable with the Ethereum’s mainchain. You’ll be able to load tokens from the main chain into the side chain and vice versa. Transactions that take place in the sidechain are eventually reflected in the mainchain when the tokens “exit” back into the mainchain.

Read more about this in [Second layer]({{ site.baseurl }}{% post_url /development-guide/2018-02-02-second-layer %}).

#### Trigger transactions from a scene

Your scene’s code can trigger transactions, both on the Ethereum mainchain and on Decentraland’s sidechain. You could have a store in your scene that sells tokens (like NFTs), or have a game that rewards game items to players that achieve certain goals.
The user must always approve these transactions explicitly on their Ethereum client. For example, when using Metamask, Metamask prompts the user to accept each transaction before it’s processed.
Read [game design doc] for more ideas about how to integrate a scene to the blockchain. See [blockchain operations] for instructions on how to implement these integrations.

## Types of tokens

Different types of tokens can be handled in the Ethereum network. A few standards have emerged that group tokens that share the same characteristics.

In Decentraland, you can use tokens to represent items that relate to your game or experience, such as a weapon or a trophy. As tokens are held in a player’s wallet, they accompany a player from scene to scene, so each scene can choose if and how they want to react to every existing kind of token.

Read [What are NFTs](https://decentraland.org/blog/technology/what-are-nfts/) on our blog for a more in-depth look at the emergence and evolution of non-fungible tokens.

#### Fungible tokens

If an item is fungible, then it can be substituted or exchanged for any similar item. Fiat currencies, like the US dollar, are fungible. One dollar bill can be exchanged for any other dollar bill.

Cryptocurrency tokens like Bitcoin, Ethereum, and MANA are all fungible because one token unit can be exchanged for any other token unit.

You could also create custom fungible tokens to use in Decentraland scenes and use them to depict items that are all equal and have no distinctive or customizable properties between them. You could, for example, create a game that revolves around collecting a large quantity of identical items, and represent these through a fungible token . You could also use a fungible token to represent a golden ticket that gives players who hold it access to a specific region or service.

_ERC20_ is the most accepted standard for fungible tokens in the Ethereum Network. MANA is built upon this standard.

#### Non-Fungible tokens

Non-fungible tokens (or NFTs) have characteristics that make each unit objectively different from others. Parcels of LAND in Decentraland are NFTs, as the location of each parcel is unique. The adjacency to other parcels, roads, or districts make these locations relevant to token owners.

In Decentraland, you can use NFTs to represent in-game items such as avatars, wearables, weapons, and other inventory items. You could, for example, use a single type of NFT to represent all weapons in your game, and differentiate them by setting different properties in these NFT.

NFTs can be used to provide provably scarce digital goods. Because of the legitimate scarcity made possible by the blockchain, buyers can rest assured that the art they purchase is, in fact, rare. This gives digital art real value that we’ve never seen before.

Game items will have a history that’s stored in the blockchain. This history could deem an item more valuable, for example if it was used to accomplish great achievements or used by someone who’s admired.

Depending on the contract describing the token, each NFT could either be immutable, or you could allow players to customize and change certain characteristics about them if they choose to.

_ERC721_ is the most accepted standard for non-fungible tokens in the Ethereum Network. LAND tokens follow the ERC721 standard.

## Smart Contracts

A contract consists of a both code (its methods) and data (its state) that resides at a specific address on the Ethereum blockchain.

The methods in a contract are always called via a transaction that has the _to_ field set to the contract’s address. The code that’s executed by the contract’s method can include calls to other contracts, these trigger more transactions that have the _from_ field set to the contract’s address.

A contract can’t trigger any actions on its own or based on a time event. All actions performed by a smart contract always arise from a transaction that calls one of the contract’s functions.
You can use smart contracts to condition transactions based on custom conditions. For example, players could stake a bet on the outcome of a game, and the corresponding payments would occur as soon as the outcome of the game is informed to the contract.
The entire code for a smart contract is public to whoever wants to read it. This allows developers to create publicly verifiable rules.
All Tokens are defined by a smart contract that specifies its characteristics and what can be done with it. Decentraland has written and maintains a number of smart contracts. LAND and MANA tokens themselves are defined by the _LANDregistry_ and _MANAtoken_ contracts respectively.

You can find the address of every contract created by Decentraland in [Decentraland smart contracts](https://contracts.decentraland.org/addresses.json).

You can read the full code of each of those contracts, as it's public information on the blockchain. You can find the contract by name on [Etherscan](https://etherscan.io/contractsVerified) and read its content there.

## dApps

_dApps_ (decentralized applications) are applications that are built upon smart contracts and the blockchain.

A dApp can be as simple as something that validates that your wallet holds a certain token and lets you use a service. Or it can be a fully fledged application with its own UI, such as the Decentraland Marketplace.

If you want to build your own dApp around Decentrlanad, see [Create a dApp]({{ site.baseurl }}{% post_url /blockchain-integration/2018-01-09-create-a-dapp %}).

## Ropsten test network

Before you deploy a smart contract, create a new type of token, or a Decentraland scene that relies on transactions on the Ethereum network, you need to make sure that it has no bugs or gaps that malicious users could exploit.

The Ropsten test network is an alternative version of Ethereum that’s specifically made for running tests.

Tokens in the Ropsten network have no real value, so you can afford to make mistakes without running any real risk. You can replenish any lost tokens for free by using a faucet:

- Ropsten Ether faucet (https://faucet.ropsten.be/)
- Ropsten MANA faucet (https://faucet.decentraland.today/)

If you’re developing a scene that triggers transactions, testing these transactions in the Ropsten network is free, as the tokens you send don’t have a value. In mainnet you would otherwise have to pay at the very least a real gas fee in Ether for each test transaction you carry out.

Once you’re confident that your code works as expected and can’t be exploited, you can deploy to the Ethereum mainnet.

## Blockchain reorgs

Occasionally, multiple machines will create alternative new blocks at roughly the same time. This is a problem, because this forks the chain into two diverging versions that could potentially contradict each other. When a fork occurs, Ethereum solves this by always giving priority to the longest chain and discarding any shorter chains. Even though it’s possible for two rivaling chains to exist at the same time, soon one of the two chains will add another block and outgrow the other. Due to the time it takes to solve the mining algorithms, it becomes increasingly difficult for rivaling chains to keep growing in perfect sync with each other. Sooner or later one will prevail over the other.

When one chain outgrows the other and the dispute is resolved, machines that had adopted the shorter chain need to make adjustments. This is what’s known as a “reorg”. They need to roll back on all of the transactions included in the blocks from the branch they’re in until they reach the point at which the fork occurred. Then they need to add the new blocks from the longer branch that’s considered legitimate.

Rolled back transactions may return to the pool of pending transactions until they’re picked up again by a miner (or are discarded). Any gas fees paid for these transactions are also rolled back.

Blocks that were just added to the end of a chain have a substantial chance of being rolled back because of the mechanisms explained above. As subsequent blocks are added to the end of the chain, it becomes less and less likely that the blocks that are further back in the blockchain could be rolled back, because that would require a larger reorg. Due to this, each new block that’s added to the end of the chain after a transaction is called a confirmation for that transaction.

When creating applications (or scenes) that use information from off the blockchain, you should be aware of the occurrence of reorgs. You might want to only consider transactions as verified when a certain number of confirmations have occurred, and the transaction is no longer at the very end of the chain.

Using several confirmations will make the information very stable, but transactions will take a long time to be reflected.
Using few confirmations, changes will be reflected faster, but there will sometimes be hiccups that appear to undo transactions when reorgs occur. If these transactions have off-chain consequences in your scene, then you might need to somehow reverse these consequences as well.
