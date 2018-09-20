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

The Marketplace is the go-to place to trade and manage all your Decentraland on-chain assets.

Access the Marketplace at [market.decentraland.org](https://market.decentraland.org/)

The Marketplace allows you to:

- **Sell** a parcel of LAND. Set your own price in MANA and an expiration date for the offer.
- **Buy** parcels that are for sale.
- **Name** your parcels and estates and give them a public description.
- **Transfer** your parcels and estates to another user.
- **Grant permissions** to other users to edit the parcels you own.
- **Explore** the world through a map to see who owns what.

> The Marketplace is in a beta release. We kindly ask that you protect your personal information, property, and content. If you run into any issues or would like to provide feedback, click on the Intercom Widget right in the Marketplace.

## Your Wallet

Before using [market.decentraland.org](https://market.decentraland.org), connect and log into an Ethereum client account that can interact with the web browser. We recommend using [MetaMask](https://metamask.io/) or [Mist](https://github.com/ethereum/mist). We also support the use of a [Ledger](https://www.ledgerwallet.com/) hardware wallet.

> Note: If you would like to use your Ledger hardware wallet in the Marketplace, first enable browser support on your device. Next, plug your device into your computer, and select the address you used during the auction. Finally, unlock your wallet and load up the Marketplace.

When navigating the Marketplace, your wallet address is treated as your account, you don't need any additional log in.

Since all transactions in the Ethereum network have a gas fee that needs to be paid in Ether, your account needs to have at least some Ether in it to perform any actions in the Marketplace.

## The Atlas View

The Atlas view gives you a bird’s-eye perspective of every color coded parcel, estate, road, district, and plaza in Decentraland.

![](/images/media/c120655-atlas_view_screenshot.png)

You can click and drag the map to move around, zoom in and out, or hover your cursor over a parcel to see its x,y location and owner.

Any parcel that is currently for sale in the Marketplace will be highlighted.

Hover your cursor over a parcel to view it’s status, its coordinates, and its owner’s public address (if it has an owner). Click on a parcel to view more details.

![](/images/media/e7ff473-hover_screenshot.png)

Click _Color Key_ in the footer to see what each tile color represents.

## The Marketplace View

If you’d rather see a list of every parcel currently offered on the market, you can use the Marketplace View. You can sort offers by “Newest”, “Cheapest”, “Most expensive”, and “Closest to expire”. Click a tile to learn more about it.

![](/images/media/c867650-marketplace_view_screenshot.png)

## Manage Your LAND

To view your LAND tokens, click **My Land**. Here you’ll find a list of all of your parcels and estates, including any that you’ve contributed to community districts and any parcels that you have listed for sale.

By clicking on one of the parcels listed under My Land, you can edit its name, description, put it up for sale, or transfer it directly to another wallet address.

![](/images/media/marketplace_myland.png)

## Buy MANA

To buy MANA in exchange for Ether, follow these steps:

1. Open your user _Settings page_
2. Check the box next to _You have authorized the Marketplace contract to operate MANA on your behalf_.

   ![](/images/media/marketplace_authorize.png)

   > Note: Enabling this setting triggers a transaction on the blockchain. You must confirm this transaction in your Ethereum client, pay a gas fee in Ether and wait for its confirmation before it takes effect.

3. Click **Buy Mana**
4. Set an amount of MANA you'd like to receive and click **Submit**.
5. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## Buy parcels

To buy LAND parcels in Decentraland, follow these steps:

1. Open your user _Settings page_
2. Check the box next to _You have authorized the Marketplace contract to operate LAND on your behalf_.

   ![](/images/media/marketplace_authorize.png)

   > Note: Enabling this setting triggers a transaction on the blockchain. You must confirm this transaction in your Ethereum client, pay a gas fee in Ether and wait for its confirmation before it takes effect.

3. Explore the _Atlas view_ or the _Marketplace view_ to find a plot of land you like that's on sale. On the parcel's view, click **Buy**.
   ![](/images/media/marketplace_buy_land.png)
4. Confirm this transaction on your Ethereum client and wait for the network to verify it.

> Note: Aside from the gas fee that the Ethereum network pays to the miners of the transaction, Decentraland does not collect any surplus trading fees.

## Sell a parcel

To sell one of your LAND parcels for MANA:

1. Open **My LAND** and select the parcel you'd like to sell.
2. In the parcel's details page, click **Sell**.
3. Set a price and expiration date and click **Confirm**.
4. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## Create an estate

LAND Estates make it possible to associate two or more directly adjacent parcels of LAND to make it easier to manage your larger LAND holdings. Estates are especially useful when building larger scenes that span more than one parcel.

Parcels in an estate must be directly adjacent, and cannot be separated by a road, plaza, or any other parcel.

To create your first Estate, you need to own two or more adjacent LAND parcels.

1. Open **My LAND** and select one of the parcels you'd like to add to the estate.
2. In the parcel's details page, click **Create Estate**.
3. You will be shown a view of the Atlas centered on the parcel you selected, with the remaining adjacent parcels you own highlighted. Select the different parcels you want to include in your estate.
   ![](/images/media/market_estates1.png)

4. Click **Continue**.
5. Enter a name and description for your Estate. These details will be publicly displayed in the Atlas, just like the name and description for any individual parcel.

   ![](/images/media/market_estates2.png)

6. Confirm this transaction on your Ethereum client and wait for the network to verify it.

Once you’ve created your first Estate, you will see a new tab titled Estates. From this page you can view and manage all of your Estates.

When you create a new Estate, you are effectively transferring your parcels to a new token. These Estates are represented by ERC721 tokens (like any other NFT). You will no longer see the individual parcels under _My Land_, and they will not appear in MetaMask, Mist, Trezor, or Ledger wallets, nor on Etherscan under your address.

## Edit parcels or estates

You can edit the name and description of any parcel or estate that you own. These details will be publicly displayed in the Atlas.

To edit a parcel or estate:

1. Navigate to the details page of the parcel or the estate you'd like to edit and click **Edit**.

   ![](/images/media/marketplace_edit_parcel.png)

2. Click **Submit**
3. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## Give permissions

You can give another user permissions to edit the content in a LAND parcel. This enables that user to deploy code to the scene, whilst not having the ability to sell the token.

The user given permission can also change the name or description of the parcel in the Marketplace.

> Note: Currently, this feature is only enabled for parcels, not estates.

To grant permissions over a parcel:

1. Navigate to the details page of the parcel and click **Permissions**.

   ![](/images/media/marketplace_give_permissions.png)

2. Click **Submit**
3. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## See your activity history

Open the notifications page by clicking the bell icon at the top of the screen.

![](/images/media/marketplace_notifications.png)

The notifications page displays a list of all the recent transactions that you have carried out, together with their status.

Click a transaction to see more details about it on Etherscan.

## Transfer MANA

To transfer MANA to another account:

1. Open your user _Settings page_
2. Click **Transfer**
3. Enter the public address of the Ethereum wallet of the recipient.

   ![](/images/media/9ff24a6-transfer_LAND_screenshot.png)

> Note: Please double check this address, since you cannot cancel the operation.

4. Click **Submit**.
5. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## Transfer LAND

To transfer a LAND parcel or estate to another user:

1. Navigate to the details page of the parcel or the estate you'd like to transfer and click **Transfer**

   ![](/images/media/marketplace_transfer_land.png)

2. Enter the public address of the Ethereum wallet of the recipient.

> Note: Please double check this address, since you cannot cancel the operation. While the recipient could always transfer the LAND back to you, the original owner cannot reverse the action.

3. Click **Submit**.
4. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## Providing Feedback

We’ve worked hard to ensure that the Marketplace is simple and easy to use but if you ever have questions or feedback please reach out to us using the in-app Intercom widget.

For a more in-depth orientation to the Marketplace, [checkout our video tutorial here](/decentraland/getting-started-marketplace-video)!

As with all of our other tools, the Marketplace is open-source software, and [you can find the code here](https://github.com/decentraland/marketplace). Feel free to create an issue, or submit a pull-request!
