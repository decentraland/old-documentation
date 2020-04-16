---
date: 2019-03-19
title: Builder FAQ
redirect_from:
description: Frequently Asked Questions for the Decentraland Builder
categories:
  - Decentraland
type: Document
---

_How do scene limits work? What are triangles? How about materials? What’s going on?_

Genesis City is a really, really big place. In order to make sure everyone has a smooth experience, there’s a limit to how much stuff each scene can hold.

In the bottom left corner of the Builder, if you click on the set of squares, you’ll find a little list explaining what each of these limits are, and how far along you are to reaching each one. Let’s take a look at each of these:

- **Geometries:** these define different simple shapes, like a box or a wheel.
- **Bodies:** a body is just a copy of a geometry. For example, a bike might have three bodies: the frame and two wheels. By copying similar geometries, we can save resources.
- **Triangles:** each surface of a body is shaped like a triangle. More complex models have more triangles than simpler models.
- **Materials:** materials make your scenes more realistic by describing how a model or shape should look. They change the way light is reflected (or emitted) from different models, and can include one or more textures.
- **Textures:** these are the images used in materials. Textures are images of different patterns and colors - like wood, stone, or grass.
- **Entities:** an entity can include one or more bodies, like the bike in the example above. Entities include everything you need for an asset: the geometries, bodies, materials, and textures.

## I can’t upload my scene because it says something is out of bounds, what does that mean?

This is likely because some of your models are falling off the edges of your scene. Even if it’s barely out-of-bounds, it’ll still be marked in red. Watch out! Some of these troubled models might be hiding in other objects you’ve put on the edge of your parcel (like trees!).

## Can I upload custom assets?

Yes, you can import 3D models in `.gltf` and `.glb` formats. To do so, either click the plus sign at the top of the Asset list, or click the **NEW ASSET PACK** button at the bottom of the list. Then follow the instructions to import one or more 3d models. You will then find your assets in their own asset pack on the right-hand menu.

## Can I deploy my scene to my land?

Yes, you can deploy to land you own, or land where you have deploy permissions. To do so, click the **UPDATE SCENE** button on the top-right, then you can choose what parcels to deploy it to, and orient the scene in the right direction to fit these.

To do so, you need to have the Metamask or Dapper account that owns the parcels or the permissions open on your browser.

## Can I move items underground?

Yes, you can place an object underground, or partially underground. However, the floor on the scene can't be removed, so you can't do tunnels or holes for players to see what's underground.

## How do I add images to my scene?

You can’t import, upload, or paste images into the Builder right now. You can however import a custom 3D model that has an image on as a texture.

## Can I share my scenes with other Builder users?

Yes, the _Share_ button on the top-right of the screen lets you share a link or a post on Twitter or Facebook that can let others view and explore the scene as players.

## How do I save projects?

Projects are saved automatically to your account.

## Can I export my scenes?

Yes, just click the **Download scene** icon on the top-right corner. You can either import that scene back into the builder, or work on it to add extra functionality to it, by writing code with the SDK.

## Can I import scenes from the SDK?

No, you can export scenes _to_ the SDK, but not the other way round.

## Can I group objects?

You can multi-select objects by pressing _control_ and keeping it pressed while selecting more, and then apply actions to that group.

## Can I snap/attach items to other items?

No, but you can press and hold Shift for more precise placement when moving objects.

## How does Preview mode work?

Use the W, A, S, and D keys to move around in Preview mode, and Space to jump. If you can’t move, you may be stuck in an object. Changing where you spawn (enter the scene) is a feature we have planned for the future.

## Can I pick the color or texture of items?

Right now, all of the models come with one texture, but we agree that it’d be awesome to have more control over each model’s appearance. You can however export a 3D model, edit it in a 3D modeling tool, and import it again into a custom asset pack.

## Where can I find the default Builder 3D models if I want to edit them?

You can find all of these models in [this repo](https://github.com/decentraland/builder-assets/tree/master/assets). You can also add the models you wish to a scene in the Builder and then export that scene, and you'll find the used models in a folder.

Before editing the models, see the [3D Modeling section of our docs]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %}).

## Can I create my own smart items?

Yes. Doing that requires using code and being familiar with the Decentraland SDK. You can find details [here]({{ site.baseurl }}{% post_url /development-guide/2020-02-20-smart-items %}).
