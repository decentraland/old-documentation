---
date: 2022-03-17
title: Hand out POAP Tokens
description: Give away POAP tokens to players that visit your scene
categories:
  - development-guide
type: Document
---

[Proof Of Attendance Protocol (POAP)](https://app.poap.xyz) tokens are tokens on the Polygon Ethereum side-chain that serve as evidence of having been to an event. These tokens have become quite popular in Decentraland events. Scenes can gift these tokens to players that visit an event, or to players that achieve a special challenge in a scene.

The Decentraland Foundation has set up a free server that you can use to manage the sending of POAP tokens. This document explains how you can use this server to enable your scene to give away POAP tokens to players who visit.

## Creating the POAP event

The first thing you need to do is to create a POAP event at the [POAP website](https://app.poap.xyz/admin/events/new). When creating the event, provide an event name, date and artwork to use for the token's representation. Fill the field "How many mint links do you need" with the total supply of tokens you need for your event. You can also provide optional imformation like a location, website link, etc.

> Note: If you set Expiry Date, the token will only be claimable before that date. This is useful if you don't want players to be able to claim tokens after the actual event.

Once you save your event, you'll receive an email to the address you provided in the form. Make sure you take note of the **Event Id** and the **Edit Code**, both shared in the e-mail.

> Important: Remember that the **Edit Code** is private and you **MUST NOT** share that number with anyone.

The POAP team performs manual approvals on all event submissions. It may take some time until your event gets approved. Once your event is approved, you'll receive an email with a list of unique claim codes, one for each copy of the token that you requested to mint.

## Set up the Decentraland POAP server

Once your POAP event is approved, you can register it in the Decentraland POAP server.

There are two ways to do this:

### Via UI

@Coming soon

### Via API

Send a series of requests to the Decentraland POAP API, at `https://poap-api.decentraland.org`

1. Create a reference to the event. The body of this request must include the event's edit code and a list of Decentraland coordinates from where the token can ble claimed.

> Note: A player **MUST** be in Decentraland standing on one of the provided coordinates to be allowed to claim your POAP.

```bash
$ curl -X POST 'https://poap-api.decentraland.org/event/{event_id}' -d '{"editCode": "{edit_code}", "coordinates": "{coordinates}"}'

# Example
$ curl -X POST 'https://poap-api.decentraland.org/event/29108' -d '{"editCode": "1234567", "coordinates": "-126,-77;126,-78;126,-77"}'

# Response
{
  "ok": true,
  "data": {
    "uuid": "82f0d212-4250-4cd1-8dc4-df59aedf3756", #dcl_poap_event_id
    "event": {
      "id": 29107,
      "fancy_id": "my-decentraland-POAP-event",
      "name": "My Decentraland POAP Event",
      "event_url": "",
      "image_url": "https://assets.poap.xyz/sugar-club-graffitikings-party-dcl-2022-logo-1644843635157.png",
      "country": "",
      "city": "",
      "description": "My Decentraland POAP Event",
      "year": 2022,
      "start_date": "18-Feb-2022",
      "end_date": "18-Feb-2022",
      "expiry_date": "18-Mar-2022",
      "from_admin": false,
      "virtual_event": true,
      "event_template_id": 0,
      "event_host_id": 0,
      "private_event": false
    }
  }
}
```

The response body includes an `id` field, and a `uuid` (`dcl_poap_event_id`) field. These ids can be shared freely, take note of them as you'll need them later.

2. Once the refernce to the event is successfully created, add the list of claim codes to the event. The URL includes the event's ID that you got in the response from the last request, the body must include event's edit code that you got from the POAP API.

```bash
$ curl -X POST 'https://poap-api.decentraland.org/addcodes/{event_id}' -d '{"editCode": "{edit_code}"}'

# Example
$ curl -X POST 'https://poap-api.decentraland.org/addcodes/29107' -d '{"editCode": "1234567"}'

# Response
{
  "ok": true,
  "data": {
    "url": "/addcodes/29108",
    "body": {
      "num": 10 # qty of claims
    }
  }
}
```

> Note: You don't need to send the actual list of claim codes that POAP sent you via email. The Decentraland POAP server fetches these claim codes on its own when you send this request.

#### Run tests

Once the POAP event has been sucessfully set up, you can validate it by fetching event info.

This request requires sending the `uuid` (`dcl_poap_event_id`), which was returned as part of the response when creating the reference to the event in the Decentraland POAP API.

```bash
$ curl -X GET 'https://poap-api.decentraland.org/event/{dcl_poap_event_id}'

# Example
$ curl -X GET 'https://poap-api.decentraland.org/event/82f0d283-4250-4cd1-8dc0-df59aedf3756'

# Response

{
  "ok": true,
  "data": {
    "id": 24786,
    "uuid": "acd27e4b-24bd-4040-b715-c0e11e863fb0",
    "fancy_id": "hprivakos-poap-test-2022",
    "name": "HPrivakos POAP test",
    "event_url": "",
    "image_url": "https://assets.poap.xyz/hprivakos-poap-test-2022-logo-1643242349519.png",
    "country": "",
    "city": "",
    "description": "Test event for HPrivakos POAP server",
    "year": 2022,
    "event_start_date": "2022-01-01T00:00:00.000Z",
    "event_end_date": "2022-12-31T00:00:00.000Z",
    "created_at": "2022-02-18T12:24:28.893Z",
    "enabled": true,
    "coordinates": "-126,-77",
    "distribution_start_date": null,
    "distribution_end_date": null
  }
}
```

## Implement in your scene

Once you have the Decentraland POAP server set up, you can create a scene that interacts with this server to hand out POAPs to players.

See the [POAP booth example scene](https://github.com/decentraland-scenes/POAP-Booth).

For simple implementations of the POAP booth:

1. Copy the folders `models`, `sounds` and `src/booth` from this scene into yours,

2. Install the dependencies with
   `npm i -B @dcl/ui-scene-utils @dcl/ecs-scene-utils`

3. Add the booth in your game.ts with:

```ts
import { Dispenser } from "./booth/dispenser"

const POAPBooth = new Dispenser(
  {
    position: new Vector3(8, 0, 8),
    rotation: Quaternion.Euler(0, 0, 0),
  },
  "dcl_event_uuid"
)
```

You need to change the `dcl_event_uuid` to the event id you get from the Decentraland POAP server.

If you wish to do something more custom, this scene is also a great starting point, as it already handles all of the interactions with the server and UI notifications.

> NOTE: The claiming of the POAP will not work when running the scene in preview or on a test server, as the Decentraland POAP server can't validate that the request comes from a player in Decentraland. You will need to deploy the scene to production to test fully.
