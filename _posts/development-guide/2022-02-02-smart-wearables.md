---
date: 2022-02-02
title: Smart Wearables (Alpha)
description: Create wearables with interactive capabilities
categories:
  - development-guide
type: Document
---


> **WARNING:** Smart wearables are still in Alpha. The Builder does not support the upload of smart wearables, and there isn't an approval process in place to allow community-built smart wearables to be published. The current development tools allow you to create and test smart wearables, but please don't attempt to publish any in the Builder, they will not be approved.


Smart wearables are a type of portable experience. Portable experiences are parts of the gameplay that players take with them as they move through the metaverse. For example, a player could take a snowball from your scene, walk away to another scene, and throw the snowball to another player who’s also playing the same game.

Smart wearables are portable experiences that are turned on when the player puts on a certain item of clothing. Smart wearables can grant players new abilities, like a jetpack that lets them fly, or add a new layer of content on top of the rest of the world, like randomly placing coins to be collected throughout the whole of genesis city.

## Getting started

To create a new smart wearable

1. Make sure you have the latest version of the CLI installed

`npm i -g decentraland@latest`

2. Open a command line in a new folder and run

`dcl init`

When prompted by the command, select `smart wearable (beta)`

This command creates the basic files and structure for a new smart wearable. This folder is very similar to that of a Decentraland scene, but you will notice the following differences:

- `asset.json` includes all of the metadata for the portable experience
- There’s a placeholder 3d model (glasses.glb) and thumbnail (glasses.png) for a pair of dark glasses. You should replace these with the actual wearable you want to use
- `scene.json` is a lot shorter, it doesn’t include properties that are irrelevant to a wearable, like parcels or spawn points

## About Asset.json

The default `asset.json` file looks like this:

```json
{
  "id": <random-id>,
  "assetType": "portable-experience",
  "name": "Portable Experience Example",
  "description": "My new Portable Experience",
  "category": "eyewear",
  "rarity": "mythic",
  "thumbnail": "glasses.png",
  "menuBarIcon": "glasses.png",
  "model": "glasses.glb",
  "bodyShape": "both"
}
```

The following fields are present in `asset.json`:

- `id`: The `dcl init` command generates a random value for this ID.

