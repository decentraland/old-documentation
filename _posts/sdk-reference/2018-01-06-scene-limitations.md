---
date: 2018-01-06
title: Scene limitations
description: How many things can I put on my scene?
categories:
  - documentation
type: Document
set: sdk-reference
set_order: 6
---

In order to improve performance in the metaverse, we have established a set of limits that every scene must follow. If a
scene exceeds these limitations, then the parcel won't be loaded and the preview will display an error message.

## Entity constraints

Below are the maximum number of elements allowed allowed in a scene:

> _n_ represents the number of parcels that a scene occupies.

- **Triangles:** `log2(n+1) x 10000` Total amount of triangles for all the models in the scene.
- **Entities:** `log2(n+1) x 200` Amount of entities in the scene.
- **Bodies:** `log2(n+1) x 300` Amount of meshes in the scene.
- **Materials:** `log2(n+1) x 20` Amount of materials in the scene. It includes materials imported as part of models.
- **Textures:** `log2(n+1) x 10` Amount of textures in the scene. It includes textures imported as part of models.
- **Height:** `log2(n+1) x 20` Height in meters.

When running a preview, any content that exceeds parcel boundaries are highlighted in red when rendered.

When your parcel is rendered, any static content extending beyond your parcel's boundaries is replaced with an error message. All dynamic entities that cross your parcel boundaries are deleted from the rendered scene.

## Texture size constraints

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

## Shader support

Not all shaders can be used in models that are imported into Decentraland. If you're working with Blender, you can either use:

- Using Blender Render, any of its shaders are supported, for example diffuse, specular, transparency, etc.
- Using the Cycles renderer, you can _only_ use PBR (Physically Based Rendering). That's done by using the `Principled BSDF` shader. This shader is extremely flexible, as it includes properties like diffuse, roughness, metalness and emission that allow you to configure how a material interacts with light.

> None of the other shaders of the Cycles renderer are supported.
