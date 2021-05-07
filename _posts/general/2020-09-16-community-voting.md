---
date: 2020-09-16
title: Community Voting
redirect_from:
description: Vote on the DAO to take part in the governance of Decentraland
categories:
  - Decentraland
type: Document
---

The **Decentraland DAO** is a fully functional _Decentralized Autonomous Organization_, where token holders can vote over decisions that impact on the content and future operation of the platform.

By visiting [governance.decentraland.org](https://governance.decentraland.org), you can see what’s currently being decided upon, cast your votes, and even post your own proposals to be voted on by others.

When you vote, you use your Ethereum wallet as a unique identifier.

## Connecting to the app

In order to vote, you must first connect to the governance app.

1. Click on the **Sign In** button.
2. Your browser wallet will open a pop up requiring that you sign to accept connecting your wallet to this app.

Once you’re connected, you can vote on any of the open proposals on the `Proposals` tab, or create your own proposals.

## Voting power

The weight of your votes depend on the _voting power_ of your account. Each account’s voting power is determined by three sources of power.

- **Wrapped MANA**: MANA that is converted to _WMANA_, and is temporarily held by the governance contract. For each unit of WMANA that you hold, you get one (1) voting power unit.
- **LAND parcels**: 2000 voting power units per parcel.
- **Estates**: 2000 voting power units per parcel in each estate.

For these tokens to contribute to your voting power, you need to own them in the Ethereum address you’re voting with. In the case of LAND and Estate tokens, you also need to register them for voting.

> Note: You need to be the owner of the LAND or Estate tokens. Holding a role over them is not valid for voting.

Any changes to your voting power are only valid for proposals that are created or that move forward after that change. If you wrap MANA to increase your voting power while a proposal is already open, voting on that proposal will only reflect the voting power you had at the time that the voting started. If the proposal then transitions to the next voting stage, you will be able to use your updated voting power on the next stage.

### Wrapping MANA

Wrapped MANA, or _WMANA_, is not spendable while wrapped onto the governance app. To spend or transfer this WMANA freely, you need to first unwrap it back into regular MANA.

To wrap MANA:

- Go to the `Voting Power` tab. There you will see your available tokens for wrapping.
- Click _Unlock MANA_. Your browser wallet will then ask you to approve a transaction to enable MANA for being wrapped.
- When that transaction is complete, you can specify how much MANA you want to wrap, and carry out another transaction to convert the MANA.

> Note: Both the transaction of unlocking MANA for wrapping, and the act of wrapping the MANA require that you pay a gas fee to the Ethereum blockchain, make sure you have Ether on that account to pay for that. You must then wait for the transaction to be completed, which can take up to a couple of minutes.

### Registering LAND and Estates

LAND and Estate tokens can be registered to the DAO so that they add to your voting power. Unlike MANA, LAND and Estate tokens that you use for voting continue to be on your wallet and can still be used normally. You’re still free to deploy content to them, and any holders of operator or manager permissions retain their permissions on the land.

You can also sell a registered LAND or Estate. If the buyer of your LAND or Estate tokens wants to use these to vote for themselves, they’ll have to register them again using their own address.

To register LAND or Estates:

- Go to the `Voting Power` tab. There you will see your available tokens for wrapping.
- Click _Commit LANDS_ or _Commit Estates_
- Your browser wallet will ask you to approve a transaction to register all of the tokens of the selected type that you currently hold in your wallet.

If you acquire new tokens after going through this process, these new tokens won’t contribute to your voting power until you repeat the transactions to register them.

> Note: Registering your LAND or estates is a transaction that requires that you pay a gas fee to the Ethereum blockchain, make sure you have Ether on that account to pay for that. You must then wait for the transaction to be completed, which can take up to a couple of minutes.

## Browsing Proposals

You can browse all the current and past proposals that took place on the DAO on the **Proposals** tab. In this view you can filter the proposal list to only view those that are in a specific state. If a proposal is still active, you can vote on it.

Click on a proposal to open its details. There you can see the amount of votes in favor and against the proposal, the remaining time it has to still be voted, the minimum thresholds it must reach to move forward to the next stage, as well as the different stages the proposal has already gone through.

## Voting

If you have voting power and find a proposal you care about, open its details and then click `Yes` or `No` to approve or reject it.

Your browser wallet will open a pop up requiring that you accept the vote transaction.

> Note: This transaction requires that you pay a gas fee, so make sure you have Ether on that account to pay for that.

As a community member, there are two stages where you’ll be able to vote for a proposal: in the _Inbox_ stage, to help filter out proposals that don’t have minimal approval, and in the _Community_ stage, where proposals are voted to be implemented.

To move forward to the next stage, a proposal must meet the minimum requirements of the stage. These are measured by looking at two metrics:

- **Minimum approval**: Out of the total voting power distributed throughout the total supply of wrapped MANA and registered LAND and Estates, how much of that has been used to vote in approval of this proposal.
- **Support**: Out of the votes that were casted for this proposal, how much voting power has been used to vote in favor of the proposal vs against it.

Voting against a proposal affects the _Support_ metric of the proposal, but has no effect on the _Minimum Approval_ metric, because this metric only looks at the amount of positive votes.

## The Lifecycle of a Proposal

A newly created proposal goes through the following stages of revision:

![]({{ site.baseurl }}/images/media/voting-cycle.png)

1. **Inbox filtering**: The community has seven days to view it. This phase serves as an initial filter to find proposals that the community has an interest in.
   _>1 % Minimum Approval and >25% Support needed_

   _After 7 days and if approved, the proposal can be **Enacted** to move to the next stage._

2. **Security Advisory Board revision**: The Security Advisory Board has 24 hours to review the proposal. This phase serves to protect the DAO from proposals that are badly intended or that could harm the ecosystem. At this stage, the Security Advisory Board can choose to reject or delay the proposal. This delay also serves to give community members enough time to register to vote or to wrap MANA before the vote.

   _After 24 hours and if not rejected or delayed, the proposal can be **Executed** to move to the next stage._

3. **Community vote**: Once someone executes the vote for the proposal, the community has another seven days to vote for the proposal. This phase determines if the proposal should be acted upon or not.
   _20 % Minimum Approval and 66 % Support needed_

   _After 7 days and if approved, the proposal can be **Enacted** so that its changes are made on-chain._

To **enact** or **execute** a proposal:

- Open the proposal's details.
- Click the _Enact_ or _Execute_ button. If the proposal is not ready, the button will be grayed out.
- Your browser wallet will require that you approve a transaction

> Note: Any user with or without voting power can execute or enact proposals. Both these transactions require that you pay a gas fee to the Ethereum network.

If a proposal gathers enough positive votes so that it's assured to succeed, even if all of the remaining voting power were to vote against it, then it's not necessary to wait the full duration of the stage. The same transaction for the vote that makes the proposal reach this level of approval also enacts the proposal.

Miscellaneous proposals without on-chain consequences don't need to be enacted after the final stage, they are forwarded to the Decentraland Foundation to be enacted upon by them.

### Create a Proposal

You can submit your own proposal to be voted on by the community. To do this, click _New Proposal_ and select the type of proposal:

<!--
- **Poll**: Ask a question that can be responded to with a _Yes_ or _No_. This serves as a catch-all alternative for any proposal that doesn’t fit into the other categories.
-->

- **Catalyst**: Propose adding a server to the _Catalyst_ network that makes up the backend of Decentraland. The servers on the Catalyst network are owned by community members and hold copies of all scenes deployed to Decentraland, serving this content to players as they explore the virtual world. These servers also handle the messaging and interactions between players.
- **Point of interest**: These are highlighted locations on the Decentraland map, places where we’d like to direct players so that they don’t miss out on the best content out there.
- **Ban Name**: Prevent an offensive or abusive player name from being displayed for other players to see.

Once a proposal has been created, it goes through the proposal lifecycle to determine if it has enough support.

> Tip: If you intend to vote on your own proposal, remember that any changes you make to your voting power after the creation of a proposal aren’t considered when voting. Make sure that any MANA you want to wrap is already wrapped, or any LAND or Estates that you want to register are already registered before creating the proposal.

Proposals of type _Catalyst_, _Point of interest_, and _Ban Name_ that are voted affirmatively have direct on-chain consequences, without requiring any human intervention. Proposals of type _Poll_ are forwarded to the Decentraland Foundation for enacting them.

## About The Security Advisory Board

A body known as the **Security Advisory Board (SAB)** safeguards some of the most advanced behind-the-scenes functionality that Aragon – the software that powers the DAO – has to offer for the benefit of the community.

The SAB has the following structure:

- Five members, who can be voted in and out by DAO vote
- Full consensus is required for contract upgrades. This means that if any one of the five members decides to vote against an upgrade, the four remaining members can't force a change on the smart contract.
- SAB members can install new applications to the DAO and can add or remove permissions of applications.

When a proposal makes it past the _Inbox_ stage, the members of the SAB have one day to review it before it makes its way forward to the _Community_ stage. The members of the council are tasked not with voting based on personal preference, but only against things they consider harmful.
