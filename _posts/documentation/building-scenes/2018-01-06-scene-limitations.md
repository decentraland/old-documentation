---
date: 2018-01-06
title: Scene limitations
description: How many things can I put on my scene?
categories:
  - documentation
type: Document
set: building-scenes
set_order: 6
---
In order to improve performance in the metaverse, we have established a set of limits that every scene must follow. If a
scene exceeds these limitations then the parcel won't be loaded and the preview will display an error message.
With *n* representing the number of parcels that a scene will fill, the following are the maximum number of elements
allowed:

* **Triangles:** `log2(n+1) x 10000`
* **Entities:** `log2(n+1) x 200`
* **Materials:** `log2(n+1) x 20`
* **Textures:** `log2(n+1) x 10`
* **Height:** `log2(n+1) x 20` in meters

Parcel boundaries are enforced. If any content exceeds parcel boundaries, the preview will display highlight that
content in red.

When your parcel is rendered, any static content extending beyond your parcel's boundaries will be replaced with an
error message. All dynamic entities that cross your parcel boundaries will be deleted from the scene.

## Texture size constraints

There is a well known rule for textures in several rendering engines that forces the textures to have a power of two
width and height due internal optimizations of the graphics processors.  

What does it mean?  

Having the powers of two defined as `f(x) = 2 ^ x` we can get the numbers

```
1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
```

The width and the height of the textures must match those numbers, it doesn't need to be the same number. i.e:

Valid sizes:
```
32x32
64x32
512x256
512x512
```
Invalid sizes:
```
3x4
123x100
411x900
```

Although arbitrary sizes work at the alpha, the engine is displaying an alert in the console and we will enforce this
and those invalid textures wont work.

**The recommended size for textures is 512x512**, this is so because it is the optimal size to be transported thru domestic
networks and to provide reasonable loading/quality experiences.