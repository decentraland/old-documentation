---
date: 2021-05-21
title: DAO User Guide
redirect_from:
description: How to use the Decentraland DAO
categories:
  - Decentraland
type: Document
---

## Table of Contents

* [Logging in](#logging-in)
* [Voting power](#voting-power)
* [Approval/Rejection Conditions](#approvereject-conditions)
* [Browsing proposals](#browsing-all-proposals)
* [Viewing a proposal](#viewing-a-proposal)
* [Adding proposals to your watchlist](#adding-proposals-to-your-watch-list)
* [Voting](#voting)
* [Participating in the Forum](#participating-in-the-forum-discussions)
* [Creating a proposal](#creating-a-proposal)
* [Proposal categories](#proposal-categories)
* [Deleting a proposal](#deleting-a-proposal)

## Logging in

To get started with the DAO, visit [governance.decentraland.org](https://governance.decentraland.org). You will be presented with a welcome screen and quick start tutorial.

After reading the quick start tutorial, click **Sign In**. You must connect a wallet in order to use the DAO. Currently, you can use either **Metamask** or **Fortmatic**. Make sure the wallet you're using holds the relevant tokens for participating in the DAO (MANA, NAMES, or LAND)

After connecting your wallet you will be taken to the homepage of the DAO featuring a list of all currently active proposals.

## Voting power

Voting power is calculated from the total balance of MANA, NAMES and LAND associated with the wallet connected with the DAO. **The DAO looks at both your wrapped and unwrapped balances, so you do not need to unwrap any MANA to achieve your full voting power.** However, you can unwrap any previously wrapped MANA at any time from the “Voting Power” tab. There is still a gas fee associated with unwrapping MANA as it is a transaction on the Eth mainnet.

Your vote in the Decentraland DAO is weighted according to the balance of MANA, NAMES and LAND associated with the account you log in with.

To view your current voting power, navigate to the **Voting Power** tab. 

#### How is voting power calculated?

Voting power is represented as **“VP”**. MANA, NAME and LAND contribute to your total voting power as follows:

* 1 MANA contributes 1 VP
* 1 NAME contributes 100 VP
* 1 LAND parcel contributes 2000 VP
* Each Estate is worth 2000 multiplied by the number of single LAND parcels in that Estate. For example, an Estate with 2 parcels will contribute 4000 VP to your total voting power.

#### What happens if your voting power changes before a proposal closes?
If your MANA or LAND balance changes, it will affect your voting power, but only on proposals that are created after your balance changes.

The moment a new proposal is created, the DAO looks at all voters’ MANA and LAND balances to calculate their voting power. In other words, when you vote on a proposal, the voting power of your vote will be equal to the balance you had at the instant the proposal was initially created. You may vote with that VP, then change your MANA/LAND balance without affecting the weight of your vote.

#### Why does the Decentraland DAO use weighted votes?
If the Decentraland DAO gave each Ethereum address one vote, and each vote was weighted equally, then users could create as many separate addresses as they wanted to obtain more voting power.

Determining voting power by considering the MANA, NAME and LAND balances is currently the most secure way to limit the amount of influence each voter may have. Additionally, the more MANA, NAME or LAND you own in Decentraland, the greater your personal stake is considered to be, thus earning your vote more influence within the DAO.

## Approve/Reject conditions

Depending on the type of proposal, a certain amount of participating VP is needed to consider the votation valid. You will see this referenced on the Governance dApp as the **Acceptance Threshold** for the proposal. Once the acceptance threshold has been met, a proposal is approved if the total voting power in favor of the proposal is greater than the total voting power against the proposal. This is the typical 50/50 majority model we expect to see in most democratic votes.

The only type of proposal that do not follow this rule are the **Pre-proposal polls**. Since these proposals are considered a non-binding mechanism to gather community feedback around an idea, they do not have predefined Yes/No options for voting. Users might add more that two options making them a multiple choice poll. It is important to mention that if the Pre-proposal polls reach the Acceptance Threshold defined of 500k VP, they might get promoted to a **Draft proposal** and end up being a binding **Governance proposal**.


## Browsing all proposals

To view all proposals in the DAO, visit [governance.decentraland.org](https://governance.decentraland.org). The homepage of the DAO lists all recently added proposals sorted from most recent to oldest, by default.

You can filter proposals by **Outcomes**:

* **Active** – proposals that are currently being voted on
* **Passed** – proposals that have been approved by the community
* **Rejected** – proposals that have already been voted on and either were rejected by the community or didn't met the acceptance threshold
* **Enacted** – proposals that have been enacted on-chain by the DAO Committee 
* **Finished** – proposals that are closed, but do not have yes/no results, like multiple choice polls

You can also filter proposals by **Category** using the category column in the left side of the UI:

* **All proposals** – displays all proposals regardless of category or outcome
* **Catalyst Node** – only displays proposals to add new Catalyst nodes
* **Point of Interest** – only displays proposals to add new POIs
* **Name Ban** – only displays proposals to ban a name
* **Grant Request** – only displays grant requests
* **Pre-proposal Poll** – only displays non-binding polls
* * **Draft proposal** – only displays draft proposals
* **Governance proposal** – only displays final binding governance proposals


To view only proposals that have been passed, click the **Enacted** tab. Enacted proposals in this tab are sorted from most recent to oldest by default.

## Viewing a proposal

To read a proposal, just click on the proposal’s title to view the details page.

Each proposal detail page includes all of the descriptive information provided by the person who submitted the proposal.

You’ll also find links to the proposal’s discussion thread in the Forum, buttons to add a proposal to your watch list, the current voting results, buttons to vote, the acceptance threshold, your current Voting Power and who voted on the proposal.

Proposal details pages also list the unique avatar name associated with the Ethereum address that opened the proposal, if one exists, and the start and end dates of the proposal.

Finally, you’ll see a link to the proposals entry on Snapshot – the voting platform used by the Decentraland DAO.

## Adding proposals to your watch list

To add a proposal to your watch list, view the proposal’s detail page and click **Add to my Watchlist**. 

To remove a proposal from your watchlist, click **Remove from my Watchlist** from the proposal’s detail page. You can also click the red flag icon on any proposal currently in your watchlist to remove it.

## Participating in the Forum discussions

As a governance platform, the Decentraland DAO is most effective when paired with frequent discussion within the community. Every time a new proposal is opened on **governance.decentraland.org**, an accompanying topic is automatically opened on **[forum.decentraland.org](https://forum.decentraland.org)**. 

Before casting your vote, please take the time to view and join in on these forum discussions. Click the button **Discuss in the forum** from the details page of any DAO proposal you wish to discuss. You can also browse open topics by navigating to [forum.decentraland.org](https://forum.decentraland.org), heading to the **Governance** category, and browsing the open topics.

You don’t need to own tokens to participate in these discussions! Everyone is welcome to contribute to the conversation.

## Voting

To vote on a proposal, log into the DAO at [governance.decentraland.org](https://governance.decentraland.org) with a wallet that contains MANA, NAME or LAND.

> **Minimum balance needed to vote:**
>
> Only MANA, NAME or LAND holders may vote on proposals in the Decentraland DAO. **The current minimum balance needed to have a weighted vote on proposals in the DAO is 1VP** Voting with a balance of zero will result in a vote with a weight of 0, which does not impact the final results.

To vote on a proposal once you’ve connected your wallet, simply view the proposal’s detail page and click the **VOTE YES** or **VOTE NO** button, or select one of the multiple choice options if it is a poll, according to how you’d like to vote. 

Make sure that you read the full proposal so that you understand the issue being discussed and what will happen if the proposal is approved or rejected.

After clicking the Vote button, your connected Ethereum wallet will prompt you to sign the transaction. Remember, this is only a signed transaction, and requires no gas fee.

You will be given the option of adding the proposal to your watch list, this is a nice way to track the proposals you’re interested in. If you don’t want to add the proposal to your Watchlist, just click **No thanks**. 

After submitting your vote, you can change it at any time leading up to the end of the voting period - as shown in the proposal’s detail page.

#### What happens if your VP changes before a proposal is complete?

The DAO calculates your voting power for each individual proposal at the moment each proposal is created. If your VP changes after this moment, it will not affect your vote on that proposal.

> For a full discussion of voting power, and how and when it is calculated, please see the [Voting Power](#voting-power) section of the User Guide.

## Creating a proposal

To create a new proposal in the Decentraland DAO, start by logging in at [governance.decentraland.org](https://governance.decentraland.org) and connecting a wallet that contains MANA, NAME or LAND.

After logging in and connecting your wallet, click **Submit a proposal** and select the proposal category you want to use. Each category will provide a form allowing you to provide the relevant information for your proposal.

The form for every category is different, so make sure that you select the correct category for your proposal. The proposal forms in the DAO support Markdown, so you can format the content of your proposal to make it more readable. This is especially helpful for longer proposals.

To preview your rendered Markdown text, toggle the **Preview** switch. If you aren’t familiar with Markdown, you can use simple plain text.

Some proposal categories have minimum VP submission thresholds, meaning you have to have at least certain amount of VP to submit the proposals. This will be informed to you on the Governance dApp.

After completing the proposal form for the category you’ve selected, click **Submit proposal**. After successfully submitting your proposal, you will be taken to your new proposal’s detail page where you can add it to your watchlist and cast your vote.

## Proposal Categories

### Binding Proposals

#### 📍 Point of interest

Points of interest are notable locations in Decentraland. These “POIs” are promoted in several areas of the virtual world’s UI, and are promoted as good places for users to explore, especially people new to Decentraland.

If you have created a location, or have found a location that you think should be on this list, or if you think a current POI should be removed since it's no longer interesting, you can use this proposal category to present your suggestion to the DAO.

#### 🚫 Name ban

The “banned name” list includes offensive or harmful avatar and location names that are not permitted in Decentraland. Any names on this list cannot be claimed, used, or transferred between users. To suggest banning a name, you can use the Name ban proposal category in the DAO.

#### 🌐 Catalyst nodes 

Catalyst nodes are the community-run servers that provide the content and establish the peer-to-peer connections needed to keep Decentraland’s virtual world running. Whenever a user visits play.decentraland.org, they are connected to one of these nodes. However, only nodes that have been approved by the DAO are used in Decentraland’s network.

To suggest the addition of a new node to the network, you can use the Catalyst Node category.

### Governance Process Proposals

Some proposals are not as simple as adding or removing an item from a list, they require community signaling, discussions and implementation paths. These proposals should be submitted thorugh a three-stage governance process that starts with a poll and ends with a binding proposal.

The voting process includes three steps: a Pre-Proposal Poll, a Draft Proposal, and a Governance Proposal. Each tier will have progressively increasing submission and passage thresholds to ensure important governance decisions are made by a representative majority (based on Voting Power). Each step must reach the defined VP threshold to be promoted to the next one.

#### 📊 Pre-proposal Poll 

This is the first step to get to the final binding Governance proposal. Polls in the Decentraland DAO are non-binding, multiple choice questionnaires that may be used to measure the community’s general opinion or sentiment regarding different issues. They are non-binding in that the DAO does not automatically act on the results of any of these polls. If a pre-proposal poll gathers enough participating VP (500k VP is the acceptance threshold) it might get promoted to Draft proposal.

#### 📊 Draft Proposal 
A Draft Proposal presents a potential policy to the community in a structured format and formalizes the discussion about the proposal’s potential impacts and implementation pathways. A Draft Proposal that fails or does not reach this threshold can be amended and resubmitted one time. If a Draft proposal gathers enough participating VP (1M VP is the acceptance threshold) it might get promoted to a binding Governance proposal.

#### 📊 Governance Proposal 
This is the last step of the Governance process and is the only one that is binding. This proposal must flesh out all the details, data, methods, assesments or any other relevant information for implementing this proposal. A Governance proposal is accepted if it meets the acceptance threshold of 6M VP and the Yes option gets a simple majority.

## Deleting a proposal

Proposals can only be deleted by the person who created them.

To delete one of your proposals, navigate to the details page of the proposal you want to delete. Click **Delete Proposal** at the bottom of the right hand column. You will have to confirm your deletion.

Be careful! Deleted proposals cannot be restored!

If you delete a proposal after people have voted on it, nothing will happen. Deleted proposals with binding actions will not be enacted by the DAO Committee.
