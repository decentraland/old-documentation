---
date: 2018-01-01
title: LAND Manager
description: Manage LAND and Estate tokens
categories:
  - market
type: Document
---

The Land Manager allows you to manage your LAND and Estate assets.


Access the Land manager at [https://builder.decentraland.org/land](https://builder.decentraland.org/land).

The Land Manager allows you to:

- **Name** your parcels and Estates and give them a public description.
- **Merge** LAND parcels into an Estate.
- **Dissolve** an Estate into separate LAND parcels.
- **Transfer** your parcels and Estates to another user.
- **Grant permissions** to other users to edit the parcels you own.

## Manage Your LAND

To view your LAND tokens, click **My LAND**. Here you’ll find a list of all of your parcels and Estates, including any parcels that you have listed for sale.

By clicking on one of the parcels or Estates listed under My Land, you can edit its name, description, put it up for sale, or transfer it directly to another wallet address.

![]({{ site.baseurl }}/images/media/marketplace_myland.png)

## Create an Estate

LAND Estates make it possible to associate two or more directly adjacent parcels of LAND to make it easier to manage your larger LAND holdings. Estates are especially useful when building larger scenes that span more than one parcel.

Parcels in an Estate must be directly adjacent, and cannot be separated by a road, plaza, or any other parcel.

To create your first Estate, you need to own two or more adjacent LAND parcels.

1. Open **My LAND** and select one of the parcels you'd like to add to the Estate.
2. In the parcel's details page, click **Create Estate**.
3. You will be shown a view of the Atlas centered on the parcel you selected, with the remaining adjacent parcels you own highlighted. Select the different parcels you want to include in your Estate.
   ![]({{ site.baseurl }}/images/media/market_estates1.png)

4. Click **Continue**.
5. Enter a name and description for your Estate. These details will be publicly displayed in the Atlas, just like the name and description for any individual parcel.

   ![]({{ site.baseurl }}/images/media/market_estates2.png)

6. Confirm this transaction on your Ethereum client and wait for the network to verify it.

Once you’ve created your first Estate, you will see a new tab titled Estates. From this page you can view and manage all of your Estates.

When you create a new Estate, you are effectively transferring your parcels to a new token. These Estates are represented by ERC721 tokens (like any other NFT). You will no longer see the individual parcels under _My LAND_, and they will not appear in MetaMask, Mist, Trezor, or Ledger wallets, nor on Etherscan under your address.

## Edit parcels or Estates

You can edit the name and description of any parcel or Estate that you own. These details will be publicly displayed in the Atlas.

To edit a parcel or Estate:

1. Navigate to the details page of the parcel or the Estate you'd like to edit and click **Edit**.

   ![]({{ site.baseurl }}/images/media/marketplace_edit_parcel.png)

2. Click **Submit**.
3. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## Give permissions

You can give another user permissions to edit the content in a parcel or Estate. This enables that user to deploy code to the scene, whilst not having the ability to sell the token.

The user given permission can also change the name or description in the Marketplace.

To grant permissions over your LAND:

1. Navigate to the details page of the parcel or Estate and click **Permissions**.

   ![]({{ site.baseurl }}/images/media/marketplace_give_permissions.png)

2. Click **Submit**.
3. Confirm this transaction on your Ethereum client and wait for the network to verify it.

## See your activity history

Open the notifications page by clicking the bell icon at the top of the screen.

![]({{ site.baseurl }}/images/media/marketplace_notifications.png)

The notifications page displays a list of all the recent transactions that you have carried out, together with their status.

Click a transaction to see more details about it on Etherscan.

## Transfer LAND

To transfer a LAND parcel or Estate to another user:

1. Navigate to the details page of the parcel or the Estate you'd like to transfer and click **Transfer**.

   ![]({{ site.baseurl }}/images/media/marketplace_transfer_land.png)

2. Enter the public address of the Ethereum wallet of the recipient.

> Note: Please double check this address, since you cannot cancel the operation. While the recipient could always transfer the LAND back to you, the original owner cannot reverse the action.

3. Click **Submit**.
4. Confirm this transaction on your Ethereum client and wait for the network to verify it.
