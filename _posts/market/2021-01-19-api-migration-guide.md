---
date: 2021-01-19
title: LAND API 2.0 Migration Guide
description: Migrate from v1 to v2 of the LAND API
categories:
  - market
type: Document
---

## Table of Contents

- [Where can I find the documentation for version 2.0?](#Where-can-I find-the-documentation-for-version-2.0?)
- [Where can I find the documentation for version 1.0?](#Where-can-I-find-the-documentation-for-version-1.0?)
- [Version 2.0 Migration Guide](#Version-2.0-Migration-Guide)

## Where can I find the documentation for version 2.0?

Current documentation (including configuration details) for the LAND API v2.0 [can be found here](https://github.com/decentraland/atlas-server). After version 1.0 has been fully deprecated on February 1st, 2021, all of the v2.0 documentation will be migrated to this URL within the Decentraland documentation.

## Where can I find the documentation for version 1.0?

You can still find the docs for version 1.0 [here](https://docs.decentraland.org/market/api/). These docs will remain available until February 1st, 2021. After that date, full documentation will be available on this page.

## Version 2.0 Migration Guide

Following is a side-by-side comparison of v1 and v2 of the LAND API. Any version 1 endpoints with the tag **Deprecated** will be unavailable starting February 1st, 2021.

Any version 1 endpoints **without** the deprecation tag will remain working and supported, as there is no replacement in version 2.0.

There are several v1 endpoints without a v2 counterpart, but the corresponding data can still be found via a query to [Decentraland’s subgraph on The Graph](https://thegraph.com/explorer/subgraph/decentraland/marketplace). Example queries are included for each endpoint group, where applicable.

### Tiles

The v1 tiles endpoint has been replaced with an improved v2 endpoint. The v2 endpoint returns a more readable and more easily parsed object. For an in depth discussion of these improvements, [see this blogpost](https://decentraland.org/blog/technology/land-api-v2/).


| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | ---|
| `GET /v1/tiles` | Returns all tiles in the map, using the legacy format. **Deprecated.** | `GET /v2/tiles` | Returns all tiles in the map, using the new v2 format. This replaces v1 of the same endpoint, returning an object with a new, more useful shape. |

### Bids

All of the v1 bid endpoints have been replaced with queries to the Graph. See the chart and example below for details.


| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | ---|
| `GET /bids/:id` | Returns a bid by the bid’s ID. **Deprecated** | See example subgraph query below. |  |
| `GET /addresses/:address/bids` | Returns list of bids by the seller or bidder’s Ethereum address. **Deprecated** | See example subgraph query below. |  |
| `GET /parcels/:x/:y/bids` | Returns a list of bids placed on a given parcel. **Deprecated** | See example subgraph query below. |  |
| `GET /estates/:id/bids` | Returns a list of bids placed on a given estate. **Deprecated** | See example subgraph query below. |  |
| `GET /bids/:address/assets` | Returns a list of bid assets by the seller or bidder’s Ethereum address. **Deprecated** | See example subgraph query below. |  |

To list open and non-expired bids where the expiration date is specified as a unix timestamp:

{% raw %}
```
{
  bids(where:{ status: open, expiresAt_gt: 1611082372  }) {
    nft {
      name
      contractAddress
      tokenId
    }
    price
    bidder
    seller
  }
}
```
{% endraw %}

### Districts and District Contributions

V2 endpoints to expose data about Districts and District contributions are under active development. Until February 1st, 2021, you may still call the v1 endpoint. After that date, new documentation for the v2 endpoints will be published on this page.

| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | --- |
| `GET /addresses/:address/contributions` | Returns all contributions to districts by the contributor’s Ethereum address. **Deprecated** | `GET /v2/addresses/:address/contributions` | This v2 endpoint is under active development, and will be functional on February 1st, 2021 when v1 is deprecated. |
| `GET /districts` | Returns a list of all districts in Genesis City. **Deprecated** | `GET /v2/addresses/:address/contributions` | This v2 endpoint is under active development, and will be functional on February 1st, 2021 when v1 is deprecated. |

### Estates

While two v1 estate endpoints are replaced with Graph queries, version 2.0 introduces a new estate endpoint that allows you to return data about an estate based on the estates ID.

| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | --- |
| `GET /estates` | Returns a list of Estates. **Deprecated** | See example subgraph query below. |  |
| `GET /addresses/:address/estates` | Returns all Estates belonging to the given Ethereum address. **Deprecated** | See example subgraph query below. |  |
|  |  | `GET /v2/estates/:id` | New v2 endpoint that returns metadata about an estate with the given ID. |

To obtain estate data, query the Graph for NFT entities with the condition:

{% raw %}
```
{
  category: estate
}
```
{% endraw %}

### Map

The v1 map endpoint remains unchanged and supported.

| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | --- |
| `GET /map` | Returns all parcels and estates in a given area. This endpoint is **depcrecated** and is replaced by `GET /v1/map.png`|  |  |
| `GET /map.png` | Returns a PNG image of a section of the map. | `GET /v1/map.png` | Returns a PNG image of a section of the map. This endpoint is still supported and functional! There is no v2 version of this endpoint, keep calling the v1 endpoint to get the same data. |
| `GET /parcels/:x/:y/map.png` | Returns a PNG image of a piece of the map centered on the given parcel. | `GET /v1/parcels/:x/:y/map.png` | Returns a PNG image of a map centered on a highlighted parcel with the given coordinates. |
| `GET /estates/:id/map.png` | Returns a PNG image of a piece of the map centered on an estate specified by the estate’s ID. | `GET /v1/estates/:id/map.png` | Returns a PNG image of a map centered on a highlighted estate with the given ID. |

### Mortgages

The mortgage endpoints are all deprecated with the v2 release. Since mortgages are no longer supported in the marketplace, there’s no longer any data in this category to expose via an API or Graph query.

| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | --- |
| `GET /mortgages/:address/parcels` | Returns list of parcels with an active mortgage requested by a given Ethereum address. **Deprecated** |  |  |
| `GET /addresses/:address/mortgages` | Returns all mortgages requested by a given Ethereum address. **Deprecated** |  |  |
| `GET /parcels/:x/:y/mortgages` | Returns all mortgages requested for a given parcel. **Deprecated** |  |  |

### parcels

Some of the parcel endpoints have v2 counterparts, while others are replaced with queries to the Graph. See the chart below for details.

| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | --- |
| `GET /parcels` | Returns a list of all parcels. **Deprecated.** | See the example subgraph query below. |  |
| `GET /addresses/:address/parcels` | Returns a list of all parcels belonging to a given address. **Deprecated.** | See the example subgraph query below. |  |
| `GET /parcels/:x/:y` | Returns a single parcel with the given coordinates. **Deprecated.** | `GET /v2/parcels/:x/:y` | Returns metadata about a parcel with the given coordinates. This new v2 endpoint queries The Graph instead of looking at the deprecated v1 server. |
| `GET /parcels/:tokenId` | Returns a single parcel based on its blockchain ID (also called a token ID). **Deprecated.** | `GET /v2/contracts/:address/tokens/:id` | Returns metadata about a parcel or estate with the given contract address and token/blockchain ID. |
| `GET /parcels/:x/:y/encodedId` | Returns the blockchain/token ID of a parcel based on its coordinates. **Deprecated** | `GET /v2/tiles?x1&x2&y1&y2&include=tokenId` | By setting both x1 and x2 to X and y1 and y2 to Y value, and including only the tokenId property you can find the same data using the new /v2/tiles endpoint. |

To list all parcels owned by one specific address, submit this query to the Graph:

{% raw %}
```
{
  nfts(where:{ category: parcel, owner: "0x..."  }) {
    parcel {
      x
      y
    }
  }
}
```
{% endraw %}

### Publications

The publications endpoints are all replaced with corresponding queries to the Graph.

| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | --- |
| `GET /parcels/:x/:y/publications` | Returns all previous publications for a given parcel. **Deprecated** | See example subgraph query below. |  |
| `GET /publications/:txHash` | Returns a specific publication based on the publication’s transaction hash. **Deprecated.** | See example subgraph query below. |  |

To list all open and non-expired orders, submit this query to the Graph:

{% raw %}
```
{
  orders(where:{ status: open, expiresAt_gt: 1611082372  }) {
    nft {
      name
      contractAddress
      tokenId
    }
    price
  }
}

```
{% endraw %}

### Translations

This is a legacy endpoint that is only used by the UI. It remains supported and unchanged with the v2 release.

| V1 Endpoint | Description | V2 Endpoint | Description |
| --- | --- | --- | --- |
| `GET /translations/:locale` | Returns all available translations for a given ‘locale’ where ‘locale’ can be ‘en’, ‘es’, ‘fr’, ‘ko’, or ‘zh’. |  |  |
