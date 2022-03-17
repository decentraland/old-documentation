---
date: 2018-01-10
title: Materials
description: Learn what material properties and textures are supported on 3D models imported to Decentraland.

categories:
  - 3d-modeling
type: Document
---

Materials are embedded into a _.gltf_ or _.glb_ file.

This document refers to materials that are imported in a 3D model. For materials defined via code to apply onto primitive shapes, see [materials]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}).

> Note: You can't currently dynamically change the materials of a 3D model from your scene's code, unless this is a primitive shape.

## Shader support

Not all shaders can be used in models that are imported into Decentraland. Make sure you use one of the following:

- Standard materials: any shaders are supported, for example diffuse, specular, transparency, etc.

  > Tip: When using Blender, these are the materials supported by _Blender Render_ rendering.

- PBR (Physically Based Rendering) materials: This shader is extremely flexible, as it includes properties like diffuse, roughness, metalness and emission that allow you to configure how a material interacts with light.

  > Tip: When using Blender, you can use PBR materials by setting _Cycles_ rendering and adding the _Principled BSDF_ shader. Note that none of the other shaders of the _Cycles_ renderer are supported.

The image below shows two identical models, created with the same colors and textures. The model on the left uses all _PBR_ materials, some of them include _metalness_, _transparency_, and _emissiveness_. The model on the right uses all _standard_ materials, some including _transparency_ and _emissiveness_.

![]({{ site.baseurl }}/images/media/materials_pbr_basic.png)

## Transparent materials

You can set a material to be _transparent_. Transparent materials can be seen through to varying degrees, depending on their _alpha_. To do this, activate the transparency property of the material and then set its _alpha_ to the desired amount. An alpha of 1 will make the material completely opaque, an alpha of 0 will make it invisible.

The image below shows two identical models created with standard materials. The one on the left uses only opaque materials, the one on the right uses both transparent and opaque materials in some of its parts.

![]({{ site.baseurl }}/images/media/materials_transparent_emissive.png)

There are two main different transparency modes: _Aplha Clip_ and _Aplha Blend_.

_Alpha Clip_ sets that each part of a model is either 100% opaque or 100% transparent. _Alpha Blend_ allows you to pick intermediate values per region.

![]({{ site.baseurl }}/images/media/transparency-modes.png)

Unless you specifically want to be able to have an intermediate level of transparency, it's always better to use _Alpha Clip_.

## Emissive materials

You can also make a material _emissive_. Emissive materials cast their own light. Note that when rendered, they don't actually illuminate nearby objects in the scene, they just seem to have a blurred glow around them.

The image below shows two identical models created with standard materials. The one on the right has glowing emissive materials on some of its surfaces.

![]({{ site.baseurl }}/images/media/materials_transparent_emissive.png)

To make a material emissive in Blender, simply add an `emission` shader to the material.

![]({{ site.baseurl }}/images/media/simple-emissive.png)

To make a material both emissive and have a texture, you can use two shaders in parallel, one of the `emission` and another `principled BDSF` for the texture. You can then use a `mix shader` node to join them.

![]({{ site.baseurl }}/images/media/apply-emissive.png)

> Tip: By using a color atlas as a texture, you can get away with having various possible colors counted as a single texture. This is useful for making sure you don't exceed the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}).

![]({{ site.baseurl }}/images/media/neon-texture.png)

#### Soften an emissive

The `emission` shader has a `strength` property that can lower the glow of an emissive material. However, due to a known issue with the _.glTF_ specification, an exported _.glTF_ or _.glb_ file doesn't retain this property. When importing the model into a Decentraland scene it will always have the emissive strength at 100%.

To make a material glow less, the best workaround is to set the `color` property on the `emission` shader to something less bright, or to reference a color from a texture that is less bright.

For example, if using the below color map, you can achieve a less bright emissive material by picking a color from the bottom half of the image. Anything on the top half will be fully emissive, but as you go lower the material will have less glow.

![]({{ site.baseurl }}/images/media/neon-texture.png)

## Vertex painting

Vertex painting of 3D models isn't currently supported by Decentraland's engine. We recommend using texture mapping with a pallette of plain colors for a similar effect.

## Textures

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


-->

#### Default textures

All of the assets from the default Decentraland asset libraries (available in the Builder or as wearables) share a set of optimized plane textures. These textures are pre-loaded by players when they open the explorer, which makes these assets a lot faster to load.

