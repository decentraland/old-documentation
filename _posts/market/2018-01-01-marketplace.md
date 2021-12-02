---
date: 2018-01-01
title: Marketplace
redirect_from:
  - /decentraland/marketplace/
  - /docs/land-manager
  - /blockchain-interactions/marketplace
  - /blockchain-integration/marketplace
  - /decentraland/getting-started-marketplace-video
description: Meet the LAND marketplace
categories:
  - market
type: Document
---

The Marketplace is the go-to place to trade and manage all your Decentraland on-chain assets.

Access the Marketplace at [market.decentraland.org](https://market.decentraland.org/).

The Marketplace allows you to:

- **Sell** parcels and Estates of LAND, wearables, and unique names. Set your own price in MANA and an expiration date for the offer.
- **Buy** parcels and Estates, wearables, and unique names that are for sale.
- **Transfer** your Decentraland assets to another user.
- **Explore** the world through a map to see who owns what, existing wearables or claimed avatar names.

> Note: Use [builder.decentraland.org/land](https://builder.decentraland.org/land) to:

- **Name** your parcels and Estates and give them a public description.
- **Grant permissions** to other users, allowing them to deploy on your LAND.
- **Manage** to create or dissolve estates.

## Your Wallet

Before using [market.decentraland.org](https://market.decentraland.org), connect and log into an Ethereum client account that can interact with the web browser. We recommend using [MetaMask](https://metamask.io/). We also support the use of a [Ledger](https://www.ledgerwallet.com/) hardware wallet.

> Note: If you would like to use your Ledger hardware wallet in the Marketplace, it will require you to connect it towards MetaMask. Please ensure you follow all the [given steps](https://metamask.zendesk.com/hc/en-us/articles/360020394612-How-to-connect-a-Trezor-or-Ledger-Hardware-Wallet) and updates to allow a seamless Ledger usage.

When navigating the Marketplace, your wallet address is treated as your account, you don't need any additional log in.

The Marketplace currently hosts LAND and names solely on Ethereums network. Wearables differ between Ethereum and Polygons network. Ethereum based transactions require a GAS fee, paid in Ethereum. Wheras Polygon based transactions only require a small amount of MATIC, to perform actions in the Marketplace.

## The Atlas View

The Atlas view gives you a bird’s-eye perspective of every color coded parcel, Estate, road, district, and plaza in Decentraland.

![]({{ site.baseurl }}/images/media/market-atlas.png)

You can click and drag the map to move around, zoom in and out, or hover your cursor over a parcel to see its x,y location and owner.

Any parcel that is currently for sale in the Marketplace will be highlighted.

Click on a parcel to view it’s status, its coordinates, and its owner’s public address (if it has an owner). From this screen you can also buy or place a bid on the parcel.

## The Marketplace View

Select the **Browse** tab to see all the items that are for sale.

- Select the **Category** to view only a specific type of item .
- **Order** them by different criteria like most recent, cheapest, etc.
- Toggle **On sale** off to view items that aren't for sale.
- **Filter** items by name to find something specific.

![]({{ site.baseurl }}/images/media/market-browse.png)

## Buy MANA

To buy MANA in exchange for Ether:

1. Open your user _Settings page_.
2. Click **Buy More** next to your MANA balance.
3. This takes you to [Kyber Swap](https://kyberswap.com/swap/eth-mana), where you can easily exchange Ether to MANA.
4. Set an amount of MANA you'd like to receive or the amount of Ether you'd like to convert, then click **Swap Now**.
5. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## Buy items

To buy LAND, Estates, wearables or unique names in Decentraland:

1. Browse offers to find something on same that you'd like to buy and click it to open its details.

> Tip: For LAND and Estates, you can also browse using the _Atlas_ view.

2. On it's details page, click **Buy**.

3. Confirm this transaction on your Ethereum client and wait for the network to verify it.

> Note: If this is your first time buying something on the Marketplace, you will also be asked to confirm a one-time transaction to allow the Marketplace to accept MANA.

## Place a bid on an item

If an item isn't listed on sale, you can still place a _bid_ on it and offer to buy it at a specific price. The other steps of the process are just like those of buying an item.

> Tip: View items that aren't for sale by untoggling the _On sale_ option. For LAND and Estates, you can also browse using the _Atlas_ view and select any parcel.

> Note: If this is your first time placing a bid on the Marketplace, you will also be asked to confirm a one-time transaction to allow the Marketplace to handle bids.

To view a list of your open and pending bids, select _My Bids_ on the top navbar.

From this screen you can also change the price of your bid by clicking _Update_. This screen also shows bids made by other users on items you own.

## Sell a parcel or Estate

To sell one of your items:

1. Open **My Assets** and open its details page.
2. In the details page, click **Sell**.
3. Set a price and expiration date and click **List for sale**. Then retype the price you're selling it at to confirm.
4. Confirm this transaction on your Ethereum client and wait for the network to verify it.

> Note: If this is your first time selling an item of this asset type on the Marketplace, you will also be asked to confirm a one-time transaction to allow the Marketplace to accept MANA.

You can change the price of a sale that you already put on offer without having to cancel and re-create the sale. Just click **Update price** in the parcel or Estate's details page.

## See your activity history

Open the notifications page by clicking the bell icon at the top of the screen.

![]({{ site.baseurl }}/images/media/marketplace_notifications.png)

The notifications page displays a list of all the recent transactions that you have carried out, together with their status.

Click a transaction to see more details about it on Etherscan.

> Note: This screen only shows transactions that were initiated by you. It doesn't show the sale of tokens, since that action is initiated by the buyer.

## Transfer LAND

To transfer a LAND parcel or Estate to another user:

1. Open **My Asssets** and open the details page of the parcel or the Estate you'd like to transfer and click **Transfer**.

2. Enter the public address of the Ethereum wallet of the recipient.

> Note: Please double check this address, since you cannot cancel the operation. While the recipient could always transfer the LAND back to you, the original owner cannot reverse the action.

3. Click **Submit**.
4. Confirm this transaction on your Ethereum client and wait for the network to verify it.

> Note: If the LAND parcel or Estate is currently on sale, you won't be able to transfer it. First click **Remove listing** to cancel the sale.

## Providing Feedback

We’ve worked hard to ensure that the Marketplace is simple and easy to use but if you ever have questions or feedback please reach out to us using the in-app Intercom widget.

As with all of our other tools, the Marketplace is open-source software, and [you can find the code here](https://github.com/decentraland/marketplace). Feel free to create an issue, or submit a pull-request!
