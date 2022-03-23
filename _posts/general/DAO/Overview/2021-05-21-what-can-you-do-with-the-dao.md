---
date: 2021-05-21
title: DAO Uses
redirect_from:
description: The DAO allows users to create and vote on proposals that shape the metaverse.
categories:
  - Decentraland
type: Document
---

The DAO allows for two general types of proposals: **proposals with direct binding actions**, and **governance proposals**.

## Proposals with direct binding actions

The DAO allows the community to vote on **binding actions** that will result in changes made to Decentraland’s smart contracts on the Ethereum network. Those binding actions are:

* Funding a community project by transferring a portion of the DAO's resources to a grant vesting contract.
* Adding a catalyst node to the network of servers that host and run Decentraland’s virtual world.
* Adding or removing points of interest (POIs), or highlighted locations within the virtual world, to a list that is shown to users. This list helps users to find popular and interesting locations to explore.
* Banning a name from Decentraland. This proposal type allows users to ensure that avatars cannot be given offensive and harmful names.


## Governance proposals

Some proposals are not as simple as adding or removing an item from a list, they require community signaling, discussions and implementation paths. Those proposals should be submitted thorugh a three-stage governance process that starts with a poll and ends with a binding proposal.

The voting process includes three steps: a Pre-Proposal Poll, a Draft Proposal, and a Governance Proposal. Each tier will have progressively increasing submission and passage thresholds to ensure important governance decisions are made by a representative majority (based on Voting Power). Each step must reach the defined VP threshold to be promoted to the next one. 

### Stage 1: Pre-Proposal Poll

Submission Threshold: 100 VP
Passage Threshold: 500K VP ( A poll that reaches at least 500K VP and does not garner a majority of participating voting power, may still advance to the Draft Proposal stage - ensuring all issues with enough support have an initial pathway toward passage into policy.)
Voting Period: 5 Days
Goal: Introduce a governance issue to the community, gauge community sentiment, and determine if there is enough support to move forward with drafting an initial proposal.

### Stage 2: Draft Proposal

Submission Threshold: 1,000 VP
Passage Threshold: 1M VP and simple majority (51%) of participating voting power (A Draft Proposal that fails or does not reach this threshold can be amended and resubmitted one time.)
Voting Period: 1 Week
Goal: Present a potential policy to the community in a structured format and formalize discussion about the proposal’s potential impacts and implementation pathways.  A Draft Proposal that fails or does not reach this threshold can be amended and resubmitted one time.

### Stage 3: Governance Proposal

Submission Threshold: 2,500 VP
Passage Threshold: 6M VP and simple majority of participating VP (or needed acceptance criteria for their category)
Voting Period: 2 Weeks
Goal: Formalize the passed version of a Draft Proposal into a binding Governance outcome.

It is important to notice that anyone who meet the submission threshold can take a passed proposal (either a Poll or a Draft) and move it to the next stage, not only the proposal author.

## What about modifying the LAND or Estate smart contracts?

Right now, the DAO owns both the LAND and Estate smart contracts. Any modifications to either of these contracts must be carried out by the Security Advisory Board (SAB) and DAO Committee – groups of trusted and elected persons tasked with ensuring the continued security of these important pieces of Decentraland’s infrastructure.

The SAB must vote through a multi-sig wallet to approve any changes to the LAND or Estate contracts, preventing a rogue SAB member from introducing a vulnerability.

Currently, there are no predefined proposal categories for modifying the LAND or Estate smart contracts via the DAO’s UI. That doesn’t mean it is impossible for a non-SAB member to initiate changes, but it is a lengthier process that requires obtaining support from the broader community in addition to having the technical expertise needed to supply the code changes and a trusted third party to audit those changes.

The source code for the LAND and Estate contracts is available on GitHub [here](https://github.com/decentraland/land/tree/master/contracts).

Generally speaking, the process for modifying either contract would be:

* Polling the community via the DAO publishing a **pre-proposal poll**, and publicly discussing your proposed changes to gather support
* After gaining the initial community’s support, publishing a **Draft proposal** detailing the changes and getting acceptance through a votation.
* Writing the updated code to be merged into the contract
* Obtaining a successful code review and audit from a reputable third-party
* Presenting the audited code to the community using a binding **Governance proposal** and obtaining their approval to have it merged with the contract
* Once approved by another community vote, the DAO Committee or SAB would perform the contract upgrade with the new code
