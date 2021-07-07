---
date: 2018-01-11
title: Colliders
description: Learn how to add colliders to 3D models imported to Decentraland.

categories:
  - 3d-modeling
type: Document
---

To enable collisions between a 3D model and users of your scene, you must create a new object to serve as a collider. Without a collider, players are able to walk through models as if they weren't there. For performance reasons, colliders usually have a much simpler geometry than the model itself.

Colliders currently don't affect how models and entities interact with each other, they can always overlap. Colliders only affect how the model interacts with the player's avatar.

For an object to be recognized by a Decentraland scene as a collider, all it needs is to be named in a certain way. The object's name must include the the suffix “\_collider” at the end.

For example, to create a collider for a tree, you can create a simple box object surrounding its trunk. Players in the scene won't see this box, but it will block their path.

<img src="{{ site.baseurl }}/images/media/collision-tree.png" alt="Entity tree" width="500"/>

In this case, we can name the box "Box*Tree_collider" and export both the tree and the box as a single \_gltf* model. The \_collider tag alerts the Decentraland world engine that the box object belongs to the collection of colliders, making the \_collider mesh invisible.

<img src="{{ site.baseurl }}/images/media/collision-hierarchy.png" alt="Entity tree" width="350"/>

Whenever a player views the tree model in your scene, they will see the complex model for your tree. However, when they walk into your tree, they will collide with the box, not the tree.

## Player spatial constraints

When you design models that are meant for players to walk around in, you need to keep in mind the following reference measurements:

- Players can walk up a step of up to 30 centimeters in height without jumping
- Players can walk up slopes of an angle of up to 45 degrees without jumping
- Players can jump up to 1,8 meters in height
- Avatars measure around 1.9 meters in height, but consider that they might have hats or other wearables on their head.

## Add a collider to a staircase

Stairs are a very common use-case for collider objects. In order for players to climb stairs, there must be a corresponding \_collider object that the players are able to step on.

We recommend using a ramp object for your stair colliders, this provides a much better experience when walking up or down. When they climb up your stairs, it will appear as a smooth ascent or descent, instead of requiring them to “jump” up each individual step.

Using a ramp object also avoids creating unnecessary geometry, saving room for other more complicated models. Keep in mind that collider geometry is also taken into account when calculating the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %})

1.  Create a new object in the shape of a ramp that resembles the size and proportions of the original stairs.

    <img src="{{ site.baseurl }}/images/media/collision-stairs-both.png" alt="Staircase mesh and collider side by side" width="300"/>

2.  Name the ramp object something similar to _stairs_collider_. It must end in \__collider_.

3.  Overlay the ramp object to the stairs so that they occupy the same space.

     <img src="{{ site.baseurl }}/images/media/collision-stairs-collider.png" alt="Overlaid mesh and collider" width="300"/>

4.  Export both objects together as a single _glTF_ model.

    <img src="{{ site.baseurl }}/images/media/collision-stairs.png" alt="Exported 3D model with invisible collider" width="300"/>

Now when players view the stairs in your scene, they’ll see the more elaborate model of the stairs, but when they climb them, they’ll collide with the ramp.

## Best practices with colliders

- Always use the smallest number of triangles possible when creating colliders. Avoid making a copy of a complex object to use as a collider. Simple colliders guarantee a good user-experience in and keep your scene within the triangle limitations.
- Collider objects shouldn't have any material, as players of your scene will never see it. Colliders are invisible to players.
  > Note: Remember that each scene is limited to log2(n+1) x 10000 triangles, where n is the number of parcels in your scene.
- All collider objects names must end with \__collider_. For example, _tree_collider_.
- If you use a _plane_ as a collider, it will only block in one direction. If you want colliders to block from both sides, for example for a wall, you need to create two planes with their normals facing in opposite directions.

- When duplicating collider objects, pay attention to their names. Some programs append a \__1_ to the end of the filename to avoid duplicates, for example _tree_collider_1_. Objects that are named like this will be interpreted by the Decentraland World Engine as normal objects, not colliders.

- You can avoid adding a collider mesh if you add an invisible primitive shape that overlaps to your 3D model in your scene. Primitive shapes have collisions on by default. For example, an entity with a BoxShape() component, and its `visible` property set to false can do the trick.

- If you're creating a 3D model with many mesh shapes that each need their collider, there are some handy add-ons that can help. For Blender you can use [Simple Renaming Panel](https://github.com/Weisl/simple_renaming_panel) to automatically add a `_collider` suffix to all mesh names in a group.
