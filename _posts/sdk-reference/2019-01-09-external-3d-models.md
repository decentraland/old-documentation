---
date: 2018-01-09
title: External 3D models
description: Learn what assets and components are supported in external 3D models and how to configure them before importing them to Decentraland.
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 9
---

3D models are imported into decentraland in glTF format. There are a number of supported features that these models can include. This section goes over ways to make them compatible with Decentraland and best practices.

See [Scene content guide]({{ site.baseurl }}{% post_url /documentation/sdk-reference/2018-01-21-scene-content-guide %}) for information on how you can configure a 3D model in a Decentraland scene to set its position, scale, activate its animations, etc.

Keep in mind that all models, their shaders and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /documentation/sdk-reference/2018-01-06-scene-limitations %}).

## 3D model formats

All 3D models in Decentraland must be in glTF format. [glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common, extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

glTF models can have either a _.gltf_ or a _.glb_ extension. glTF files are human-readable, you can open one in a text editor and read it like a JSON file. This is useful, for example, to verify that animations are properly attached and to check for their names. glb files are binary, so they're not readable but they are considerably smaller in size, which is good for the scene's performance.

We recommend using _.gltf_ while you're working on a scene, but then switching to _.glb_ when uploading it.

When using Blender to create or edit 3D models, you need an add-on to export glTF files. For models that don't include animations we recommend installing the add-on by [Kronos group](https://github.com/KhronosGroup/glTF-Blender-Exporter). To export glTFs that include animations, you should instead install the add-on by [Kupoman](https://github.com/Kupoman/blendergltf).

> Note: obj models are also supported as a legacy feature, but will likely not be supported for much longer.

#### Why we use glTF?

Compared to the older _OBJ format_, which supports only vertices, normals, texture coordinates, and basic materials,
glTF provides a more powerful set of features. In addition to all of the features we just named, glTF also offers:

- Hierarchical objects
- Scene information (light sources, cameras)
- Skeletal structure and animation
- More robust materials and shaders

OBJ can currently be used for simple models that have no animations, but we will probably stop supporting it in the future.

Compared to _COLLADA_, the supported features are very similar. However, because glTF focuses on providing a
"transmission format" rather than an editor format, it is more interoperable with web technologies.

Consider this analogy: the .PSD (Adobe Photoshop) format is helpful for editing 2D images, but images must then be converted to .JPG for use
on the web. In the same way, COLLADA may be used to edit a 3D asset, but glTF is a simpler way of transmitting it while rendering the same result.

## Colliders

To enable collisions between a 3D model and users of your scene, you must create a new object to serve as a collider. Without a collider, users are able to walk through models as if they weren't there. For performance reasons, colliders usually have a much simpler geometry than the model itself.

Colliders currently don't affect how models and entities interact with each other, they can always overlap. Colliders only affect how the model interacts with the user's avatar.

For an object to be recognized by a Decentraland scene as a collider, all it needs is to be named in a certain way. The object's name must include the the suffix “\_collider” at the end.

For example, to create a collider for a tree, you can create a simple box object surrounding its trunk. Users of the scene won't see this box, but it will block their path.

![](/images/media/collision-tree.png)

In this case, we can name the box "Box*Tree_collider" and export both the tree and the box as a single \_gltf* model. The \_collider tag alerts the Decentraland world engine that the box object belongs to the collection of colliders, making the \_collider mesh invisible.

![](/images/media/collision-hierarchy.png)

Whenever a player views the tree model in your scene, they will see the complex model for your tree. However, when they walk into your tree, they will collide with the box, not the tree.

#### Collider objects for stairs

Stairs are a very common use-case for collider objects. In order for users to climb stairs, there must be a corresponding \_collider object that the users are able to step on.

We recommend using a ramp object for your stair colliders, this provides a much better experience when walking up or down. When they climb up your stairs, it will appear as a smooth ascent or descent, instead of requiring them to “jump” up each individual step.

Using a ramp object also avoids creating unnecessary geometry, saving room for other more complicated models. Keep in mind that collider geometry is also taken into account when calculating the [scene limitations]({{ site.baseurl }}{% post_url /documentation/sdk-reference/2018-01-06-scene-limitations %})

![](/images/media/collision-stairs-both.png)

The image above shows a stairs model on the left, this is what users will see in the scene. On the right, we’ve created a new object in the shape of a ramp that matches the size and height of our stairs.

We should name the collider object something like `stairs_collider`.

![](/images/media/collision-stairs-collider.png)

Then overlay the ramp object to the stairs so that they occupy the same space, and export them both together as a single _glTF_ model.

![](/images/media/collision-stairs.png)

Now when users view the stairs in your scene, they’ll see the more elaborate model of the stairs, but when they climb them, they’ll collide with the ramp.

#### Best practices with colliders

- Always use the smallest number of triangles possible when creating colliders. Avoid making a copy of a complex object to use as a collider. Simple colliders guarantee a good user-experience in and keep your scene within the triangle limitations.
- Collider objects shouln't have any material, as users of your scene will never see it. Colliders are invisible to users.
  > Note: Remember that each scene is limited to log2(n+1) x 10000 triangles, where n is the number of parcels in your scene.
- All collider objects names must end with \__collider_. For example, _tree_collider_.
- When duplicating collider objects, pay attention to their names. Some programs append a \__1_ to the end of the filename to avoid duplicates, for example _tree_collider_1_. Objects that are named like this will be interpreted by the Decentraland World Engine as normal objects, not colliders.

- To view the limits of all collider meshes in a Decentraland scene, launch your scene preview with `dcl start` and then click `c`. This draws blue lines that delimit all colliders in place.

## Animations

3D models can be animated in a Decentraland scene using skeletal animations.

Currently, only skeletal animations (based on a an armature) are supported.

You can include any number of animations in a _glTF model_. There's no specific rule about the names animations must have.

You can verify the names of the animations in a model by opening the contents of a _.gltf_ file with a text editor. Typically, an animation name is comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

All animations in a _glTF_ model are dissabled by default when loading the model into a Decentraland scene. See [Scene content guide]({{ site.baseurl }}{% post_url /documentation/sdk-reference/2018-01-21-scene-content-guide %}) for instructions on how to activate and handle animations in a scene.

> Note: There currently isn't a way to change the frame rate of an animation displayed in your scene, the speed is fixed to a default setting. To change an animation's speed, you must change the number of frames.

In a Decentraland scene, you can use `weight` to blend several animations or to make an animation more subtle.

> Tip: Instead of creating your own animations, you can also download generic animations and apply them to your model. For example, for 3D characters with human-like characteristics, you can download free or paid animations from [Mixamo](https://www.mixamo.com/#/).

#### Creating an animation

You can use a tool like Blender to create animations for a model.

1.  Create an armature for your model. The bones in the armature define the points that can be articulated.

2.  Link the armature to the mesh, making it a child asset of the same object.

3.  Check that the model moves naturally when rotating its bones. If the model gets stretched in undesired ways, use weight paint to change what parts of the model are affected by each bone in the armature.

4.  Move the armature into poses and lock the rotation and scale

5.  Create several frames over time.

6.  Optionally set the transitions between frames.

The transition between each pose occurs as linear by default.

link the armature to the model by making the armature a child element of the bird mesh. Once matched, move the parts of the armature around to check that the mesh follows it in ways that look natural. If the model gets deformed in weird ways, then you can use weight paint to change what parts of the model are affected by each bone in the armature.

To create several animations, select the Dope-Sheet view, and open the Action Editor. You can also use the Dope-Sheet view to edit the frames, like adjusting the time between two frames or making a frame store only the position of certain bones of the armature.

#### Best practices for animations

- Keep the armature simple, only create bones for the parts of the model that you intend to animate.
- If the animation will be looped in your scene, make sure the final pose is identical to the starting pose to avoid jumps.
- Sometimes in an animation you might want to only specify positions and rotations for the parts of the armature that will move, and leave bones that don't move undefined. This can make it easier to combine animations together.
- Animated characters in your scene sholdn't ever stay completely still, even when they aren't doing anything. It's best to create an "idle" animation to use for when the character is till, this can make it perform subtle movements like breathing and perhaps looking around occasionally.

<!--

## Materials

- materials (todo lo que hay en content guide es lo que seteas en los entities)

hay dos tipos de matierol, “standard materials” que es lo mismo que “blender render”

- diffuse / specular
  y dps los PBR (phisically based rendering)

- textures
  aclarar tamaños
  capaz extensiones de archivos
  capaz alpha
  capas especiales para pbr

animations y materials son “assets” para unity
un collider es ponele un “component”

-->