> NOTE: If you forked your project from an existing one, make sure the ID value is unique before publishing your wearable. Use [uuidgenerator.net](https://www.uuidgenerator.net/) to generate a new random UUID

- `assetType`: This field is required for the preview to identify this project as a portable experience.
- `name`: The name for the wearable that users will see in the marketplace
- `description`: The description of the wearable that users will see in the marketplace. Make sure you indicate what the smart wearable can do, as users of the marketplace will have no way to preview its functinality before buying it.
- `category`: What wearable category to use. Possible values are:

  - 'eyebrows'

  - 'eyes'

  - 'facial_hair'

  - 'hair'

  - 'mouth'

  - 'upper_body'

  - 'lower_body'

  - 'feet'

  - 'earring'

  - 'eyewear'

  - 'hat'

  - 'helmet'

  - 'mask'

  - 'tiara'

  - 'top_head'

  - 'skin'

- `rarity`: The rarity supply of the token. Possible values are:
  - unique (1 copy)
  - mythic (10 copies)
  - legendary (100 copies)
  - epic (1000 copies)
  - uncommon (10.000 copies)
  - common (100.000 copies)
- `thumbnail`: Image to use as thumbnail for the wearable, both in the backpack and the marketplace. This image should be at root level in your folder. The recommended image size is 256x256.
- `menuBarIcon`: Image to use on the “experiences” menu, to represent this portable experience, to represent the portable experience. This image should be at root level in your folder. The recommended image size is 256x256.
- `model`: The 3d model to use for the wearable. This file should be at root level in your folder.
- `bodyShape`: The avatar body type that this wearable is compatible with. Possible values:
  - male
  - female
  - both

## The Preview

Running a preview of a portable experience is just like running that of a scene, simply run `dcl start`. If the `asset.json` file is properly configured and the project is recognized as a portable experience, you’ll notice that all the visible around you are the default empty parcels. In this preview mode, you are not restricted to any set of parcels, you can add 3d models or sounds anywhere in the world.

## Tips

- When positioning an entity, note that positions are global, relative to the 0,0 coordinates of Genesis Plaza.
- To react to nearby players:
  - use `getConnectedPlayers()` to know what players are already there, and `onPlayerConnectedObservable` / `onPlayerDisconnectedObservable to track other players coming and going.
  - Be mindful that the loading of the smart wearable, surrounding scenes and other players may occur in different orders depending on the situation. If the player enters Decentraland with the smart wearable already on, it’s likely that your portable experience will load before other players do. On the other hand, tf the player first loads into a scene and then puts on the wearable, it’s likely that other players will already be loaded by the time the portable experience starts running.
  - Wait till the player is connected to an island inside their realm. Fetch the realm data and check for the ‘room’ field. If the ‘room’ field is null, the player is not yet connected to an island and other players won’t be loaded yet. You can periodically check this every 1 second till the ‘room’ field is present, and only initialize your logic then.
- To interact with surrounding scenes:
  - You can’t directly send any instructions to nearby scenes or other portable experiences, the `messageBus` is currently sandboxed for each portable experience/scene.
  - You can use an intermediate server to send information between the portable experience and a scene.
  - If you do a raycast, you can detect hits against the colliders of entities from the surrounding scenes. This can tell you the exact hit location, normal direction, and even the entity name and mesh name of the 3d model.
- Kill a portable experience: Run the `kill()` method to self-terminate a portable experience.

## Publish

To publish your smart wearable:

1. Make sure the information in `asset.json` is accurate. If you used another project as a starting point, make sure the `id` is a unique identifier, not used by other wearables.

2. Run `dcl pack` on your project folder. This generates a `portable-experience.zip` file in your project folder.

> NOTE: The output of `dcl pack` will indicate the size of the uncompressed exported project, it must be under 2MB. If larger than that, it won’t be accepted by the builder.

3. Open the Builder, open the Collections tab, click + to upload a new wearable.

4. Drag your compressed `portable-expereince.zip` file into the Builder, verify that all the information is accurate.

> Note: If your wearable is an upper_body or a lower_body and meant to be unisex, you need to do a workaround (even if both body shapes use the same model):

    - Select only Male and complete the process
    - Open the wearables in the editor, click the three dot options button, select “upload female representation”, and upload the 3d model for the female shape.

5. Open the editor and make sure the “hide” and “remove” categories are correctly set to disable other wearable categories when this wearable is on.
6. Create a new collection with this and perhaps other wearables.
7. Hit the 3 dots icon next to “Mint Items” and select “See in world”. This will open a tab with the explorer on ropsten, where you can try out all the wearables of your collection in Decentraland, and see how they behave in a more real scenario, for example running around Genesis Plaza.
8. At this point, your wearable is ready to be published. We still don’t encourage creators to publish any smart wearables, as we’re still in experimental stages, reviewers from the committee have been instructed to not approve any smart wearables that don’t come from the foundation.

> Note: There will be a `dcl deploy` command in the future, to enable you to do this process without navigating the Builder UI.

<!--
## Restricted actions

To prevent abuse, certain features aren't permitted on portable experiences, or require adding a permission flag.

The following actions require special permissions

- Send HTTP requests
- Connect to a WebSockets server
... etc
-->

## Limitations

> IMPORTANT: The entire smart wearable needs to fit within 2 MB. This includes the 3d model, thumbnail, code, libraries, sound files, additional 3d models, UI images, etc. This limit is for the uncompressed folder. The builder will not let you upload larger wearables than this.
> To check the size of your portable experience, run `dcl pack`, the project size is specified in the output text of the command. You can also verify this by uncompressing the generated `portable-expereince.zip` file.

Smart wearables only run the portable experience for the player wearing the wearable. Other players don't see the effects. For example, if the portable experience renders a pet that follows the player, other players around won't see this pet.

Smart wearables only work when players have them on. For this reason, players can only have a limited number of activated smart wearables, and depending on what part of the body they take up, some will be incompatible with others. For example, you can’t have two hats at the same time, or a helmet and hair at the same time.

If a wearable is “hidden” but not “removed” by other wearables being worn, then the portable experience can still be on, even if the corresponding wearable is not visible.

## Examples

[Portal-ble expoerence](https://github.com/decentraland-scenes/Portal-ble_experience)

[Graffiti](https://github.com/decentraland-scenes/Smart-wearable-graffitti)

[Radio](https://github.com/decentraland-scenes/Smart-wearable-radio)

[Raycast test](https://github.com/decentraland-scenes/Smart-wearable-raycast-test)

[Realms test](https://github.com/decentraland-scenes/Smart-wearable-realms-test)

[Rocket board](https://github.com/decentraland-scenes/Smart-wearable-rocket-board)

[Scarvenger hunt](https://github.com/decentraland-scenes/Smart-wearable-Scarvenger-hunt)

Xmas 2021:

[Xmas airdrops](https://github.com/nearnshaw/xmas-airdrops)

[Snowball fight](https://github.com/decentraland-scenes/snowball-fight)

[Secret Santa](https://github.com/decentraland-scenes/xmas-secret-santa)
