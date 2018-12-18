---
date: 2018-02-7
title: Materials
description: Learn how to add materials and textures to entities with primitive shapes.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 7
---

## Materials

Materials can be applied to entities that use primitive shapes (cube, sphere, plane, etc) by setting them as a component.

You can either set a `Material` or a `BasicMaterial` component. Each entity can only have one of these. Both components have several fields that allow you to configure the properties of the material, add a texture and set the texture's mapping.

You can't add material components to _glTF_ models. _glTF_ models include their own materials that are implicitly imported into a scene together with the model.

When importing a 3D model with its own materials, keep in mind that not all shaders are supported by the Decentraland engine. Only standard materials and PBR (physically based rendering) materials are supported. See [external 3D model considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}#materials) for more details.

## Create and apply a material

The following example creates a material, sets some of its fields to give it a red color and metallic properties, and then applies the material to an entity that also has a `boxShape` component.

```ts
//Create entity and assign shape
const myEntity = new Entity()
myEntity.set(new BoxShape())

//Create material and configure its fields
const myMaterial = new Material()
myMaterial.albedoColor = Color3.Blue()
myMaterial.metallic = 0.9
myMaterial.roughness = 0.1

//Assign the material to the entity
myEntity.set(myMaterial)
```

See [component reference]()) for a full list of all the fields that can be configured in a `Material` of `BasicMatieral` component.

## Basic materials

Instead of the `Material` component, you can define a material through the `BasicMaterial` entity. This creates materials that are shadeless and are not affected by light. This is useful for creating user interfaces that should be consistently bright, it can also be used to give your scene a more minimalist look.

```tsx
const myMaterial = new BasicMaterial()
```

> Note: Basic materials have some property names that are different from those in normal materials. For example it uses `texture` instead of `albedoTexture`.

## Material colors

Give a material a plain color. In a `BasicMaterial` component, you set the `color` field. In a `Material` component, you set the `albedoColor` field. Albedo colors respond to light and can include shades on them.

All color fields are of type `Color3`, these hold three values, for _Red_, _Green_ and _Blue_. Each of these numbers is between 0 and 1.

```ts
myMaterial.albedoColor = new Color3.(0.5, 0, 0.5)
```

You can also pick predetermined colors using the following functions of the `Color3` object:

```ts
let red = Color3.Red()

let green = Color3.Green()

let blue = Color3.Blue()

let black = Color3.Black()

let white = Color3.White()

let purple = Color3.Purple()

let magenta = Color3.Magenta()

let yellow = Color3.Yellow()

let gray = Color3.Gray()

let teal = Color3.Teal()
```

You can otherwise pick a random color using the following function:

```ts
// Pick a random color
let green = Color3.Random()
```

If you prefer to specify a color using hexadecimal values, as is often done in JavaScript web development, you can do so using the `.FromHexString()` function

```ts
let gray = Color3.FromHexString("#CCCCCCC")
```

The `Color3` object also includes a lot of other functions to add, substract, compare, lerp, or convert the format of colors.

You can also edit the following fields in a `Material` component to fine-tune how its color is percieved:

- _emissiveColor_: The color emitted from the material.
- _ambientColor_: AKA _Diffuse Color_ in other nomenclature.
- _reflectionColor_: The color reflected from the material.
- _reflectivityColor_: AKA _Specular Color_ in other nomenclature.

#### Change a color gradually

Change a color gradually with linear interpolation between two colors, using the `.lerp()` function.

```ts
// This variable will store the ratio between both colors
let colorRatio = 0

// Define colors
const red = Color3.Red()
const yellow = Color3.Yellow()

// Create material
const myMaterial = new Material()

// This system changes the value of colorRatio every frame, and sets a new color on the material
export class ColorSystem implements ISystem {
  update(dt: number) {
    myMaterial.albedoColor = Color3.lerp(red, yellow, colorRatio)
    if (colorRatio < 1) {
      colorRatio += 0.01
    }
  }
}

// Add the system to the engine
engine.addSystem(ColorSystem)
```

The example above changes the color of a material from red to yellow, incrementally shifting it on every frame.

