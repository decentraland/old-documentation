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

Linked Wearables are not [regular wearables]({{ site.baseurl }}{% post_url /wearables/2021-05-31-wearables-overview %}). They look the same, but carry a completely different meaning.

Linked Wearables do not exist inside traditional wearable collections, have no rarity, and can not be sold in [primary](https://market.decentraland.org/browse?assetType=item&section=wearables) or [secondary](https://market.decentraland.org/browse?assetType=nft&section=wearables&vendor=decentraland&page=1&sortBy=recently_listed&onlyOnSale=true&viewAsGuest=false&onlySmart=false) markets. They are only **in-world representations mapped to external NFTs by a Third Party.**

> Imagine that you have an NFT project called ‘Cryptojackets’ where every NFT is a different kind of 2D jacket and you want your users to have a 3D representation of their jacket in their Decentraland backpack. Linked Wearables will allow you to submit 3D representations of your NFTs inside Decentraland. There is no need to mint a new token, and your current NFT project will have a new out-of-the-box feature to offer!

# Costs

It’s free! Yes. Converting your NFTs in to Linked Wearables is free for all Third Parties that were approved by the DAO (4M VP).

Even though there is a storage cost to upload the 3D representations of your Linked Wearables and also there is a cost for the Curation of your 3D models, the DAO will cover these fees in order to encourage new communities to bring their NFTs to Decentraland!

# Getting started

## DAO Proposal

The **first step** to registering your NFTs as Linked Wearables is to be admitted by the DAO as an enabled _Third Party_ _(the original creator of the external NFT)_ by submitting a proposal using the template in the new category “Linked Wearables Registry”.

Third Parties will need to share details about their project, collection, and define the managers that will later upload the 3D models of their NFTs in the [Builder](https://builder.decentraland.org/).

The passage threshold to become approved is 4 million Voting Power and the Voting Period is 1 week. Resubmission is allowed.

![]({{ site.baseurl }}/images/media/linkedw-proposal.png)

After the DAO has approved the proposal, a set of Third Party managers will be set to operate with the all of the Linked Wearables features.

## Creating a Linked Wearable Collection

Linked wearables are grouped in collections that can be created, edited and deleted by Third Party Managers. Each collection can contain an arbitrary number of Linked Wearables.

To create a new Linked Wearable follow these steps:

1. Create a new Linked Wearables Collection.

   ![]({{ site.baseurl }}/images/media/linkedw-collection.png)

2. Choose a name for the collection and an ID.

   ![]({{ site.baseurl }}/images/media/linkedw-name-collection.png)

We strongly recommend that you choose a name that is unique and descriptive for the collection and **as the ID, the address of the NFT contract** that will be mapped to the Linked Wearables. Using the NFT address as the ID of you collection will prove to be helpful when creating the API.

## Editing or deleting a Linked Wearable Collection

Linked wearable collections can be edited by Third Party Managers of the Third Party record they belong to. The collection can be renamed at any time but, **the ID (or URN) can be changed and the collection can be deleted only if there are no wearables that were published**.

### Editing the collection name

To edit the name of a Linked Wearable Collection follow these steps:

1. Move the mouse over the collection name and click on the red pencil icon that appears on hover.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-collection-name.png)

2. Choose a new name for the collection and click on the save button.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-collection-name-modal.png)

### Editing the collection ID or URN

To edit the ID or URN of a Linked Wearable Collection follow these steps:

1. Click on the meatballs menu (three horizontal dots) on the far right of the set of buttons. A dropdown will appear. Select _Edit URN_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-collection-urn.png)

2. Write the new ID or URN for the collection and click _Save_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-collection-urn-modal.png)

The ID or URN of the collection **MUST be unique**, changing it to an existent one will fail.

### Deleting the collection

To delete Linked Wearable Collection follow these steps:

1. Click on the meatballs menu (three horizontal dots) on the far right of the set of buttons. A dropdown will appear. Select _Delete_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/delete-collection.png)

2. A Confirmation modal will appear, if you wish to proceed, click _Ok_, otherwise click on _Cancel_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/delete-collection-confirmation-modal.png)

## Linked Wearables

The 3D model version of your NFTs that will be used as in-world wearables will have to be compliant with the same [guidelines]({{ site.baseurl }}{% post_url /wearables/2021-05-31-creating-wearables %}) as regular wearables. Once your Linked Wearable collection
is created, you'll be able to upload your wearables' 3D models to the Builder.

