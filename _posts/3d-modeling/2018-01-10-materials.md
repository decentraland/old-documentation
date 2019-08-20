---
date: 2018-01-10
title: Materials
description: Learn what material properties and textures are supported on 3D models imported to Decentraland.

categories:
  - 3d-modeling
type: Document
set: 3d-modeling
set_order: 10
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

![](/images/media/materials_pbr_basic.png)

## Transparent and emissive materials

You can set a material to be _transparent_. Transparent materials can be seen through to varying degrees, depending on their _alpha_. To do this, activate the transparency property of the material and then set its _alpha_ to the desired amount. An alpha of 1 will make the material completely opaque, an alpha of 0 will make it invisible.

You can also make a material _emissive_. Emissive materials cast their own light. Note that when rendered, they don't actually illuminate nearby objects in the scene, they just seem to have a blurred glow around them.

The image below shows two identical models created with standard materials. The one on the left uses only opaque materials, the one on the right uses both transparent and emissive materials in some of its parts.

![](/images/media/materials_transparent_emissive.png)

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

### Default textures

All of the assets from the default Decentraland asset libraries (available in the Builder or as wearables) share a set of optimized plane textures. These textures are pre-loaded by players when they open the explorer, which makes these assets a lot faster to load. 

If you build your own custom 3D models and use these same Decentraland default textures, your assets will also load faster when players walk to your parcels.

These textures are composed of a palette of plain colors, that you can map to different parts of a 3D model.

<img src="/images/media/MiniTown_TX.png" alt="Minitown texture" width="250"/>

You can find the full collection of Decentrlanad default textures in [this repo](https://github.com/decentraland/builder-assets/tree/master/textures)

### Texture size constraints

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

## How to swap a material

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

## Best practices for materials

- If your scene includes multiple models that use the same texture, reference the texture as an external file instead of having it embedded in the 3D model. Embedded textures get duplicated for each model and add to the scene's size.
  > Note: After referencing a file for a texture that won’t be embedded, make sure that file won’t be moved or renamed, as otherwise the reference to the file will be lost. The file must also be inside the scene folder so that it’s uploaded together with the scene.
- Use the Decentraland [default textures](https://github.com/decentraland/builder-assets/tree/master/textures), which are pre-loaded by players, making your assets render a lot faster. 
- Read [this article](https://www.khronos.org/blog/art-pipeline-for-gltf) for a detailed overview of a full art pipeline that uses PBR textures in glTF models.
- Find free, high quality PBR textures in [cgbookcase](https://cgbookcase.com/).
