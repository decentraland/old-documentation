---
date: 2018-01-09
title: 3D model considerations
description: Learn what assets and components are supported in external 3D models and how to configure them before importing them to Decentraland.
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 9
---

3D models are imported into decentraland in glTF format. There are a number of supported features that these models can include. This section goes over ways to make them compatible with Decentraland and best practices.

See [Scene content guide]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) for information on how you can configure a 3D model in a Decentraland scene to set its position, scale, activate its animations, etc.

Keep in mind that all models, their shaders and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-06-scene-limitations %}).

## Materials

#### Shader support

Not all shaders can be used in models that are imported into Decentraland. Make sure you use one of the following:

- Standard materials: any shaders are supported, for example diffuse, specular, transparency, etc.

  > Tip: When using Blender, these are the materials supported by _Blender Render_ rendering.

- PBR (Physically Based Rendering) materials: This shader is extremely flexible, as it includes properties like diffuse, roughness, metalness and emission that allow you to configure how a material interacts with light.

  > Tip: When using Blender, you can use PBR materials by setting _Cycles_ rendering and adding the _Principled BSDF_ shader. Note that none of the other shaders of the _Cycles_ renderer are supported.

See [entity interfaces]({{ site.baseurl }}{% post_url /sdk-reference/2018-06-21-entity-interfaces %}) for a full list of all the properties that can be configured in a material.

#### Textures

Textures can be embedded into the exported glTF file or referenced from an external file. Both ways are supported.

<!--

There are different kinds of textures you can use in a 3D model:

- albedo textures: don't use light
- alpha textures: determine only the transparency regions and its degree
- bump texture: Stores surface normal data used to displace a mesh in a texture. Used with BPR.
- emisiveTexture
- refractionTexture



link to content guide to show how you set materials for primitives

what extensions are supported for image files?
anything special to use alpha

what special layers PBR uses?

show how to change a model with an unsopported shader. Delete material, create new and assign the same texture it used to have

-->

#### Texture size constraints

Texture sizes must use width and height numbers (in pixels) that match the following numbers:

```
1, 2, 4, 8, 16, 32, 64, 128, 256, 512
```

> This sequence is made up of powers of two: `f(x) = 2 ^ x` . 512 is the maximum number we allow for a texture size. This is a fairly common requirement among other rendering engines, it's there due internal optimizations of the graphics processors.

The width and height don't need to have the same number, but they both need to belong to this sequence.

**The recommended size for textures is 512x512**, we have found this to be the optimal size to be transported through domestic networks and to provide reasonable loading/quality experiences.

Examples of other valid sizes:

```
32x32
64x32
512x256
512x512
```

> Although textures of arbitrary sizes work in the alpha release, the engine displays an alert in the console. We will enforce this restriction in coming releases and invalid texture sizes will cease to work.

#### Best practices for materials

- If your scene includes multiple models that use the same texture, reference the texture as an external file instead of having it embedded in the 3D model. Embedded textures get duplicated for each model and add to the scene's size.

## Supported 3D model formats

All 3D models in Decentraland must be in glTF format. [glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common, extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

glTF models can have either a _.gltf_ or a _.glb_ extension. glTF files are human-readable, you can open one in a text editor and read it like a JSON file. This is useful, for example, to verify that animations are properly attached and to check for their names. glb files are binary, so they're not readable but they are considerably smaller in size, which is good for the scene's performance.

We recommend using _.gltf_ while you're working on a scene, but then switching to _.glb_ when uploading it.

> Note: When using Blender to create or edit 3D models, you need an add-on to export glTF files. For models that don't include animations we recommend installing the add-on by [Kronos group](https://github.com/KhronosGroup/glTF-Blender-Exporter). To export glTFs that include animations, you should instead install the add-on by [Kupoman](https://github.com/Kupoman/blendergltf).

#### Why we use glTF

Compared to the older _OBJ format_, which supports only vertices, normals, texture coordinates, and basic materials,
glTF provides a more powerful set of features that includes:

- Hierarchical objects
- Skeletal structure and animation
- More robust materials and shaders
- Scene information (light sources, cameras)

> Note: _.obj_ models are supported in Decentraland scenes as a legacy feature, but will likely not be supported for much longer.

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

Using a ramp object also avoids creating unnecessary geometry, saving room for other more complicated models. Keep in mind that collider geometry is also taken into account when calculating the [scene limitations]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-06-scene-limitations %})