## Uploading models one by one

It's possible to, as it already happens with standard wearables, upload your wearables' 3D models one by one.

To do so, follow these steps:

1. Click on the _New items_ button.

   ![]({{ site.baseurl }}/images/media/linked-wearables/new-items-collection.png)

2. Select the _Singe items_ option.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-items-upload.png)

3. Follow the steps to upload and configure your wearable as it is described in the _Uploading an item_ section in the [wearables editor user guide]({{ site.baseurl }}{% post_url /wearables/2021-05-31-wearables-editor-user-guide %}).

## Uploading models in bulk

As Linked Wearable collections can contain a big number of items, it is possible to upload the 3D models and the information of the wearables in bulk.

The process of uploading wearables in bulk involves uploading a ZIP file for each wearable containing the following:

- The 3D model files of the wearable (GLB, GLTFs, texture files, etc).
- A `wearable.json` file containing the information of the wearable.
- An optional `thumbnail.png` file containing the thumbnail of the wearable that will be seen in the Builder and the world. If it is not provided, one will be generated using the 3D model.

The 3D models and the optional `thumbnail.png` follow the [creating wearables guidelines]({{ site.baseurl }}{% post_url /wearables/2021-05-31-creating-wearables %}) and the [wearables editor user guide]({{ site.baseurl }}{% post_url /wearables/2021-05-31-wearables-editor-user-guide %}) on how to create a custom thumbnail.

The `wearable.json` accompanying the content of the wearables has the following format (typed as Typescript would):

```typescript
type WearableConfiguration = {
  /** The URN of the wearable */
  id?: string
  /** Name of the wearable */
  name: string
  /** Description of the wearable */
  description?: string
  data: {
    /** Wearables to replace when equipping the wearable */
    replaces: WearableCategory[]
    /** Wearables to hide when equipping the wearable */
    hides: WearableCategory[]
    /** Tags to identify the wearable */
    tags: string[]
    /** Representations of the wearable */
    representations: WearableRepresentation[]
    /** Category of the wearable */
    category: WearableCategory
  }
}

type WearableRepresentation = {
  /** Body shape of the representation */
  bodyShapes: BodyShape[];
  /** File path to the main file of the representation (GLB, GLTF, etc) */
  mainFile: string;
  /** A list of the file paths of the files that belong to the representation */
  contents: string[];
  /** Wearables to hide when equipping this representation */
  overrideHides: WearableCategory[];
  /** Wearables to replace when equipping this representation */
  overrideReplaces: WearableCategory[];
}

enum WearableCategory = {
  EYEBROWS = 'eyebrows',
  EYES = 'eyes',
  FACIAL_HAIR = 'facial_hair',
  HAIR = 'hair',
  HEAD = 'head',
  BODY_SHAPE = 'body_shape',
  MOUTH = 'mouth',
  UPPER_BODY = 'upper_body',
  LOWER_BODY = 'lower_body',
  FEET = 'feet',
  EARRING = 'earring',
  EYEWEAR = 'eyewear',
  HAT = 'hat',
  HELMET = 'helmet',
  MASK = 'mask',
  TIARA = 'tiara',
  TOP_HEAD = 'top_head',
  SKIN = 'skin'
}

enum WearableBodyShape {
  MALE = 'urn:decentraland:off-chain:base-avatars:BaseMale',
  FEMALE = 'urn:decentraland:off-chain:base-avatars:BaseFemale'
}
```

Some things to consider about the `wearable.json` file:

- All the information about the wearable categories and which to choose can be found in the [creating wearables guidelines]({{ site.baseurl }}{% post_url /wearables/2021-05-31-creating-wearables %}).
- The `id` field is optional and can be used to:
  - Create a wearable with an specific ID.
  - Update a wearable in Bulk (which will be seen in the `Making changes in bulk` section)
- The `id` field must contain the whole ID of the wearable, that is, the third party record id, the collection id and the item id `urn:decentraland:matic:collections-thirdparty:third-party-id:collection-id:item-id`. We recommend the id to be formed as `urn:decentraland:matic:collections-thirdparty:third-party-id:contract-address:token-id`, that is, if our wearable will be mapped to the token `0` in the NFT contract `0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d`, we recommend the URN to be `urn:decentraland:matic:collections-thirdparty:third-party-id:0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d:0`.
- The representations array will contain the information about how each body shape will look like. Each wearable MUST contain at least one representation (it can have one or the two of them), that is, taking
  into consideration the body shapes that we currently have, either 'urn:decentraland:off-chain:base-avatars:BaseMale' or 'urn:decentraland:off-chain:base-avatars:BaseFemale'. Each representation will describe which models will be used for each body shape.

