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

## Scene limitation rules

Below are the maximum number of elements allowed allowed in a scene:

> _n_ represents the number of parcels that a scene occupies.

- **Triangles:** `log2(n+1) x 10000` Total amount of triangles for all the models in the scene.
- **Entities:** `log2(n+1) x 200` Amount of entities in the scene.
- **Bodies:** `log2(n+1) x 300` Amount of meshes in the scene.
- **Materials:** `log2(n+1) x 20` Amount of materials in the scene. It includes materials imported as part of models.
- **Textures:** `log2(n+1) x 10` Amount of textures in the scene. It includes textures imported as part of models.
- **Height:** `log2(n+1) x 20` Height in meters.

## Query scene limitations via code

From a scene's code, you can query both the limitations that apply to the scene and how much the scene is currently using. This is especially useful with scenes where the content changes dynamically. For example, in a scene where you add a new entity each time the user clicks, you could stop adding entities when you reach the scene limits.

#### Obtain scene limitations

Run `this.queryParcelLimits()` to obtain the limits of your scene. The limits are calculated for your scene based on how many parcels it occupies, according to the _scene.json_ file. The values returned by this command don't change over time, as the scene's size is always the same.

The `queryParcelLimits()` is asynchronous, so we recommend calling it with an `await` statement.

The `queryParcelLimits()` function returns a promise of an object with the following properties, all of type _number_.

{% raw %}

```tsx
//get limits object
const limits = await this.queryParcelLimits()

//print maximum triangles
console.log(limits.triangles)

//print maximum entities
console.log(limits.entities)

//print maximum bodies
console.log(limits.bodies)

//print maximum materials
console.log(limits.materials)

//print maximum textures
console.log(limits.textures)
```

{% endraw %}

For example, if your scene has only one parcel, logging `limits.triangles` should print `10000`.

#### Obtain the current use

Just as you can check via code the maximum allowed values for your scene, you can also check how much of that is currently used by the scene. You do this by running `this.queryParcelMetrics()`. The values returned by this command change over time as your scene renders different content.

The `queryParcelMetrics()` is asynchronous, so we recommend calling it with an `await` statement.

The `queryParcelMetrics()` function returns a promise of an object with the following properties, all of type _number_.

{% raw %}

```tsx
//get metrics object
const limits = await this.queryParcelMetrics()

//print maximum triangles
console.log(limits.triangles)

//print maximum entities
console.log(limits.entities)

//print maximum bodies
console.log(limits.bodies)

//print maximum materials
console.log(limits.materials)

//print maximum textures
console.log(limits.textures)
```

{% endraw %}

For example, if your scene is only rendering one box entity at the time, logging `limits.entities` should print `1`.

## Other limitations

When running a preview, any content that is located outside the parcel boundaries is highlighted in red when rendered.

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

Not all shaders can be used in models that are imported into Decentraland. Make sure you use one of the following:

- Standard materials: any shaders are supported, for example diffuse, specular, transparency, etc.

  > Tip: When using Blender, these are the materials supported by _Blender Render_ rendering.

- PBR (Physically Based Rendering) materials: This shader is extremely flexible, as it includes properties like diffuse, roughness, metalness and emission that allow you to configure how a material interacts with light.

  > Tip: When using Blender, you can use PBR materials by setting _Cycles_ rendering and adding the _Principled BSDF_ shader. Note that none of the other shaders of the _Cycles_ renderer are supported.

See [entity interfaces]({{ site.baseurl }}{% post_url /sdk-reference/2018-06-21-entity-interfaces %}) for a full list of all the properties that can be configured in a material.
