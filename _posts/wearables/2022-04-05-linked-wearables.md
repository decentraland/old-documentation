---
date: 2022-04-05
title: Linked Wearables
redirect_from:
description: Wearable representations of 3rd party tokens
categories:
  - Decentraland
type: Document
---

# About

In accordance with the [initial DAO proposal for Linked Wearables](https://governance.decentraland.org/proposal/?id=14e76cc0-2bc7-11ec-ac84-77607720a240) (previously called: Third Party Wearables) and the last approved [Draft Proposal with final definitions](https://governance.decentraland.org/proposal/?id=f69c4d40-aaaf-11ec-87a7-6d2a41508231), this document will serve as documentation to cover all the relevant details around the Linked Wearables feature. 

This document is mostly oriented for representatives of Third Parties that want to give their communities the ability to wear their NFTs as wearables when strolling through Decentraland.

# What are Linked Wearables?

Linked Wearables are 3D representations of NFTs that originate from outside Decentraland that can be used as wearables in-world, can be equipped on the avatar, and are found in the backpack.

Linked Wearables are not [regular wearables]({{ site.baseurl }}{% post_url /3d-modeling/2021-05-31-wearables-overview %}). They look the same, but carry a completely different meaning. 

Linked Wearables do not exist inside traditional wearable collections, have no rarity, and can not be sold in [primary](https://market.decentraland.org/browse?assetType=item&section=wearables) or [secondary](https://market.decentraland.org/browse?assetType=nft&section=wearables&vendor=decentraland&page=1&sortBy=recently_listed&onlyOnSale=true&viewAsGuest=false&onlySmart=false) markets. They are only **in-world representations mapped to external NFTs by a Third Party.**

> Imagine that you have an NFT project called ‘Cryptojackets’ where every NFT is a different kind of 2D jacket and you want your users to have a 3D representation of their jacket in their Decentraland backpack. Linked Wearables will allow you to submit 3D representations of your NFTs inside Decentraland. There is no need to mint a new token, and your current NFT project will have a new out-of-the-box feature to offer!
> 

# Getting started

## DAO Proposal

The **first step** to registering your NFTs as Linked Wearables is to be admitted by the DAO as an enabled *Third Party* *(the original creator of the external NFT)* by submitting a proposal using the template in the new category “Linked Wearables Registry”. 

Third Parties will need to share details about their project, collection, and define the managers that will later upload the 3D models of their NFTs in the [Builder](https://builder.decentraland.org/).

The passage threshold to become approved is 4 million Voting Power and the Voting Period is 1 week. 

![]({{ site.baseurl }}/images/media/linkedw-proposal.png)

## 3D Models

The 3D model version of your NFTs that will be used as in-world wearables will have to be compliant with the same [guidelines]({{ site.baseurl }}{% post_url /3d-modeling/2021-05-31-creating-wearables %}) as regular wearables. 

Once you are accepted as a Third Party and added to the Linked Wearables Registry, your Third Party Managers can upload 3D models in the Builder using the Slots made available to you based on your initial application. Slots are one of a limited number of potential NFT representations that Third Parties may use. The slots needed for a whole collection are provided after a Third Party is accepted by the DAO and added to the Linked Wearables Registry. If you require more Slots you will need to apply again.

1. Create a new Linked Wearables Collection

	![]({{ site.baseurl }}/images/media/linkedw-collection.png)

	*Only managers of accepted Third Parties will see the “New Linked Wearables Collection” option in the Builder.*

2. Choose a name for the collection and an ID
    
   ![]({{ site.baseurl }}/images/media/linkedw-name-collection.png)
    
3. Upload your 3D models. You can do this by item or in bulk following these guidelines.

	![]({{ site.baseurl }}/images/media/linkedw-upload-models.png)

4. Select the items to be published and wait for the Curators Committee to approve them

	![]({{ site.baseurl }}/images/media/linkedw-publish.png)

## API

Third Parties need to provide an API with 2 endpoints:

1. One to validate if the Decentraland User owns the NFT
2. One to fetch the NFTs (items) a Decentraland user has

**Technical details and examples [here](https://github.com/decentraland/adr/blob/main/docs/ADR-42-third-party-assets-integration.md#third-party-resolver).**

## Curation

As with regular wearables, your 3D models will need to get the Curators Committee’s approval. You are not excluded from this rule as Decentraland’s aesthetic and gameplay still needs to be safe guarded.  

### Handcrafted models

For 3D models that were made individually without any automated process (the usual method for most regular wearables) the Curator will need to go through all items in the collection individually to make sure they are all compliant with the [Wearable Guidelines]({{ site.baseurl }}{% post_url /3d-modeling/2021-05-31-creating-wearables %}). 

### Programmatic collections

Your collection is a Programmatic Collection if each 3D model was not crafted individually by hand, but automatically generated with code, many times from traits that were previously designed and modeled. For example: [CryptoPunks](https://opensea.io/collection/cryptopunks) and [BAYC](https://opensea.io/collection/boredapeyachtclub) are examples of 2D pfp NFT Collections that were created programmatically.  

Third Parties that make a **collection for Linked Wearables** programmatically (3D models to upload), will need to include this information in their Linked Wearables Registry proposal. 

![]({{ site.baseurl }}/images/media/linkedw-programatic.png)

For programmatic collections, not all items have to be curated individually. The number of items to be curated in each collection depends on the collection’s size, this was defined by the DAO in [this proposal](https://governance.decentraland.org/proposal/?id=f69c4d40-aaaf-11ec-87a7-6d2a41508231).

## Costs

It’s free! Yes. Converting your NFTs in to Linked Wearables is free for all Third Parties that were approved by the DAO (4M VP).

Even though there is a storage cost to upload the 3D representations of your Linked Wearables and also there is a cost for the Curation of your 3D models, the DAO will cover these fees in order to encourage new communities to bring their NFTs to Decentraland!

## Summary

These are the steps that Third Parties need to follow, in summary:

1. **Create a [DAO](https://governance.decentraland.org/) proposal** in the category “Linked Wearables Registry”. You'll need to:
    1. Request to be added to the Linked Wearables Registry
    2. Describe your company or community
    3. Describe your collection and the number of NFTs in it
    4. Define Managers
2. Wait one week for DAO's approval. **Ask your community for help!** they can vote for you to be accepted. Remember that MANA, Names, Lands, and/or Estates are needed to vote in the DAO.
3. **Submit your linked wearables** in the [Builder](https://builder.decentraland.org/) using your available Slots.
    1. You can submit your linked wearables in bulk
    2. Once an item is submitted to the Builder, you will see it has a property called **URN**. The **item** **URN** is what you will need to use to format the item’s [API response](https://www.notion.so/Guide-to-Link-Wearables-675dd68a1e5c48319ebfd226ae282880).
    
    ![]({{ site.baseurl }}/images/media/linkedw-submit.png)
    
4. Format each item’s [API](https://github.com/decentraland/adr/blob/main/docs/ADR-42-third-party-assets-integration.md#third-party-resolver).
5. Wait for the Curators Committee to approve the items in your collection.
6. Spread the word! Tell your community that they can **enjoy their brand new Linked Wearables in Decentraland!**

## **Additional comments**

- The DAO is the authority that will approve the addition of new Third Parties on the Linked Wearables Registry.
- The Curation Committee always has the power to reject specific items or all items within a collection.