The following is an example of a `wearable.json` file that contains a model for each body shape:

```json
{
  "id": "urn:decentraland:matic:collections-thirdparty:third-party-id:collection-id:item-id",
  "name": "Special hat",
  "category": "hat",
  "description": "A description of the wearable",
  "hides": ["hair"],
  "replaces": [],
  "tags": ["special", "new", "hat"],
  "representations": [
    {
      "bodyShapes": ["urn:decentraland:off-chain:base-avatars:BaseMale"],
      "mainFile": "aMaleModelFile.glb",
      "contents": ["aMaleModelFile.glb", "aTextureFile.png"],
      "overrideHides": [],
      "overrideReplaces": []
    },
    {
      "bodyShapes": ["urn:decentraland:off-chain:base-avatars:BaseFemale"],
      "mainFile": "aFemaleModelFile.glb",
      "contents": ["aFemaleModelFile.glb", "anotherTextureFile.png"],
      "overrideHides": [],
      "overrideReplaces": []
    }
  ]
}
```

This file will be zipped alongside the `aMaleModelFile.glb`, `aTextureFile.png`, `aFemaleModelFile.glb` and `anotherTextureFile.png`.

To add a custom thumbnail to the wearable, you can add a `thumbnail.png` file to the ZIP file and the file will be processed when uploaded..

Once all the files are ready, to upload the wearables in bulk, follow these steps:

1. Click on the _New items_ button.

   ![]({{ site.baseurl }}/images/media/linked-wearables/new-items-collection.png)

2. Select the _Multiple items_ option.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-items-upload.png)

3. Click on the _Browse yor computer_ link to open your file manager and elect all the zips containing your wearables.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-select-in-bulk.png)

4. Review if all the files are correct or if they need to be fixed. In this case, the model of the wearable isn't set or the `wearable.json` file has an incorrectly set representation.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-with-errors.png)

5. Fix any errors by clicking the _Add more_ button and re-uploading the failed files with the same name or by dismissing the errors using the trash icon on the top right section of the modal.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-upload-correct-file.png)

6. Upload all wearables by clicking _Upload items_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-without-errors.png)

7. Be patient, this might take a while!

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-uploading.png)

8. Success! Your items are now available in your collection.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-upload-success.png)

Common errors that must be avoided when uploading batched items:

- The `id` field is set to a value that is already being used by another wearable.
- The `id` field is set to a value that is not a valid ID. For example, the third party id or collection id belong to another third party or collection.
- There's no `wearable.json` file in the zip.
- The ZIP file doesn't have in its root directory the `wearable.json` file.
- The `wearable.json` has an incorrect format or values.
- The file is bigger than 2MBs. Linked Wearables have the same limitation as regular wearables in terms of size as the standard ones.
- The custom optional thumbnail image is not a png file.

## Editing a single wearable

To edit a single wearable, follow these steps:

1. Click on the meatballs menu (three horizontal dots) on the right of the item that you want to see in world. A dropdown will appear. Select _Open in editor_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-single-wearable.png)

2. Edit the wearable as standard wearables are edited. Follow the _Editing items_ section in the [wearables editor user guide]({{ site.baseurl }}{% post_url /wearables/2021-05-31-wearables-editor-user-guide %}).

## Editing a wearable's ID or URN

Wearables can have their ID or URN changed manually by following the steps below:

1. Click on the meatballs menu (three horizontal dots) on the right of the item that you want to see in world. A dropdown will appear. Select _Edit URN_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-urn-wearable.png)

2. Use the _Edit URN_ modal to write the new URN.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-urn-wearable-modal.png)

To consider when updating the ID or URN of a wearable:

- The input will receive only the ID for the wearable.
- The ID can't be repeated in the same collection.
- We recommend the ID of the wearable to be the same as the token ID of the NFT it will be mapped to.

## Editing wearables in bulk

Following the same idea previously seen in the `Uploading models in bulk` section, third party managers can make changes to the wearables in bulk.

To make changes in bulk to wearables, it is necessary to create a ZIP file for each of the wearables that will be changed.

These ZIP files must be created following the format described in `Uploading models in bulk` with one exception, in the `wearable.json` file, the `id`
property **MUST** be set to the `id` or URN of the wearable that will be changed. This is mandatory as it's the only way to identify the wearable to be changed.