## Using textures

Use an image file as a texture in a material. In a `BasicMaterial` component, you set the `texture` field. In a `Material` component, you set the `albedoTexture` field. Albedo textures respond to light and can include shades on them.

The `Material` component allows you to use several image files as layers to compose more realistic textures, for example including a `bumpTexture` and a `refractionTexture`.

```ts
//Create entity and assign shape
const myEntity = new Entity()
myEntity.set(new BoxShape())

//Create material and configure its fields
const myMaterial = new Material()
myMaterial.albedoTexture = "materials/wood.png"
myMaterial.bumpTexture = "materials/woodBump.png"

//Assign the material to the entity
myEntity.set(myMaterial)
```

In the example above, the image for the material is located in a `materials` folder, which is located at root level of the scene project folder.

> Tip: We recommend keeping your texture image files separate in a `/materials` folder inside your scene.

#### Texture mapping

If you want the texture to be mapped to specific scale or alignment on your entities, then you need to configure _uv_ properties on the [shape components]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}).

<!--
Use the [Decentraland sprite helpers](https://github.com/decentraland/dcl-sprites) library to map textures easily. Read documentation on how to use this library in the provided link.

-->

To handle texture mapping manually, you set _u_ and _v_ coordinates on the 2D image of the texture to correspond to the vertices of the shape. The more vertices the entity has, the more _uv_ coordinates need to be defined on the texture, a plane for example needs to have 8 _uv_ points defined, 4 for each of its two faces.

```tsx
//Create material and configure fields
const myMaterial = new BasicMaterial()
myMaterial.texture = "materials/atlas.png"
myMaterial.samplingMode = 0

//Create shape component
const plane = new PlaneShape()
plane.uvs = [
  0,
  0.75,
  0.25,
  0.75,
  0.25,
  1,
  0,
  1,
  0,
  0.75,
  0.25,
  0.75,
  0.25,
  1,
  0,
  1
]

//Create entity and assign shape and material
const myEntity = new Entity()
myEntity.set(plane)
myEntity.set(myMaterial)
```

To create an animated sprite, use texture mapping to change the selected regions of a same texture that holds all the frames.

## Reuse materials

If multiple entities in your scene use a same material, there's no need to create an instance of the material component for each. All entities can share one same instance, this keeps your scene lighter to load and prevents you from exceeding the maximum amount of materials per scene.

```ts
//Create entities and assign shapes
const box = new BoxShape()
const myEntity = new Entity()
myEntity.set(box)
const mySecondEntity = new Entity()
mySecondEntity.set(box)
const myThirdEntity = new Entity()
myThirdEntity.set(box)

//Create material and configure fields
const myMaterial = new Material()
myMaterial.albedoColor = Color3.Blue()

//Assign same material to all entities
myEntity.set(myMaterial)
mySecondEntity.set(myMaterial)
myThirdEntity.set(myMaterial)
```

## Transparent materials

To make a material transparent, you must add an alpha channel to the image you use for the texture. The _material_ component ignores the alpha channel of the texture image by default, so you must either:

- Set `hasAlpha` to true.
- Set an image in `alphaTexture`. This image can be the same as the texture, or a different image.

```tsx
const myMaterial = new Material()
myMaterial.hasAlpha = true
// or
const myMaterial2 = new Material()
myMaterial2.alphaTexture = "materials/alphaTexture.png"
```

## Texture stretching in basic materials

When textures are stretched or shrinked to a different size from the original texture image, this can sometimes create artifacts. There are various [texture filtering](https://en.wikipedia.org/wiki/Texture_filtering) algorithms that exist to compensate for this in different ways. The `BasicMaterial` component uses the _bilinear_ algorithm by default, but you can configure it to use the _nearest neighbor_ or _trilinear_ algorithms instead by setting the `samplingMode`.

```tsx
const myMaterial = new BasicMaterial()
myMaterial.samplingMode = 1
```

The example above uses a nearest neighbor algorithm. This setting is ideal for pixel art style graphics, as the contours will remain sharply marked as the texture is seen larger on screen instead of being blurred.
