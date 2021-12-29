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

After reading the quick start tutorial, click **Sign In**. You must connect a wallet in order to use the DAO. Currently, you can use either **Metamask** or **Fortmatic**.

After connecting your wallet you will be taken to the homepage of the DAO featuring a list of all currently active proposals.

## Voting power

> **Note:**
> In the previous version of the Decentraland DAO, users were required to “wrap” MANA before they could vote or create proposals. Voting power was derived from the amount of MANA and LAND wrapped. 
>
> **The current DAO no longer requires users to wrap any of their assets.** 
>
> Voting power is calculated from the total balance of MANA and LAND associated with the wallet connected with the DAO. **The DAO looks at both your wrapped and unwrapped balances, so you do not need to unwrap any MANA to achieve your full voting power.** However, you can unwrap any previously wrapped MANA at any time from the “Voting Power” tab. There is still a gas fee associated with unwrapping MANA as it is a transaction on the Eth mainnet.

Your vote in the Decentraland DAO is weighted according to the balance of MANA and LAND associated with the account you log in with.

To view your current voting power, navigate to the **Voting Power** tab. 

#### How is voting power calculated?

Voting power is represented as **“VP”**. MANA and LAND contribute to your total voting power as follows:

* 1 MANA contributes 1 VP
* 1 LAND parcel contributes 2000 VP
* Each Estate is worth 2000 multiplied by the number of single LAND parcels in that Estate. For example, an Estate with 2 parcels will contribute 4000 VP to your total voting power.

#### What happens if your voting power changes before a proposal closes?
If your MANA or LAND balance changes, it will affect your voting power, but only on proposals that are created after your balance changes.

The moment a new proposal is created, the DAO looks at all voters’ MANA and LAND balances to calculate their voting power. In other words, when you vote on a proposal, the voting power of your vote will be equal to the balance you had at the instant the proposal was initially created. You may vote with that VP, then change your MANA/LAND balance without affecting the weight of your vote.

#### Why does the Decentraland DAO use weighted votes?
If the Decentraland DAO gave each Ethereum address one vote, and each vote was weighted equally, then users could create as many separate addresses as they wanted to obtain more voting power.

Determining voting power by wrapping MANA and LAND is currently the most secure way to limit the amount of influence each voter may have. Additionally, the more MANA or LAND you own in Decentraland, the greater your personal stake is considered to be, thus earning your vote more influence within the DAO.

## Approve/Reject conditions

A proposal in the Decentraland DAO is approved if and only if the total voting power in favor of the proposal is greater than the total voting power against the proposal. This is the typical 50/50 majority model we expect to see in most democratic votes.

**If there is 0 VP worth of votes to reject a proposal, then there is a minimum of 1 VP worth of votes needed to approve the proposal.**

The previous DAO allowed the approval conditions to be changed for each proposal. For example, a 20% approval rate might have been sufficient to pass a proposal. This model has been abandoned in favor of the 50/50 majority.

In the previous DAO, proposal creators were also able to set the minimum percentage of the total MANA token supply needed to participate in a vote in order for a proposal to be approved. This approach has also been abandoned. There is no longer a minimum participation rate needed to pass a proposal.

Multiple choice polls are neither approved or rejected since they have no binding actions. After the duration of the vote is complete, polls are labeled “Finished”.

## Browsing all proposals

