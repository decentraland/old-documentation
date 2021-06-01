---
date: 2021-05-31
title: Wearables Editor User Guide
redirect_from:
description: How to use the Decentraland Wearables Editor
categories:
  - Decentraland
type: Document
---

### What is the Wearables Editor?

The Wearables Editor is a tool within Decentraland’s Builder that allows you to upload, add metadata to, and publish your own custom wearables.

> Remember: these docs don’t explain how to create the models, meshes, and textures that make up wearables, they just explain how to use the Wearables Editor to upload and publish your wearables. For an intro on the actual wearable creation process, [start here](https://docs.decentraland.org/wearables/creating-wearables).

### Logging in

To start uploading and publishing your wearables, navigate to **[builder.decentraland.org](https://builder.decentraland.org)**.

Click **Sign in**, and then **Connect** to log in with your Metamask or Fortmatic wallet. After signing in, click the **Collections** tab.

### Uploading wearables

If you haven’t uploaded any items yet, click **New Item** or **New Collection** to get started. If you’ve already uploaded some wearables, you can either edit them by clicking on the item or collection and then clicking **Edit**, or you can upload new wearables by clicking the **+** icon next to the Open Editor button.

#### Creating a collection

When creating a collection, first enter the name you would like to give your collection and click **Create**. After creating your collection, you can begin adding items.

**You can add as many items as you want until you publish your collection.** Always remember, you cannot add, remove, or change the rarity of items in published collections.

To add an item to your new collection, select the collection, click **New Item**, and select your wearable files.

#### Uploading an item

When uploading an item you can either browse your computer to find the file you want, or you can click and drag your file right into the editor. For an overview of the 3D file types supported in Decentraland, see [3D Model Essentials](https://docs.decentraland.org/3d-modeling/3d-models/).

> **Wearable items cannot currently exceed 2MB.**

After uploading your file, you will be prompted to enter some descriptive information:

**Body shape**  
You can select which body shape your wearable is modeled for. The shape can be either A, B, or both. Wearables that are set to Shape A can only be worn by wearables with Body Shape A, while wearables set to Shape B can only be worn by avatars with Body Shape B. If you set the shape to Both, then avatars of both shapes can wear your wearable.

**Name**  
The name you would like to give your wearable.

**Rarity**  
The rarity of your wearable determines the total number of NFTs that may be minted based on your item. The rarities and the maximum number of NFTs that you may mint for each are:

| Rarity      | Limit  |
| ----------- | ------ |
| Unique      | 1      |
| Mythic      | 10     |
| Legendary   | 100    |
| Epic        | 1000   |
| Rare        | 5000   | 
| Uncommon    | 10000  |
| Common      | 100000 |  
  
  
**Category**  
Wearables are organized into different categories, depending on what part of an avatar they modify. Select the appropriate category for your item:

* Earring
* Eyewear
* Facial Hair
* Feet
* Hair
* Hat
* Helmet
* Lower Body
* Mask
* Upper Body
* Tiara
* Top Head _(Top Head wearables can be either an item of effect that is applied to the top of the head, like an angel’s halo.)_

When you’re finished entering your descriptive metadata, click **Create**.

### Editing items
To edit your items, navigate to the [Builder](https://builder.decentraland.org) and select the **Collections** tab. Here, you’ll find all of your wearable collections and items. You can edit an individual item by clicking on the item, and then clicking **Edit**. To edit an item that is part of a collection, first select the collection, and then the item within the collection you’d like to edit.

#### Details
The item details list the number of triangles, materials, and textures that make up your wearable. It is recommended that you do not exceed the following limits when creating wearables:

* 1500 triangles per wearable
* 500 triangles per accessory
* 2 square textures of 512x512px (or lower) 

If the number of triangles and textures exceeds these guidelines, you can click the pencil icon to upload a new model, or “representation” of your wearable with lower triangle/texture counts. You can also change the preview image by clicking the camera icon when hovering over the preview thumbnail.

#### Basics
This is the basic metadata you entered when you first uploaded your item. You can edit this information at any time leading up to the moment you publish your item within a collection.

* **Name -** the name of your item, this will be displayed when distributing your wearable on the marketplace
* **Description -** a brief statement describing your item, this is displayed when distributing your wearable on the marketplace
* **Category -** the component of an avatar’s body that your wearable modifies
* **Rarity -** the rarity determines the maximum number of NFTs you will be able to mint of your wearable after publication. _This is the only property that cannot be modified after publishing a collection._

#### Overrides
Overrides determine what other wearable categories your item will either replace, or hide. When setting overrides, you simply select a wearable category from the dropdown menu to add it to the override. You can add multiple categories to each override.

**Replaces**  
Any items within the categories added to this override will be unequipped from a users’ avatar when they equip your item. A user would have to re-equip any “replaced” items after unequipping your item. This does not delete items, it only unequips them.

**Hides**  
Any items within the categories added to this override will only be hidden (they won’t be rendered) when a user equips your item. When a user unequips your item, the hidden items will be rendered again automatically.

#### Tags 
Tags are simply descriptive words that users can use when searching or filtering for items. These could be relevant to competitions or events!

### Setting the price for items
Items that are included in a collection can include prices that you set for their primary sale.

To set the price of a wearable, navigate to the [Builder](https://builder.decentraland.org) and select the **Collections** tab. Then click on the collection containing your items you want to price.

For each item in the list, click **Set Price**.

#### Price
The price that a user will have to pay in a primary purchase (the first purchase after minting) for your item. Prices are set in MANA. Remember that when you mint wearables, they are minted directly on Matic/Polygon. When a user purchases your item, the transaction will be conducted in Matic/Polygon MANA.

#### Beneficiary
The Ethereum address that will receive the MANA in a primary sale of your wearable. You can use any Ethereum address you like. To automatically fill in the address you’ve logged in with, click **I’m the Beneficiary**.

You can also click **Make it Free**, to set the price to 0 MANA and the beneficiary address to a null address. This means that your wearable will be free for the primary sale, but it could be sold for a price in any secondary sale.

After setting the price and beneficiary address, click **Submit**.

### Publishing items
After you’ve added all of the relevant metadata to the wearables in your collection, and you’ve set the price and beneficiary address (or made your items free!) you can begin the publication process.

First, navigate to the [Builder](https://builder.decentraland.org) and select the **Collections** tab. Select the collection you’d like to publish and click **Publish**.

You might have to authorize the MANA contract to operate MANA on your behalf. By granting this authorization, you are permitting the MANA smart contract to withdraw MANA from your balance to pay the publication fee and to deposit MANA into your account from future sales of your items. Simply check MANA and click **Proceed**. You will have to sign a message from your wallet, but there is no gas fee.

#### Publication fees 
There is a required fee for publishing items. This fee exists to deter users from publishing an excessive number of wearables in an attempt to “spam” the wearables market.

**The fee is a flat rate of 100 MANA per item (not NFT!) in your collection.**

For example, if you publish a collection with two items, you will have to pay a fee of 200 MANA (100 MANA for each item) regardless of the rarity (or how many NFTs can be minted) of those items.

These fees are transferred to the Decentraland DAO, where they are used to help fund the growth of the platform through grants and other initiatives voted on by the greater Decentraland community.

After reviewing your total fee, click **Next**.

> **Warning!**
> You will not be able to add or remove items in your collection after beginning the publication process. You will be able to see your items within the Decentraland Marketplace, but they will not be able to be bought, sold, or transferred until they have been approved.

For more detailed information on the publication and approval process, see [Publishing Wearables](https://docs.decentraland.org/wearables/publishing-wearables).

When you are ready, click **Publish** and sign the message when prompted by your wallet.

### Attributing collaborators
If you collaborated with other artists when creating your items, you can add attributions within the Wearables Editor. This can only be done after publishing a collection.

First, navigate to the [Builder](https://builder.decentraland.org) and select the **Collections** tab. Select the collection containing the items you want to add attributions to, click the **…** icon next to the **Mint Items** button, and select **Collaborators**. 

To add collaborators, simply enter their Ethereum address, and click **Add**. You can add as many collaborators as you want. To remove a collaborator, simply click **Remove** next to the collaborator’s address.

### Minting wearables
Minting is the process of creating the actual non-fungible tokens (NFTs) based on the items you’ve uploaded to the Wearables Editor.

#### Rarity
When you publish a collection, each item in that collection has a set **rarity** that you specified. This rarity is recorded in a smart contract, and limits the total supply, or **stock**, that you can mint of any particular item. 

The available rarities, and the maximum stock provided by each, are:

| Rarity      | Limit  |
| ----------- | ------ |
| Unique      | 1      |
| Mythic      | 10     |
| Legendary   | 100    |
| Epic        | 1000   |
| Rare        | 5000   | 
| Uncommon    | 10000  |
| Common      | 100000 |
  
For example, if you have a collection with one Epic item, then you can only mint up to 1000 NFTs of that item.

#### The Matic/Polygon Sidechain
All wearables in Decentraland are minted on the Matic/Polygon sidechain. This allows users to mint and transfer items without paying any gas fees (so long as these transactions are conducted solely on the Matic/Polygon sidechain).

If you want to transfer an item that was minted or purchased on Matic/Polygon to the Ethereum main network, you will have to pay a gas fee at the bridge. For more information on the Matic/Polygon sidechain, [please see this blog post](https://decentraland.org/blog/announcements/polygon-mana/). 

#### Minting
You will not be able to mint any items within a collection until the [review process](https://docs.decentraland.org/wearables/publishing-wearables) is complete. If your collection is still under review, you will see the tag **“Under Review”** appended to your collection. After it has been reviewed and approved, the tag will change to **“Published”**.

To mint published items, open the collection containing the items you’d like to mint, and click **Mint Items**. You will be shown a modal window containing a list of the items available along with the stock available for each.

When minting, you must set the address that will receive the minted items and you must set the number of items you want to mint. You cannot mint more items than are available in the stock listed.

For example, if you have a Legendary item, but have already minted 25 of them, then you can only mint up to 75 more.

**Are there any fees associated with minting items?**  
No, items are minted on the Polygon/Matic sidechain, thus removing any fees traditionally associated with minting NFTs on the main Ethereum blockchain.

**If my items are minted on Polygon/Matic, will I receive the proceeds of sales on Polygon/Matic?**  
Yes, the proceeds of any items sold on Polygon/Matic will reside on the sidechain. You will have to pay a transaction fee if you want to transfer your MANA from the Polygon/Matic sidechain to the main Ethereum chain. You can do so from your **Account page**.

### Selling items
To sell your items, you must first publish them, have them approved, and then mint the items that you want to sell. Once these steps are completed, you may place your items for sale on the Marketplace.

Begin by navigating to the [Builder](https://builder.decentraland.org) and select the **Collections** tab. Select the collection you want to sell and toggle the **On Sale** switch. You will be shown a dialogue box asking you to confirm that you want to put your items up for sale on the Marketplace.