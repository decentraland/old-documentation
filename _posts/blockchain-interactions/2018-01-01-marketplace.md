---
date: 2018-01-01
title: Marketplace
redirect_from:
  - /decentraland/marketplace/
  - /docs/land-manager
description: Meet the LAND marketplace
categories:
  - blockchain-interactions
type: Document
set: blockchain-interactions
set_order: 1
---

## What is the Marketplace?

The Marketplace is the go-to place to trade and manage all your Decentraland's assets.

Specifically, the Marketplace allows you to:

- **Sell** a parcel of LAND. Set your own price in MANA and an expiration date for the offer.
- **Buy** a parcel that is for sale.
- **Name** your parcels and estates and give them a description.
- **Transfer** your LAND to a different user.
- **Control** the parcels you own and visualize the contributions you’ve made to districts.
- **Explore** the world through a map to see who owns what.

> Please remember that this is a beta release, and the Marketplace might contain a few bugs. We kindly ask that you protect your personal information, property, and content. If you run into any issues or would like to provide feedback, click on the Intercom Widget right in the Marketplace.

## Where can I find it?

You can access the Marketplace at [market.decentraland.org](https://market.decentraland.org/)

# How do I use it?

## Your Wallet

Before using [market.decentraland.org](https://market.decentraland.org), connect and unlock an Ethereum client account that can interact with the web browser. We recommend using [MetaMask](https://metamask.io/) or [Mist](https://github.com/ethereum/mist). We also support the use of a [Ledger](https://www.ledgerwallet.com/) hardware wallet.

Your Ethereum address is treated as your account when using the Marketplace, you don't need any additional log in.

> Note: If you would like to use your Ledger hardware wallet in the Marketplace, first enable browser support on your device. Next, plug your device into your computer, and select the address you used during the auction. Finally, unlock your wallet and load up the Marketplace.

All transactions in the Ethereum network have a gas fee that needs to be paid in Ether, so your account must have at least a minimum amount of Ether in it.

## The Atlas View

The Atlas view gives you a bird’s-eye perspective of every color coded parcel, road, district, and plaza in Decentraland.

You can click and drag the map to move around, zoom in and out, or hover your cursor over a parcel to see its x,y location and owner.

Any parcel that is currently for sale in the Marketplace will be highlighted.

![](/images/media/c120655-atlas_view_screenshot.png)

Click Color Key in the footer to see a list of what each status the different colored tiles represent in the Atlas. You can always hover your cursor over a parcel to view it’s status, its coordinates, and its owner’s public address (if it’s already taken).

![](/images/media/e7ff473-hover_screenshot.png)

## The Marketplace View

If you’d rather see a list of every parcel currently offered on the market, you can use the Marketplace View. You can sort offers by “Newest”, “Cheapest”, “Most expensive”, and “Closest to expire”. To learn more about a particular parcel that’s for sale, simply click the tile in the Marketplace.

![](/images/media/c867650-marketplace_view_screenshot.png)

## Managing Your LAND

To view your LAND, click My Land. Here you’ll find a list of all of your parcels and estates, including any that you’ve contributed to community districts and any parcels that you have listed for sale.

By clicking on one of the parcels listed under My Land, you can edit its name, description, put it up for sale, or transfer it directly to another wallet address.

## Buy MANA

To buy MANA in exchange for Ether, follow these steps:

1. Open your _Settings page_
2. Check _You have authorized the Marketplace contract to operate MANA on your behalf_.

> Note: Enabling this setting is a transaction on the blockchain, so you must pay a gas fee in Ether.

3. Click _Buy Mana_
4. Set an amount of MANA you'd like to receive and click _Submit_.
5. Confirm this transaction on your Ethereum client.

## Buy parcels

To buy LAND parcels in Decentraland, follow these steps:

1. Open your _Settings page_
2. Check _You have authorized the Marketplace contract to operate LAND on your behalf_.

> Note: Enabling this setting is a transaction on the blockchain, so you must pay a gas fee in Ether.

3. Explore the Atlas view or the Marketplace to find a plot of land you like that's on sale. On the parcel's view, click _Buy_.
4. Confirm this transaction on your Ethereum client.

> Note: Aside from the small gas fee required by the miners for every transaction conducted on the Ethereum network, Decentraland does not collect any surplus trading fees.

![](/images/media/caa0d05-buy_LAND_screenshot.png)

## Sell a parcel

To sell one of your LAND parcels:

1. Open _My LAND_ and select the parcel you'd like to sell.
2. Click _Sell_
3. Set a price and click _Confirm_
4. Confirm this transaction on your Ethereum client.

## Create an estate

LAND Estates make it possible to associate two or more directly adjacent parcels of LAND. These parcels must be directly adjacent, and cannot be separated by a road, plaza, or any other parcel.

By connecting parcels into Estates, you can more easily manage your larger LAND holdings. Estates are especially useful when building larger scenes that span more than one parcel.

To create your first Estate, you need to own two or more adjacent LAND parcels.

1. Open _My LAND_ and select one of the parcels you'd like to use to create an estate.
2. Click _Create Estate_
3. You will be shown a view of the Atlas centered on the parcel you selected, with the remaining adjacent parcels you own highlighted. Select the different parcels you want to include in your estate.
   ![](/images/media/market_estates1.png)
4. Click _Continue_.
5. Enter a name and description for your Estate. These details will be publicly displayed in the Atlas, just like the name and description for any individual parcel.
   ![](/images/media/market_estates2.png)
6. Confirm this transaction on your Ethereum client.

Once you’ve created your Estate, you will see a new page appear under your account titled Estates. From this page you can view and manage all of your Estates.

When you create a new Estate, you are effectively transferring your parcels to a new token. These Estates are represented by ERC721 tokens (like any other NFT). This means that you will no longer see the individual parcels under _My Land_, and they will not appear in MetaMask, Mist, Trezor, or Ledger wallets, nor on Etherscan under your address.

## Edit parcels or estates

You can edit the name and description of any parcel or estate that you own.

These details will be publicly displayed in the Atlas, just like the name and description for any individual parcel.

To edit a parcel or estate:

1. Navigate to the details page of the parcel or the estate you'd like to edit and click _Edit_.

   ![](/images/media/marketplace_edit_parcel.png)

2. Click _Submit_
3. Confirm this transaction on your Ethereum client.

## Give permissions

You can give another user permissions to edit the content in a LAND parcel. This enables that user to deploy new code to the scene, whilst not having the ability to sell it.

The user given permission can also change the name or description of the parcel in the Marketplace.

> Note: Currently, this feature is only enabled for parcels, not estates.

To edit grant permissions over a parcel:

1. Navigate to the details page of the parcel and click _Permissions_.

   ![](/images/media/marketplace_give_permissions.png.png)

2. Click _Submit_
3. Confirm this transaction on your Ethereum client.

## See your activity history

Open the notifications icon

This displays a list of transactions that you carried out.

Status icon
link to details on Etherscan

## Transfer MANA

To transfer MANA to another account:

1. Open your _Settings page_
2. Click _Transfer_
3. Enter the public address of the Ethereum wallet of the recipient.

   ![](/images/media/9ff24a6-transfer_LAND_screenshot.png)

> Note: Please double check this address, since you cannot cancel the operation.

4. Click _Submit_.
5. Confirm this transaction on your Ethereum client.

## Transfer LAND

To transfer a LAND parcel or estate to another user:

1. Navigate to the details page of the parcel or the estate you'd like to transfer and click _Transfer_
2. Enter the public address of the Ethereum wallet of the recipient.

   ![](/images/media/9ff24a6-transfer_LAND_screenshot.png)

> Note: Please double check this address, since you cannot cancel the operation. While the recipient could always transfer the LAND back to you, the original owner cannot reverse the action, so please be sure that you are sending your Estate to the correct person.

3. Click _Submit_.
4. Confirm this transaction on your Ethereum client.

## Providing Feedback

We’ve worked to ensure that the Marketplace is simple and easy to use but if you ever have questions or feedback please reach out to us using the in-app Intercom widget.

For a more in-depth orientation to the Marketplace, [checkout our video tutorial here](/decentraland/getting-started-marketplace-video)!

As with all of our other tools, the Marketplace is open-source software, and [you can find the code here](https://github.com/decentraland/marketplace). Feel free to create an issue, or submit a pull-request!