If you build your own custom 3D models and use these same Decentraland default textures, your assets will also load faster when players walk to your parcels.

These textures are composed of a palette of plain colors, that you can map to different parts of a 3D model.

<img src="{{ site.baseurl }}/images/media/MiniTown_TX.png" alt="Minitown texture" width="250"/>

You can find the full collection of Decentraland default textures in [this repo](https://github.com/decentraland/builder-assets/tree/master/textures)

#### Lighting conditions

It's currently not possible to have custom light sources in a Decentraland scene. You may want to consider baking lighting into a texture, for example to simulate a lighting focal point on a wall.

Note that objects cast shadows over others. The default lighting conditions have a light source that is positioned at 45 degrees on all three axis.

Emissive materials aren't affected by shadows from other objects, but they do cast their own shadow.

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

## Normal maps

You can add an additional normal map to a texture to control how reflections bounce off different regions of a same model. This can be used to achieve very interesting and realistic effects. It also allows you to keep the textures themselves lighter, as some detail can be provided on the normal map layer instead.

The colors on the normal map are not to be taken literally, but instead map to what direction light bounces off to. Darker parts of the texture will reflect less light.

<img src="{{ site.baseurl }}/images/media/normal-map.png" alt="Model without valid material" width="250"/>

For example in this brick wall can be overlayed on a texture that matches the same brick positions. The different color mapping implies that the blue bricks will bounce light forward. The green margins on the top bounce light upwards. The cracks between the bricks reflect a lot less light. This is a great way to get the lighting on the wall behave more realistically, without having to spend geometry on each individual brick.

> NOTE: Never use the same texture file for both the texture of an object and its normal map. Create a separate file and name it differently. Models in deployed scenes are compressed by the content servers, and normal maps are compressed differently to other textures. The compressed model might end up looking very different if the server compresses a texture as a normal map or viceversa.


## How to swap a material

Suppose you've imported a 3D model that uses a material that's not supported by Decentraland. You can easily change this material while still keeping the same texture and its mapping.

<img src="{{ site.baseurl }}/images/media/materials-not-supported.png" alt="Model without valid material" width="250"/>

To swap the material:

1. Check the current material's settings to see what texture files are being used and how they are configured.
2. Delete the current material from the mesh.

   ![]({{ site.baseurl }}/images/media/materials_delete_material.png)

3. Create a new material.

    <img src="{{ site.baseurl }}/images/media/materials_new_material.png" alt="New default basic material" width="400"/>

   > Tip: If you're using Blender and are on the _Blender Render_ tab, it creates a basic material by default, which is supported by Decentraland.

4. Open the _Textures_ settings and create a new texture, importing the same image file that the original material used.

   <img src="{{ site.baseurl }}/images/media/materials_new_texture.png" alt="New default basic texture" width="300"/>

5. The texture should be mapped to the new material just as it was mapped to the old material.

   <img src="{{ site.baseurl }}/images/media/materials_final.png" alt="Model with valid material" width="300"/>

## Best practices for materials

- If your scene includes multiple models that use the same texture, reference the texture as an external file instead of having it embedded in the 3D model. Embedded textures get duplicated for each model and add to the scene's size. _.glb_ files have their textures embedded by default, but you can use [glTF pipeline](https://github.com/AnalyticalGraphicsInc/gltf-pipeline) to extract it outside.

  > Note: After referencing a file for a texture that won’t be embedded, make sure that file won’t be moved or renamed, as otherwise the reference to the file will be lost. The file must also be inside the scene folder so that it’s uploaded together with the scene.

- Use the Decentraland [default textures](https://github.com/decentraland/builder-assets/tree/master/textures), which are pre-loaded by players, making your assets render a lot faster.
- Read [this article](https://www.khronos.org/blog/art-pipeline-for-gltf) for a detailed overview of a full art pipeline that uses PBR textures in glTF models.
- You can find a detailed reference about how to create glTF compatible materials with Blender in [Blender's documentation](https://docs.blender.org/manual/en/latest/addons/import_export/scene_gltf2.html).
- Find free, high quality PBR textures in [cgbookcase](https://cgbookcase.com/).
- When setting transparency of a material, try to always use _Alpha clip_ rather than _Alpha blend_, unless you specifically need to have a material that's partially transparent (like glass). This will avoid problems where the engine renders the wrong model in front of the other.