Following the example in the `Uploading models in bulk` section, if we would like to change some of the properties of a wearable, for example, the name where we forgot to add a number to it, we should
include a `wearable.json` file in the zip as the next example:

```json
{
  "id": "urn:decentraland:matic:collections-thirdparty:third-party-id:collection-id:item-id",
  "name": "A hat 1",
  "category": "hat",
  "description": "A description of the wearable",
  "hides": ["hair"],
  "replaces": [],
  "tags": ["special", "new", "hat"],
  "representations": [
    {
      "bodyShapes": ["urn:decentraland:off-chain:base-avatars:BaseMale"],
      "mainFile": "aMaleModelFile.glb",
      "contents": ["aMaleModelFile.glb", "aTextureFile.png"],
      "overrideHides": [],
      "overrideReplaces": []
    },
    {
      "bodyShapes": ["urn:decentraland:off-chain:base-avatars:BaseFemale"],
      "mainFile": "aFemaleModelFile.glb",
      "contents": ["aFemaleModelFile.glb", "anotherTextureFile.png"],
      "overrideHides": [],
      "overrideReplaces": []
    }
  ]
}
```

Where the `id` field is set to the `id` or URN of the wearable that will be changed and the `name` field is set to the new name of the wearable.

Once the ZIP files are ready, follow these steps to edit the items in bulk:

1. Click on the meatballs menu (three horizontal dots) on the far right of the set of buttons. A dropdown will appear. Select _Edit in bulk_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-multiple-files-bulk-button.png)

2. A modal similar to de one in the _Uploading models in bulk_ will appear. Click on the _Browse your computer_ link to open your file manager.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-multiple-files-modal.png)

3. Select all the ZIP files of the items that will be edited.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-select-in-bulk.png)

4. Review if all the files are correct or if they need to be fixed. In this case, the model of the wearable isn't set or the `wearable.json` file has an incorrectly set representation.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-multiple-files-with-errors.png)

5. Fix any errors by clicking the _Add more_ button and re-uploading the failed files with the same name or by dismissing the errors using the trash icon on the top right section of the modal.

   ![]({{ site.baseurl }}/images/media/linked-wearables/multiple-files-upload-correct-file.png)

6. Upload all wearables by clicking _Upload items_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-multiple-files-without-errors.png)

7. Be patient, this might take a while!

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-multiple-files-uploading.png)

8. Success! Your items are now available in your collection.

   ![]({{ site.baseurl }}/images/media/linked-wearables/edit-multiple-files-success.png)

## Seeing the wearable in world

Linked Wearables can be seen in world to review how the model will work once published.

To be able to see a wearable in world, follow these steps:

1. Click on the meatballs menu (three horizontal dots) on the right of the item that you want to see in world. A dropdown will appear. Select _See in world_.

   ![]({{ site.baseurl }}/images/media/linked-wearables/see-in-world-button.png)

2. The Decentraland World will open. Navigate to your backpack to see the wearable.

   ![]({{ site.baseurl }}/images/media/linked-wearables/see-in-world-item.png)

## Publishing wearables

Once your wearables are ready, they must be published for curation. Publishing wearables **will consume slots**, a slot per wearable will be consumed upon publishing.

To publish your wearables, you need to:

1. Select the items to be published and wait for the Curators Committee to approve them

   ![]({{ site.baseurl }}/images/media/linkedw-publish.png)

Note that it does not matter in which network your NFT project is: Ethereum, Polygon, Binance, etc. The API is needed to map the owner of the NFT to the 3D model (wearable) submitted to Decentraland. Lets imagine that you have an NFT project with only 10 tokens minted. Therefore you have created and submitted 10 different 3D models (wearables) to Decentraland. Now, you need to create an API that Decentraland can use to know which wearable must be displayed to each token holder of your project. To do that, you will need to have in hand the tokens' owner and the `urn` of each item submitted to Decentraland. The item's urn can be found on each item detail page:

![]({{ site.baseurl }}/images/media/linked-wearables/item-urn.png)

For example, if the address `0x1234567891234567891234567891234567891234` owns two tokens and those tokens are represented in Decentraland by the urns `urn:decentraland:matic:collections-thirdparty:jean-pier:0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d:1` and `urn:decentraland:matic:collections-thirdparty:jean-pier:0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d:2` , then the API must return:

```
{
    address: "0x1234567891234567891234567891234567891234",
    assets: [
        {
            id: "0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d:1",
            amount: 1,
            urn: {
                decentraland: "urn:decentraland:matic:collections-thirdparty:jean-pier:0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d:1"
            }
        },
        {
            id: "0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d:2",
            amount: 1,
            urn: {
                decentraland: "urn:decentraland:matic:collections-thirdparty:jean-pier:0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d:2"
            }
        }
    ],
    total: 2,
    page: 1,
    next: ""
}
```

## Curation

As with regular wearables, your 3D models will need to get the Curators Committee’s approval. You are not excluded from this rule as Decentraland’s aesthetic and gameplay still needs to be safe guarded.

### Handcrafted models

For 3D models that were made individually without any automated process (the usual method for most regular wearables) the Curator will need to go through all items in the collection individually to make sure they are all compliant with the [Wearable Guidelines]({{ site.baseurl }}{% post_url /wearables/2021-05-31-creating-wearables %}).

### Programmatic collections

Your collection is a Programmatic Collection if each 3D model was not crafted individually by hand, but automatically generated with code, many times from traits that were previously designed and modeled. For example: [CryptoPunks](https://opensea.io/collection/cryptopunks) and [BAYC](https://opensea.io/collection/boredapeyachtclub) are examples of 2D pfp NFT Collections that were created programmatically.

Third Parties that make a **collection for Linked Wearables** programmatically (3D models to upload), will need to include this information in their Linked Wearables Registry proposal.

![]({{ site.baseurl }}/images/media/linkedw-programatic.png)

For programmatic collections, not all items have to be curated individually. The number of items to be curated in each collection depends on the collection’s size, this was defined by the DAO in [this proposal](https://governance.decentraland.org/proposal/?id=f69c4d40-aaaf-11ec-87a7-6d2a41508231).

## API

In order for Linked Wearables to work, the third parties need to provide an API that will be queried by the Decentraland services (Catalyst) with 2 endpoints:

1. `@GET /registry/:registry-id/address/:address/assets` - Retrieves a list of assets associated with a given address
2. `@GET /registry/:registry-id/address/:address/assets/:id` - Validates if a DCL asset is owned by a user.

**Technical details and examples [here](https://github.com/decentraland/adr/blob/main/docs/ADR-42-third-party-assets-integration.md#third-party-resolver).**

### Endpoint `@GET /registry/:registry-id/address/:address/assets`

If you've followed the steps to create a new collection and the steps to either edit the item's id or URN or to create items in bulk, you already have:

- Created a collection which its ID or URN is the contract address of the NFTs that will represent or map to the Linked Wearables.
- Created wearables which IDs or URNs are the token ids of the NFTs that will represent or map to the Linked Wearables.

By doing this, you can query your NFT contract or indexer to build the information required to respond to the API as it contains the information about who owns which wearable:

Let's say your contract implements the [ERC721 standard](https://eips.ethereum.org/EIPS/eip-721) with the enumeration extension. If we would like to get the tokens owned by the
address `0x0f5d2fb29fb7d3cfee444a200298f468908cc942`, your API can query the contract using the `balanceOf` to get the amount of tokens owned by the address and later loop the
tokens with the `tokenOfOwnerByIndex` to get the information about the tokens the address has.

Having all the tokens that the an address owns, the API can easily build the response by building each of the assets:

```json
{
  "id": "0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:0",
  "amount": 1,
  "urn": {
    "decentraland": "urn:decentraland:matic:collections-thirdparty:cryptohats:0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:0"
  }
}
```

The `id` property will be set to the `contract_address:token_id` of each of the retrieved tokens, the `amount` to 1 and the `urn` property will be set to have the
decentraland property with the value `urn:decentraland:matic:collections-thirdparty:registry_id:contract_address:token_id`, where the `registry_id` and `contract_address` can be retrieved
from the query itself (`contract_address` must be previously set in the code) and the other values from the contract.

As an example, by querying the API to get the assets owned by `0x0f5d2fb29fb7d3cfee444a200298f468908cc942`:

```bash
curl https://api.cryptohats.io/registry/cryptohats/address/0x0f5d2fb29fb7d3cfee444a200298f468908cc942/assets
```

The API can do the following:

1. Query the contract `0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd` with the user's address by using `balanceOf(0x0f5d2fb29fb7d3cfee444a200298f468908cc942)`, retrieving the amount of
   tokens owned by the user, in this case, 2.
2. Query the contract `0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd` two times `tokenOfOwnerByIndex(0x0f5d2fb29fb7d3cfee444a200298f468908cc942, 0)`, `tokenOfOwnerByIndex(0x0f5d2fb29fb7d3cfee444a200298f468908cc942, 1)`
   returning the token ids 58 and 59.
3. Respond with:

```json
{
  "address": "0x0f5d2fb29fb7d3cfee444a200298f468908cc942",
  "assets": [
    {
      "id": "0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:58",
      "amount": 1,
      "urn": {
        "decentraland": "urn:decentraland:matic:collections-thirdparty:cryptohats:0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:58"
      }
    },
    {
      "id": "0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:59",
      "amount": 1,
      "urn": {
        "decentraland": "urn:decentraland:matic:collections-thirdparty:cryptohats:0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:59"
      }
    }
  ],
  "total": 100,
  "page": 1,
  "next": "https://....&startAt=1234"
}
```

### Endpoint `@GET /registry/:registry-id/address/:address/assets/:id`

If you've followed the steps to create a new collection and the steps to either edit the item's id or URN or to create items in bulk, you already have:

- Created a collection which its ID or URN is the contract address of the NFTs that will represent or map to the Linked Wearables.
- Created wearables which IDs or URNs are the token ids of the NFTs that will represent or map to the Linked Wearables.

By doing this, you can query your NFT contract or indexer to build the information required to respond to the API as it contains the information about who owns which wearable:

Let's say your contract implements the [ERC721 standard](https://eips.ethereum.org/EIPS/eip-721) and you're asked to retrieve information about an asset with an id if the asset is owned by an address.
By querying the contract using the `ownerOf` method, as we can extract the token id from the asset it because of the requirements assumed above (contract_address:token_id), it is possible to get the
address of the owner of the token and, if it matches, respond with the required information about the asset.

As an example, by querying the API to get the information about the asset with id `0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:1` owned by the `0x0f5d2fb29fb7d3cfee444a200298f468908cc942` address:

```bash
curl https://api.cryptohats.io/registry/cryptohats/address/0x0f5d2fb29fb7d3cfee444a200298f468908cc942/assets/0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:1
```

The API can do the following:

1. Query the contract `0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd` retrieved from the query by splitting the asset id by `:`, with the user's address also retrieved from the query, by using
   the method `ownerOf(1)` that will return the address `0x0f5d2fb29fb7d3cfee444a200298f468908cc942` if the asset is owned by the user.
2. Respond with:

```json
{
  "id": "0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:1",
  "amount": 1,
  "urn": {
    "decentraland": "urn:decentraland:matic:collections-thirdparty:cryptohats:0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd:1"
  }
}
```

## Summary

These are the steps that Third Parties need to follow, in summary:

1. **Create a [DAO](https://governance.decentraland.org/) proposal** in the category “Linked Wearables Registry”. You'll need to:
   1. Request to be added to the Linked Wearables Registry
   2. Describe your company or community
   3. Describe your collection and the number of NFTs in it
   4. Define Managers
2. Wait one week for DAO's approval. **Ask your community for help!** they can vote for you to be accepted. Remember that MANA, Names, Lands, and/or Estates are needed to vote in the DAO.
3. **Submit your linked wearables** in the [Builder](https://builder.decentraland.org/) using your available Slots.

   1. Create a third party collection. We recommend using as its ID or URN the contract address of the NFTs that will represent or be mapped to the Linked Wearables.
   2. Create or upload your wearables either by uploading them one by one or in bulk.
   3. Use the **URN** of the wearables in the Builder to build your API. We recommend that your URN or ID to be set as the token id of the NFT that will be represented by the wearable.

   ![]({{ site.baseurl }}/images/media/linkedw-submit.png)

4. Build the API.
5. Wait for the Curators Committee to approve the items in your collection.
6. Spread the word! Tell your community that they can **enjoy their brand new Linked Wearables in Decentraland!**

## **Additional comments**

- The DAO is the authority that will approve the addition of new Third Parties on the Linked Wearables Registry.
- The Curation Committee always has the power to reject specific items or all items within a collection.
- Linked Wearables work with any NFT project running at any blockchain, if the API provided can match the user address with the 3D model to show as Linked Wearable.
- This feature will be enacted after the [Governance Proposal](https://governance.decentraland.org/proposal/?id=5534b120-b786-11ec-903a-6546e8793cef) ends. Third Parties can still submit their Linked Wearables Registry proposals.
