---
date: 2018-01-06
title: Scene limitations
description: How many things can I put on my scene?
redirect_from:
  - /documentation/scene-limitations/
categories:
  - development-guide
type: Document
set: development-guide
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

  > Note: User avatars and any items brought by users from outside the scene don't count for calculating these limits.

## Query scene limitations via code

From a scene's code, you can query both the limitations that apply to the scene and how much the scene is currently using. This is especially useful with scenes where the content changes dynamically. For example, in a scene where you add a new entity each time the user clicks, you could stop adding entities when you reach the scene limits.

#### Obtain scene limitations

Run `this.entityController.querySceneLimits()` to obtain the limits of your scene. The limits are calculated for your scene based on how many parcels it occupies, according to the _scene.json_ file. The values returned by this command don't change over time, as the scene's size is always the same.

The `querySceneLimits()` is asynchronous, so we recommend calling it with an `await` statement.

The `querySceneLimits()` function returns a promise of an object with the following properties, all of type _number_.

{% raw %}

```tsx
// get limits object
const limits = await this.entityController.querySceneLimits()

// print maximum triangles
console.log(limits.triangles)

// print maximum entities
console.log(limits.entities)

// print maximum bodies
console.log(limits.bodies)

// print maximum materials
console.log(limits.materials)

// print maximum textures
console.log(limits.textures)
```

{% endraw %}

For example, if your scene has only one parcel, logging `limits.triangles` should print `10000`.

#### Obtain the current use

Just as you can check via code the maximum allowed values for your scene, you can also check how much of that is currently used by the scene. You do this by running `this.querySceneMetrics()`. The values returned by this command change over time as your scene renders different content.

The `querySceneMetrics()` is asynchronous, so we recommend calling it with an `await` statement.

The `querySceneMetrics()` function returns a promise of an object with the following properties, all of type _number_.

{% raw %}

```tsx
// get metrics object
const limits = await this.entityController.querySceneMetrics()

// print maximum triangles
console.log(limits.triangles)

// print maximum entities
console.log(limits.entities)

// print maximum bodies
console.log(limits.bodies)

// print maximum materials
console.log(limits.materials)

// print maximum textures
console.log(limits.textures)
```

{% endraw %}

For example, if your scene is only rendering one box entity at the time, logging `limits.entities` should print `1`.

## Scene boundaries

When running a preview, any content that is located outside the parcel boundaries is highlighted in red when rendered. If any content is outside these boundaries, you won't be allowed to deploy this scene to Decentraland.

## Shader limitations

3D models used in decentraland must use supported shaders and materials. See [3D model considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for a list of supported shaders.

## Lighting

The scene's lighting conditions can't be changed from the default setting.

Entities don't cast shadows over other entities and dynamic lighting isn’t supported.

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

## File amount limitations

When deploying your scene, you can't upload more than 100 files to IPFS, as having too many files in a scene will make it take too long to load in the client.

If you have more than 100 files in your scene folder, it's likely that many of those files aren't being used directly when loading the scene. You can make the CLI ignore specific files from the scene folder and not upload them to IPFS by specifying them in the _dclignore_ file for the scene. Learn more about it in [Scene files]({{ site.baseurl }}{% post_url /development-guide/2018-01-11-scene-files %}).