1.  Create a new object in the shape of a ramp that resembles the size and proportions of the original stairs.

![](/images/media/collision-stairs-both.png)

2.  Name the ramp object something similar to _stairs_collider_. It must end in \__collider_.

3.  Overlay the ramp object to the stairs so that they occupy the same space.

![](/images/media/collision-stairs-collider.png)

4.  Export both objects together as a single _glTF_ model.

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

3D models can be animated in a Decentraland scene using skeletal animations. All animations of a 3D model must be embedded inside its _glTF_ file, you can't reference animations in separate files.

Currently, other forms of animations that aren't based on armatures are not supported.

There's no specific rule about the names animations must have. You can verify the names of the animations in an exported model by opening the contents of a _.gltf_ file with a text editor. Typically, an animation name is comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

You can include any number of animations in a _glTF model_. All animations in a _glTF_ model are dissabled by default when loading the model into a Decentraland scene. See [Scene content guide]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) for instructions on how to activate and handle animations in a scene.

> Note: There currently isn't a way to change the frame rate of an animation displayed in your scene, the speed is fixed to a default setting. To change an animation's speed, you must change the number of frames.

In a Decentraland scene, you can use `weight` to blend several animations or to make an animation more subtle.

> Tip: Instead of creating your own animations, you can also download generic animations and apply them to your model. For example, for 3D characters with human-like characteristics, you can download free or paid animations from [Mixamo](https://www.mixamo.com/#/).

#### Creating an animation

You can use a tool like Blender to create animations for a 3D model.

1.  Create an armature, following the shape of your model and the parts you wish to move. You do this by adding an initial bone and then extruding all other bones from the vertices of that one. Bones in the armature define the points that can be articulated. The armature must be positioned overlapping the mesh.

    ![](/images/media/armature_hummingbird1.png)

2.  Make both the armature and the mesh child assets of the same object.

3.  Check that the mesh moves naturally when rotating its bones in the ways you plan to move it. If parts of the mesh get stretched in undesired ways, use weight paint to change what parts of the model are affected by each bone in the armature.

    ![](/images/media/animations_hummingbird_wp1.png)

    ![](/images/media/animations_hummingbird_wp2.png)

> Note: There's a reported bug with Babylon.js that prevents some faces of a mesh from being rendered when they're not related to any bone in the armature. So if you paint some faces with weight 0 and then animate the model, you might see these faces dissappear. To solve this, we recommend making sure that each face is related to at least one bone of the armature and painted with a weight of at least 0.01.

4.  Move the armature to a desired pose, all bones can be rotated or scaled. Then lock the rotation and scale of the bones you wish to control with this animation.

    ![](/images/media/armature_hummingbird2.png)

5.  Switch to a different frame in the animation, position the armature into a new pose and lock it again. Repeat this process for all the key frames you want to set to describe the animation.

    ![](/images/media/armature_hummingbird_animation.png)

6.  By default all frames in between the ones you defined will transition linearly from one pose to the next. You can also configure these transitions to behave exponentially, ease-in, bounce, etc.

To create several animations for the same model in Blender, you must select the Dope-Sheet view, and open the Action Editor. You can also edit the animation from the Dope-Sheet view, for example you can adjusting the distance between two key frames.

When adding the model to your Decentraland scene, you must activate animations by configuring the _gltf-model_ entity. See [Scene content guide]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) for instructions.

#### Best practices for animations

- Keep the armature simple, only create bones for the parts of the model that you intend to animate.
- If the animation will be looped in your scene, make sure the final pose is identical to the starting pose to avoid jumps.
- Sometimes in an animation you might want to only control the movements of parts of the armature, and leave other bones undefined. This can make it easier to combine animations together.
- Animated characters in your scene shouldn't ever stay completely still, even when they aren't doing anything. It's best to create an "idle" animation to use for when the character is still. The idle animation can include subtle movements like breathing and perhaps occasional glances.
- Make sure your model only has one armature when you export it. Sometimes, when importing another animation to the program where you're editing your model, it will bring in a copy of the armature. You want all animations of the model to be performed by the same base armature.
- When exporting the _glTF_ model, make sure you're exporting all the objects and animations. Some exporters will only export the _currently selected_ by default.