To view all proposals in the DAO, visit [governance.decentraland.org](https://governance.decentraland.org). The homepage of the DAO lists all recently added proposals sorted from most recent to oldest, by default.

You can filter proposals by **Outcomes**:

* **Active** – proposals that are currently being voted on
* **Passed** – proposals that have been approved by the community
* **Rejected** – proposals that have already been voted on and rejected by the community
* **Enacted** – proposals that have been enacted on-chain by the DAO Committee 
* **Finished** – proposals that are closed, but do not have yes/no results, like multiple choice polls

You can also filter proposals by **Category** using the category column in the left side of the UI:

* **All proposals** – displays all proposals regardless of category or outcome
* **Catalyst Node** – only displays proposals to add new Catalyst nodes
* **Point of Interest** – only displays proposals to add new POIs
* **Name Ban** – only displays proposals to ban a name
* **Grant Request** – only displays grant requests
* **Poll** – only displays non-binding polls

To view only proposals that have been passed, click the **Enacted** tab. Enacted proposals in this tab are sorted from most recent to oldest by default.

## Viewing a proposal

To read a proposal, just click on the proposal’s title to view the details page.

Each proposal detail page includes all of the descriptive information provided by the person who submitted the proposal.

You’ll also find links to the proposal’s discussion thread in the Forum, buttons to add a proposal to your watch list, the current voting results, buttons to vote YES or NO along with your current Voting Power.

Proposal details pages also list the unique avatar name associated with the Ethereum address that opened the proposal, if one exists, and the start and end dates of the proposal.

Finally, you’ll see a link to the proposals entry on Snapshot – the voting platform used by the Decentraland DAO.

## Adding proposals to your watch list

To add a proposal to your watch list, view the proposal’s detail page and click **Add to my Watchlist**. 

To remove a proposal from your watchlist, click **Remove from my Watchlist** from the proposal’s detail page. You can also click the red flag icon on any proposal currently in your watchlist to remove it.

## Voting

To vote on a proposal, log into the DAO at [governance.decentraland.org](https://governance.decentraland.org) with a wallet that contains LAND or MANA.

> **Minimum balance needed to vote:**
>
> Only LAND and MANA holders may vote on proposals in the Decentraland DAO. **The current minimum balance needed to have a weighted vote on proposals in the DAO is 1 LAND or 1 MANA.** Voting with a balance of zero will result in a vote with a weight of 0, which does not impact the final results.

To vote on a proposal once you’ve connected your wallet, simply view the proposal’s detail page and click the **VOTE YES** or **VOTE NO** button, according to how you’d like to vote. 

Make sure that you read the full proposal so that you understand the issue being discussed and what will happen if the proposal is approved or rejected.

After clicking the Vote button, your connected Ethereum wallet will prompt you to sign the transaction. Remember, this is only a signed transaction, and requires no gas fee.

You will be given the option of adding the proposal to your watch list, this is a nice way to track the proposals you’re interested in. If you don’t want to add the proposal to your Watchlist, just click **No thanks**. 

After submitting your vote, you can change it at any time leading up to the end of the voting period - as shown in the proposal’s detail page.

#### What happens if your VP changes before a proposal is complete?

The DAO calculates your voting power for each individual proposal at the moment each proposal is created. If your VP changes after this moment, it will not affect your vote on that proposal.

> For a full discussion of voting power, and how and when it is calculated, please see the [Voting Power](#voting-power) section of the User Guide.

## Participating in the Forum discussions

As a governance platform, the Decentraland DAO is most effective when paired with frequent discussion within the community. Every time a new proposal is opened on **governance.decentraland.org**, an accompanying topic is automatically opened on **[forum.decentraland.org](https://forum.decentraland.org)**. 

Before casting your vote, please take the time to view and join in on these forum discussions. Click the button **Discuss in the forum** from the details page of any DAO proposal you wish to discuss. You can also browse open topics by navigating to [forum.decentraland.org](https://forum.decentraland.org), heading to the **Governance** category, and browsing the open topics.

You don’t need to own MANA or LAND to participate in these discussions! Everyone is welcome to contribute to the conversation.

## Creating a proposal

To create a new proposal in the Decentraland DAO, start by logging in at [governance.decentraland.org](https://governance.decentraland.org) and connecting a wallet that contains LAND or MANA.

After logging in and connecting your wallet, click **Submit a proposal** and select the proposal category you want to use. Each category will provide a form allowing you to provide the relevant information for your proposal.

The form for every category is different, so make sure that you select the correct category for your proposal. The proposal forms in the DAO support Markdown, so you can format the content of your proposal to make it more readable. This is especially helpful for longer proposals.

To preview your rendered Markdown text, toggle the **Preview** switch.

If you aren’t familiar with Markdown, you can use simple plain text.

After completing the proposal form for the category you’ve selected, click **Submit proposal**. After successfully submitting your proposal, you will be taken to your new proposal’s detail page where you can add it to your watchlist and cast your vote.

## Proposal Categories

#### Point of interest 📍

Points of interest are notable locations in Decentraland. These “POIs” are promoted in several areas of the virtual world’s UI, and are promoted as good places for users to explore, especially people new to Decentraland.

If you have created a location, or have found a location that you think should be on this list, you can use this proposal category to present your suggestion to the DAO.

#### Name ban 🚫

The “banned name” list includes offensive or harmful avatar and location names that are not permitted in Decentraland. Any names on this list cannot be claimed, used, or transferred between users. To suggest banning a name, you can use the Name ban proposal category in the DAO.

#### Catalyst nodes 🌐

Catalyst nodes are the community-run servers that provide the content and establish the peer-to-peer connections needed to keep Decentraland’s virtual world running. Whenever a user visits play.decentraland.org, they are connected to one of these nodes. However, only nodes that have been approved by the DAO are used in Decentraland’s network.

To suggest the addition of a new node to the network, you can use the Catalyst Node category.

#### Poll 📊

Polls in the Decentraland DAO are non-binding, multiple choice questionnaires that may be used to measure the community’s general opinion or sentiment regarding different issues. They are non-binding in that the DAO does not automatically act on the results of any of these polls. They do not necessitate changes to any of the products, tools, or smart contracts in the Decentraland platform.

However, polls are powerful tools for building consensus within the community and for gathering information that could inform a future binding proposal.

## Deleting a proposal

Proposals can only be deleted by the person who created them.

To delete one of your proposals, navigate to the details page of the proposal you want to delete. Click **Delete Proposal** at the bottom of the right hand column. You will have to confirm your deletion.

Be careful! Deleted proposals cannot be restored!

If you delete a proposal after people have voted on it, nothing will happen. Deleted proposals with binding actions will not be enacted by the DAO Committee.
