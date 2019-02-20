---
date: 2018-01-09
title: 3D model considerations
description: Learn what assets and components are supported in external 3D models and how to configure them before importing them to Decentraland.
redirect_from:
  - /sdk-reference/external-3d-models/
categories:
  - development-guide
type: Document
set: development-guide
set_order: 9
---

3D models are imported into decentraland in glTF format. There are a number of supported features that these models can include. This section goes over ways to make them compatible with Decentraland and best practices.

See [Set entity position]({{ site.baseurl }}{% post_url /development-guide/2018-01-12-entity-positioning %}) for information on how you can configure a 3D model in a Decentraland scene to set its position, scale, etc.

Keep in mind that all models, their shaders and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}).

## Supported 3D model formats

All 3D models in Decentraland must be in glTF format. [glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common, extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

glTF models can have either a _.gltf_ or a _.glb_ extension. glTF files are human-readable, you can open one in a text editor and read it like a JSON file. This is useful, for example, to verify that animations are properly attached and to check for their names. glb files are binary, so they're not readable but they are considerably smaller in size, which is good for the scene's performance.

We recommend using _.gltf_ while you're working on a scene, but then switching to _.glb_ when uploading it.

The following aspects of a 3D model can either be embedded in a _glTF_ file or referenced externally:

- Textures can either be embedded or referenced from an external image file.
- Binary data about geometry, animations, and other buffer-related aspects of the model can either be embedded or referenced from an external _.bin_ file.

> Note: Animations _must_ be embedded inside the _glTF_ file to use in Decentraland.

#### Export to glTF from Blender

Blender doesn't support exporting to glTF by default, but you can install a plugin to enable it.

1. Download the [Khronos Exporter](https://github.com/KhronosGroup/glTF-Blender-Exporter)
2. To install the exporter, extract the _.zip_ file, and then copy the `scripts/addons/io_scene_gltf2` folder under the `scripts/addons` folder in your Blender installation.
3. Activate the addon by opening _User Preferences…_ in Blender. In the _Add-ons_ tab, enable **Import-Export: glTF 2.0 format**. Don’t forget to click _Save User Settings_.
   > Note: If you have another glTF 2.0 exporter installed, disable it. Only one can be enabled at a time.

When exporting 3D models that include multiple animations, make sure that all animations are embedded in the model. To do this, open the _NLA editor_ and click _Stash_ to add each animation to the model.

We recommend using the following export settings when exporting models with animations:

<img src="/images/media/blender-export-settings-animations.png" alt="Blender export menu" width="250"/>

#### Export to glTF from 3D Studio Max

3D Studio Max doesn't support exporting to glTF by default, but you can install a plugin to enable it.

1. Download the plugin from [this link](https://github.com/BabylonJS/Exporters/tree/master/3ds%20Max).
2. Install the plugin by following [these instructions](http://doc.babylonjs.com/resources/3dsmax#how-to-install-the-3ds-max-plugin).
3. Export glTF files using the plugin by following [these instructions](http://doc.babylonjs.com/resources/3dsmax_to_gltf).

#### Export to glTF from Maya

Maya doesn't support exporting to glTF by default, but you can install a plugin to enable it.

1. Install the plugin by following [these instructions](http://doc.babylonjs.com/resources/maya).
2. Export glTF files using the plugin by following [these instructions](http://doc.babylonjs.com/resources/maya_to_gltf#pbr-materials).

> Note: As an alternative, you can try [this other plugin](https://github.com/WonderMediaProductions/Maya2glTF) too.

#### Export to glTF from Unity

Unity doesn't support exporting to glTF by default, but you can install a plugin to enable it.

Download the plugin from [this link](https://github.com/sketchfab/Unity-glTF-Exporter).

> Note: As an alternative, you can try [this other plugin](https://assetstore.unity.com/packages/tools/utilities/collada-exporter-for-unity2017-99793) too.

#### Export to glTF from SketchUp

SketchUp doesn't support exporting to glTF by default, but you can install a plugin to enable it.

Download the plugin from [this link](https://extensions.sketchup.com/en/content/gltf-exporter).

#### Preview a glTF model

A quick and easy way to preview the contents of a glTF model before importing it into a scene is to use the [Babylon.js Sandbox](https://sandbox.babylonjs.com/). Just drag and drop the glTF file (and its _.bin_ file if applicable) into the canvas to view the model.

In the sandbox you can also view the animations that are embedded in the model, select which to display by picking it out of a dropdown menu.

![](/images/media/babylon-sandbox.png)

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

## Materials

#### Shader support

Not all shaders can be used in models that are imported into Decentraland. Make sure you use one of the following:

- Standard materials: any shaders are supported, for example diffuse, specular, transparency, etc.

  > Tip: When using Blender, these are the materials supported by _Blender Render_ rendering.

- PBR (Physically Based Rendering) materials: This shader is extremely flexible, as it includes properties like diffuse, roughness, metalness and emission that allow you to configure how a material interacts with light.

  > Tip: When using Blender, you can use PBR materials by setting _Cycles_ rendering and adding the _Principled BSDF_ shader. Note that none of the other shaders of the _Cycles_ renderer are supported.

The image below shows two identical models, created with the same colors and textures. The model on the left uses all _PBR_ materials, some of them include _metalness_, _transparency_, and _emissiveness_. The model on the right uses all _standard_ materials, some including _transparency_ and _emissiveness_.

![](/images/media/materials_pbr_basic.png)

#### Transparent and emissive materials

You can set a material to be _transparent_. Transparent materials can be seen through to varying degrees, depending on their _alpha_. To do this, activate the transparency property of the material and then set its _alpha_ to the desired amount. An alpha of 1 will make the material completely opaque, an alpha of 0 will make it invisible.

You can also make a material _emissive_. Emissive materials cast their own light. Note that when rendered, they don't actually illuminate nearby objects in the scene, they just seem to have a blurred glow around them.

The image below shows two identical models created with standard materials. The one on the left uses only opaque materials, the one on the right uses both transparent and emissive materials in some of its parts.

![](/images/media/materials_transparent_emissive.png)

#### Textures

Textures can be embedded into the exported glTF file or referenced from an external file. Both ways are supported.

<!--

There are different kinds of textures you can use in a 3D model:

- albedo textures: don't use light
- alpha textures: determine only the transparency regions and its degree
- bump texture: Stores surface normal data used to displace a mesh in a texture. Used with BPR.
- emissiveTexture
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

#### How to swap a material

Suppose you've imported a 3D model that uses a material that's not supported by Decentraland. You can easily change this material while still keeping the same texture and its mapping.

<img src="/images/media/materials-not-supported.png" alt="Model without valid material" width="250"/>

To swap the material:

1. Check the current material's settings to see what texture files are being used and how they are configured.
2. Delete the current material from the mesh.

   ![](/images/media/materials_delete_material.png)

3. Create a new material.

    <img src="/images/media/materials_new_material.png" alt="New default basic material" width="400"/>

   > Tip: If you're using Blender and are on the _Blender Render_ tab, it creates a basic material by default, which is supported by Decentraland.

4. Open the _Textures_ settings and create a new texture, importing the same image file that the original material used.

   <img src="/images/media/materials_new_texture.png" alt="New default basic texture" width="300"/>

5. The texture should be mapped to the new material just as it was mapped to the old material.

   <img src="/images/media/materials_final.png" alt="Model with valid material" width="300"/>

#### Best practices for materials

- If your scene includes multiple models that use the same texture, reference the texture as an external file instead of having it embedded in the 3D model. Embedded textures get duplicated for each model and add to the scene's size.
  > Note: After referencing a file for a texture that won’t be embedded, make sure that file won’t be moved or renamed, as otherwise the reference to the file will be lost. The file must also be inside the scene folder so that it’s uploaded together with the scene.
- Read [this article](https://www.khronos.org/blog/art-pipeline-for-gltf) for a detailed overview of a full art pipeline that uses PBR textures in glTF models.
- Find free, high quality PBR textures in [cgbookcase](https://cgbookcase.com/).

## Meshes

3D models have a _mesh_ composed of triangular _faces_. These faces meet each other on _edges_ (the lines along which they touch) and _vertices_ (the points where their corners join).

#### Scene limits

All 3D models in your scene must fit within the limits of its parcels. If they extend beyond these limits when running a preview, the meshes will be marked in red and bounding boxes will be highlighted in white.

For performance reasons, Decentraland checks the positions of the _bounding boxes_ around meshes (not the vertices in the meshes themselves) to verify that they are within the scene's limits. 

If you have a model that has all of its vertices neatly inside the scene area, but that has large bounding boxes that are mostly empty and extend beyond the scene limits, the entire model will be marked as outside the scene limits.

To avoid this problem, you can clean up your 3D models to reset positions and rotations of meshes so that bounding boxes don't extend beyond the meshes they wrap.


#### Smooth geometries

You can configure a mesh to be _smooth_. This tells the engine to render its shape as if there was an infinite number of intermediate faces rounding it off. This setting can greatly help you reduce the number of triangles needed to make a shape appear to be rounded.

The image below shows two identical models with the same materials. They differ in that the one on the right has most of its geometry set to _smooth_.

![](/images/media/meshes_smooth_vs_sharp.png)

Note how you can see distinct faces on all of the cylindrical shapes of the model on the left, but not on the model on the right.

This setting can be configured separately over individual _faces_, _edges_ and _vertices_ of a model. One same model could have some of its faces or edges set to _smooth_ and others to _sharp_

#### Best practices for geometries

- Be mindful of how many faces you add to your 3D models, as more faces make its rendering more demanding. See [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}) for the limits imposed by a scene.
- Make sure there are no hidden faces that can't be seen but that add to the triangle count.
- For shapes that should have rounded sides, set them to be _smooth_ rather than adding additional faces.
- Make sure the _normals_ of all faces are facing outwards instead of inwards. If there are faces in your model that seem not to be there when you render it, this is most likely the cause.

## Colliders

To enable collisions between a 3D model and users of your scene, you must create a new object to serve as a collider. Without a collider, users are able to walk through models as if they weren't there. For performance reasons, colliders usually have a much simpler geometry than the model itself.

Colliders currently don't affect how models and entities interact with each other, they can always overlap. Colliders only affect how the model interacts with the user's avatar.

For an object to be recognized by a Decentraland scene as a collider, all it needs is to be named in a certain way. The object's name must include the the suffix “\_collider” at the end.

For example, to create a collider for a tree, you can create a simple box object surrounding its trunk. Users of the scene won't see this box, but it will block their path.

<img src="/images/media/collision-tree.png" alt="Entity tree" width="500"/>

In this case, we can name the box "Box*Tree_collider" and export both the tree and the box as a single \_gltf* model. The \_collider tag alerts the Decentraland world engine that the box object belongs to the collection of colliders, making the \_collider mesh invisible.

<img src="/images/media/collision-hierarchy.png" alt="Entity tree" width="350"/>

Whenever a player views the tree model in your scene, they will see the complex model for your tree. However, when they walk into your tree, they will collide with the box, not the tree.

#### How to add a collider to a staircase

Stairs are a very common use-case for collider objects. In order for users to climb stairs, there must be a corresponding \_collider object that the users are able to step on.

We recommend using a ramp object for your stair colliders, this provides a much better experience when walking up or down. When they climb up your stairs, it will appear as a smooth ascent or descent, instead of requiring them to “jump” up each individual step.

Using a ramp object also avoids creating unnecessary geometry, saving room for other more complicated models. Keep in mind that collider geometry is also taken into account when calculating the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %})

1.  Create a new object in the shape of a ramp that resembles the size and proportions of the original stairs.

    <img src="/images/media/collision-stairs-both.png" alt="Staircase mesh and collider side by side" width="300"/>

2.  Name the ramp object something similar to _stairs_collider_. It must end in \__collider_.

3.  Overlay the ramp object to the stairs so that they occupy the same space.

     <img src="/images/media/collision-stairs-collider.png" alt="Overlaid mesh and collider" width="300"/>

4.  Export both objects together as a single _glTF_ model.

    <img src="/images/media/collision-stairs.png" alt="Exported 3D model with invisible collider" width="300"/>

Now when users view the stairs in your scene, they’ll see the more elaborate model of the stairs, but when they climb them, they’ll collide with the ramp.

#### Best practices with colliders

- Always use the smallest number of triangles possible when creating colliders. Avoid making a copy of a complex object to use as a collider. Simple colliders guarantee a good user-experience in and keep your scene within the triangle limitations.
- Collider objects shouldn't have any material, as users of your scene will never see it. Colliders are invisible to users.
  > Note: Remember that each scene is limited to log2(n+1) x 10000 triangles, where n is the number of parcels in your scene.
- All collider objects names must end with \__collider_. For example, _tree_collider_.
- If you use a _plane_ as a collider, it will only block in one direction. If you want colliders to block from both sides, for example for a wall, you need to create two planes with their normals facing in opposite directions.

- When duplicating collider objects, pay attention to their names. Some programs append a \__1_ to the end of the filename to avoid duplicates, for example _tree_collider_1_. Objects that are named like this will be interpreted by the Decentraland World Engine as normal objects, not colliders.

- To view the limits of all collider meshes in a Decentraland scene, launch your scene preview with `dcl start` and then click `c`. This draws blue lines that delimit all colliders in place.

## Animations

3D models can be animated in a Decentraland scene using skeletal animations. All animations of a 3D model must be embedded inside its _glTF_ file, you can't reference animations in separate files.

Currently, other forms of animations that aren't based on armatures are not supported.

There's no specific rule about the names animations must have. You can verify the names of the animations in an exported model by opening the contents of a _.gltf_ file with a text editor. Typically, an animation name is comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

You can include any number of animations in a _glTF model_. All animations in a _glTF_ model are disabled by default when loading the model into a Decentraland scene. See [3D model animations]({{ site.baseurl }}{% post_url /development-guide/2018-02-13-3d-model-animations %}) for instructions on how to activate and handle animations in a scene.

> Note: There currently isn't a way to change the frame rate of an animation displayed in your scene, the speed is fixed to a default setting. To change an animation's speed, you must change the number of frames.

In a Decentraland scene, you can use `weight` to blend several animations or to make an animation more subtle.

> Tip: Instead of creating your own animations, you can also download generic animations and apply them to your model. For example, for 3D characters with human-like characteristics, you can download free or paid animations from [Mixamo](https://www.mixamo.com/#/).

#### How to create an animation

You can use a tool like Blender to create animations for a 3D model.

1.  Create an armature, following the shape of your model and the parts you wish to move. You do this by adding an initial bone and then extruding all other bones from the vertices of that one. Bones in the armature define the points that can be articulated. The armature must be positioned overlapping the mesh.

    <img src="/images/media/armature_hummingbird1.png" alt="Armature" width="300"/>

2.  Make both the armature and the mesh child assets of the same object.

3.  Check that the mesh moves naturally when rotating its bones in the ways you plan to move it. If parts of the mesh get stretched in undesired ways, use weight paint to change what parts of the model are affected by each bone in the armature.

    <img src="/images/media/animations_hummingbird_wp1.png" alt="Weight paint view for one bone" width="300"/>

    <img src="/images/media/animations_hummingbird_wp2.png" alt="Weight paint view for another bone" width="300"/>

> Note: There's a reported bug with Babylon.js that prevents some faces of a mesh from being rendered when they're not related to any bone in the armature. So if you paint some faces with weight 0 and then animate the model, you might see these faces dissappear. To solve this, we recommend making sure that each face is related to at least one bone of the armature and painted with a weight of at least 0.01.

4.  Move the armature to a desired pose, all bones can be rotated or scaled. Then lock the rotation and scale of the bones you wish to control with this animation.

    <img src="/images/media/armature_hummingbird2.png" alt="Shifted armature" width="300"/>

5.  Switch to a different frame in the animation, position the armature into a new pose and lock it again. Repeat this process for all the key frames you want to set to describe the animation.

    <img src="/images/media/armature_hummingbird_animation.png" alt="Frames in animation" width="450"/>

6.  By default all frames in between the ones you defined will transition linearly from one pose to the next. You can also configure these transitions to behave exponentially, ease-in, bounce, etc.

#### How to handle multiple animations with Blender

To export a model with several embedded animations in Blender, you must create multiple _actions_ from the _Dope-Sheet_.

<img src="/images/media/blender-dope-sheet.png" alt="Open dope sheet" width="250"/>

You can also edit the animation from the Dope-Sheet view, for example you can adjust the distance between two key frames.

To preview the different actions, open the _Action Editor_ (only accessible once you're in the Dope Sheet).

<img src="/images/media/blender-action-editor.png" alt="Open action editor" width="250"/>

In order to export multiple animations, you need to stash all the actions using the _NLA Editor_. We recommend opening the NLA editor on a separate editor tab while keeping the Dope sheet also open.

<img src="/images/media/blender-nla-editor.png" alt="Open NLA editor" width="250"/>

In the NLA Editor, select each action that you want to embed in the glTF model and click _Stash_.

<img src="/images/media/blender-nla-editor2.png" alt="Stash actions into glTF model" width="600"/>

When adding the model to your Decentraland scene, you must activate animations by configuring the _gltf-model_ entity. See [3D model animations]({{ site.baseurl }}{% post_url /development-guide/2018-02-13-3d-model-animations %}) for instructions.

#### Best practices for animations

- Keep the armature simple, only create bones for the parts of the model that you intend to animate.
- If the animation will be looped in your scene, make sure the final pose is identical to the starting pose to avoid jumps.
- Sometimes in an animation you might want to only control the movements of parts of the armature, and leave other bones undefined. This can make it easier to combine animations together.
- Animated characters in your scene shouldn't ever stay completely still, even when they aren't doing anything. It's best to create an "idle" animation to use for when the character is still. The idle animation can include subtle movements like breathing and perhaps occasional glances.
- Make sure your model only has one armature when you export it. Sometimes, when importing another animation to the program where you're editing your model, it will bring in a copy of the armature. You want all animations of the model to be performed by the same base armature.
- When exporting the _glTF_ model, make sure you're exporting all the objects and animations. Some exporters will only export the _currently selected_ by default.
