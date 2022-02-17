---
date: 2022-02-17
title: Integrating Decentraland's Estate in your Marketplace
description: Important things to have in mind if you want to integrate the Decentraland's Estate in your marketplace
categories:
  - blockchain-integration
type: Document
---

## Integrating Decentraland's Estate in your Marketplace

The Decentraland's Estate is an ERC721 compliant NFT and runs in Ethereum Mainnet. Therefore a lot of third party marketplaces can trade them. In order to do so, this marketplace must follow
certain rules in order to make keep trades secure for the users.

As you may know, each [Estate](https://docs.decentraland.org/decentraland/faq/#what-is-an-estate) is a group of [LANDs](https://docs.decentraland.org/decentraland/faq/#what-is-land) and it have a _bytes_ hash associated to the group that it call _`fingerprint`_. Everytime the Estate changes by adding or removing a LAND, its _`fingerprint`_ changes too.

For marketplaces, especially the ones without an escrow system, it is 100% recommended to have a record of the Estate's _`fingerprint`_ when someone list it for sale or makes an offer. That way, when the order/offer is successfully executed, the current owner can't change the estate by trying to front-run the order execution.

## Example

### Not using the Estate fingerprint

- Bob has the Estate1 with LAND (1,1) and (1,2). Estate1 fingerprint: hash1
- Bob adds the LAND (1,3) to Estate1. The Estate1 has the LANDs: (1,1), (1,2), and (1,3). Estate1 fingerprint: hash2 (Fingerprint changed)
- Bob removes the LAND (1,1) from Estate1. The Estate1 has the LANDs: (1,2) and (1,3). Estate1 fingerprint: hash3 (Fingerprint changed)
- Bob puts on sale the Estate1. The list is created onchain in the Ethereum mainnet with the Estate smart contract address, the Estate id, the price, and the expiration date.
- Alice sends a transaction to buy the Estate specifying the estate id and the price expected to pay.
- Bob detects that someone is trying to buy his Estate1 and sends a transaction with higher gas fees than Alice to remove the LANDs (1,2) and (1,3) from Estate1.
- Bob's transactions is mined first. Estate1 has 0 LANDs. Estate1 fingerprint: hash4 (Fingerprint changed)
- Alice's transaction is mined later. Alice bought the Estate1 with 0 LANDs on it. It means that Alice got front-runned (and stolen/scammed) by Bob.

### Using the Estate fingerprint

- Bob has the Estate1 with LAND (1,1) and (1,2). Estate1 fingerprint: hash1
- Bob adds the LAND (1,3) to Estate1. The Estate1 has the LANDs: (1,1), (1,2), and (1,3). Estate1 fingerprint: hash2 (Fingerprint changed)
- Bob removes the LAND (1,1) from Estate1. The Estate1 has the LANDs: (1,2) and (1,3). Estate1 fingerprint: hash3 (Fingerprint changed)
- Bob puts on sale the Estate1. The list is created onchain in the Ethereum mainnet with the Estate smart contract address, the Estate id, the price, the expiration date.
- Alice sends a transaction to buy the Estate specifying the estate id, the price expected to pay, and **the fingerprint she saw (hash3)**.
- Bob detects that someone is trying to buy his Estate1 and sends a transaction with higher gas fees than Alice to remove the LANDs (1,2) and (1,3) from Estate1.
- Bob's transactions is mined first. Estate1 has 0 LANDs. Estate1 fingerprint: hash4 (Fingerprint changed)
- Alice's transaction is reverted because the smart contract checked that the fingerprint in the param that Alice sent didn't match with the current Estate1 fingerprint (hash3 != hash4). This check prevented Alice to buy a non desired Estate.

## Estate Smart Contract Interface

The Estate's smart contract is compliant with a [fingerprint interface](https://github.com/decentraland/land/blob/master/contracts/estate/EstateStorage.sol#L19). In order to check if an order/offer for an estate is still valid or not, you can call the _`verifyFingerprint(uint256 estateId, bytes fingerprint)`_ function implemented in the Estate smart contract. You can check a working production example [here](https://github.com/decentraland/marketplace-contracts/blob/master/contracts/marketplace/MarketplaceV2.sol#L382)
