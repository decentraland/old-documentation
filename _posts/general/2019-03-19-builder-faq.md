---
date: 2019-03-19
title: Builder FAQ
redirect_from:
  - /docs/faq
  - /docs/builder-frequently-asked-questions
description: Frequently Asked Questions for the Decentraland Builder
categories:
  - Decentraland
  - Builder
type: Document
set: general
set_order: 1
---

_How do scene limits work? What are triangles? How about materials? What’s going on?_

Genesis City is a really, really big place. In order to make sure everyone has a smooth experience, there’s a limit to how much stuff each scene can hold.

In the bottom left corner of the Builder, if you click on the set of squares, you’ll find a little list explaining what each of these limits are, and how far along you are to reaching each one. Let’s take a look at each of these:

* **Geometries:** these define different simple shapes, like a box or a wheel.
* **Bodies:** a body is just a copy of a geometry. For example, a bike might have three bodies: the frame and two wheels. By copying similar geometries, we can save resources.
* **Triangles:** each surface of a body is shaped like a triangle. More complex models have more triangles than simpler models.
* **Materials:** materials make your scenes more realistic by describing how a model or shape should look. They change the way light is reflected (or emitted) from different models, and can include one or more textures.
* **Textures:** these are the images used in materials. Textures are images of different patterns and colors - like wood, stone, or grass.
* **Entities:** an entity can include one or more bodies, like the bike in the example above. Entities include everything you need for an asset: the geometries, bodies, materials, and textures.

## I can’t submit my scene to the contest.

There’s two possible reasons for why you can’t submit your scene:
* **You’re getting a network error bug.** This is likely a problem with the scene size. We are aware of the bug and are working on a fix. You should be able to submit other scene sizes (especially even by even scenes).
* **The button is disabled because some of your models are falling off your parcel!** First, try refreshing or re-opening your project. If that doesn’t work, you might have a model hanging over the edges of your scene. Even if it’s barely out-of-bounds, it’ll still flash blue and red. Watch out! Some of these trouble models might be hiding in other objects you’ve put on the edge of your parcel (like trees!).

## Can I upload custom assets?

Right now, the Builder doesn’t let you import custom models from places like Sketchfab. One reason for this is to make the playing field more level for the Creator Contest. Decentraland hopes to add support for custom assets in the future, after the Creator Contest.

## Can I deploy my scene to my land?

Not yet, however, this is a planned feature. The Builder is made to create scenes for Decentraland, so our top priority is making sure you can deploy your scenes to your LAND.

## Can I move items underground?

No, objects cannot be moved below the ground, except in some cases via rotation. You can rotate an object, and have part of the model extend below the ground.

## How do I add images to my scene?

You can’t import, upload, or paste images into the Builder right now.

## Can I share my scenes with other Builder users?

Not yet, but we know you want to! We’re working on ways to support this in the future. Stay tuned! (In the meantime, try entering preview mode to capture some cool screenshots. Press ‘F’ to fly and get that bird’s-eye view.)

## How do I save projects?

Projects save automatically to your local storage. Don’t use the Builder in Incognito/Private Browsing Mode, and don’t clear your cache on exit (this is almost never done unless you are doing it intentionally).

## Can I export my scenes?

The current Builder can’t export your scenes, but we’re planning an export tool in a later release.

## Can I import scenes from the SDK?

Not yet, the Builder handles scenes differently than the SDK, so it doesn’t make sense to import scenes. We’re working on bridging this gap.

## Can I group objects?

We hear you loud and clear, and want to see this tool soon ourselves! Placing lots of similar objects (like trees) or using structures to make buildings would be way easier with a grouping tool, so we’re working on a solution as we type.

## Can I snap/attach items to other items?

No, but you can press and hold Shift for more precise placement when moving objects.

## How does Preview mode work? Can I fly?

Use the W, A, S, and D keys to move around in Preview mode and press F to toggle Fly Mode. If you can’t move, you may be stuck in an object. Changing where you spawn (enter the scene) is a feature we have planned for the future.

## Will there be more floors, walls, and doors?

After the contest ends, we will be releasing way more asset packs, and you’ll even be able to vote on upcoming packs on [Agora](https://agora.decentraland.org), Decentraland’s community voting platform!

## Can I pick the color or texture of items?

Right now, all of the models come with one texture, but we agree that it’d be awesome to have more control over each model’s appearance. The devs are planning ways to change your models’ colors for an upcoming version of the Builder.
