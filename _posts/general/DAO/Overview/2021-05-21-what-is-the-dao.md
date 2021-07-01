---
date: 2021-05-21
title: What is the DAO?
redirect_from:
description: The DAO is a decision making platform for Decentraland.
categories:
  - Decentraland
type: Document
---

The Decentraland DAO is a decision-making tool for MANA and LAND holders in Decentraland’s virtual world. Through votes in the DAO, the community can issue grants and make changes to the lists of banned names, POIs, and catalyst nodes. The DAO also controls the LAND and Estate smart contracts.

Issuing grants and making changes to the records and contracts owned by the DAO can only be done by using predefined proposals accessible in [governance.decentraland.org](https://governance.decentraland.org). 

These proposals, the votes submitted, and final results are all stored in IPFS via Snapshot, a gas-less voting client. Approved proposals with binding actions are enacted on the Ethereum blockchain by a committee by means of a multi-sig wallet. This committee is overseen by the Security Advisory Board (SAB), another multisig with trusted key holders. This Committee was voted into place by the community in the previous release of the DAO. [The original proposal can be found here.](https://forum.decentraland.org/t/proposal-for-a-more-accessible-and-affordable-dao/450).

The remainder of this document explains in greater detail what the DAO is, how it works, and what it can be used for.

For a detailed tutorial on how to use the Decentraland DAO, visit the [User Guide](https://docs.decentraland.org/decentraland/dao-userguide/).

## The DAO is powered by smart contracts

All DAOs, or decentralized autonomous organizations, are part of a new approach to organizational management and decision making made possible by Ethereum.

Ethereum extended what’s possible with blockchains by adding the ability to decentralize the handling of data more complex than just records of token ownership. Ethereum did this by allowing people to put smart contracts on a blockchain.

### What’s a smart contract?

A smart contract is a computer program that is run on the Ethereum blockchain. It can store both functions (bits of code that do things) and data (information). Smart contracts are often compared to vending machines. If you put in specific inputs, you get specific outputs. If I walk up to a vending machine, insert $1, and press the “orange soda” button, then I’ll get an orange soda if there’s any left in the machine. If there’s no more orange sodas, I’ll get my dollar back.

Smart contracts work the same way, people can interact with them by sending information with the expectation of receiving specific results or information. Just like the vending machine doesn’t have a little person inside handing out sodas, smart contracts are automatic (dare we say, autonomous).

If you’d like to learn more about Ethereum smart contracts, the [Ethereum documentation](https://ethereum.org/en/developers/docs/smart-contracts/) is the best place to dive in.

### The DAO controls Decentraland’s critical smart contracts

The second important quality of smart contracts is their **ability to own other smart contracts**. 

That’s right, every smart contract has its own address (just like the address of your Ethereum wallet) that allows it to own other smart contracts and cryptocurrencies.

So, in slightly more technical terms, a DAO is one or more smart contracts that can perform specific, pre-defined tasks and maintain ownership of cryptocurrencies. DAOs are built in such a way that they will only perform their tasks under specific conditions, such as the passing of a proposal voted on by a group of people who own a certain token (like MANA or LAND). All of this is done on a blockchain. Hence the name, “decentralized autonomous organization”. 

Decentraland’s DAO also owns a sum of MANA along with the LAND and Estate smart contracts. This MANA fund has been set aside to help sponsor community grants and to help grow the Decentraland platform according to the decisions and directions voted on by the community.

>**Note:**
>The DAO does not own, and so cannot modify, the [MANA smart contract](https://etherscan.io/address/0x0f5d2fb29fb7d3cfee444a200298f468908cc942#readContract). 
>
>The MANA contract’s owner is the [TokenSale contract](https://etherscan.io/address/0xa66d83716c7cfe425b44d0f7ef92de263468fb3d#readContract). The owner of the TokenSale contract is a separate contract that self-destructed on deployment ([as you can see on Etherscan here](https://etherscan.io/address/0xdf861993edbe95bafbfa7760838f8ebbd5afda9f)). This means that there is no other contract or wallet with the permissions to modify or pause the MANA supply.

There is other information that the DAO controls as well, such as the list of harmful or offensive names that are not permitted in Decentraland, a list of notable locations to be promoted to new users, and the list of community run servers that host Decentraland’s virtual world.

Transferring any of the DAO’s MANA, modifying the LAND or Estate smart contracts, or modifying any of the other listed information controlled by the DAO **can only be done** with the approval of MANA and LAND holders.
