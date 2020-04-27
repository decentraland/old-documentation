---
date: 2018-02-7
title: Materials via code
description: Learn how to add materials and textures to entities with primitive shapes.
categories:
  - development-guide
type: Document
---

## Materials

Materials can be applied to entities that use primitive shapes (cube, sphere, plane, etc) by setting them as a component.

You can either set a `Material` or a `BasicMaterial` component. Each entity can only have one of these. Both components have several fields that allow you to configure the properties of the material, add a texture and set the texture's mapping.

You can't add material components to _glTF_ models. _glTF_ models include their own materials that are implicitly imported into a scene together with the model.

When importing a 3D model with its own materials, keep in mind that not all shaders are supported by the Decentraland engine. Only standard materials and PBR (physically based rendering) materials are supported. See [external 3D model considerations]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-10-materials %}) for more details.

## Create and apply a material

The following example creates a material, sets some of its fields to give it a red color and metallic properties, and then applies the material to an entity that also has a `boxShape` component.

```ts
//Create entity and assign shape
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

//Create material and configure its fields
const myMaterial = new Material()
myMaterial.albedoColor = Color3.Blue()
myMaterial.metallic = 0.9
myMaterial.roughness = 0.1

//Assign the material to the entity
myEntity.addComponent(myMaterial)
```

See [component reference](https://github.com/decentraland/ecs-reference)) for a full list of all the fields that can be configured in a `Material` of `BasicMatieral` component.

## Basic materials

Instead of the `Material` component, you can define a material through the `BasicMaterial` entity. This creates materials that are shadeless and are not affected by light. This is useful for creating user interfaces that should be consistently bright, it can also be used to give your scene a more minimalist look.

```ts
const myMaterial = new BasicMaterial()
```

> Note: Basic materials have some property names that are different from those in normal materials. For example it uses `texture` instead of `albedoTexture`.

## Material colors

Give a material a plain color. In a `BasicMaterial` component, you set the `color` field. In a `Material` component, you set the `albedoColor` field. Albedo colors respond to light and can include shades on them.

All color fields are either of type `Color3` or `Color4`. `Color3` holds three values, for _Red_, _Green_ and _Blue_. Each of these numbers is between _0_ and _1_. `Color4` holds those same three values and a fourth value for _Alpha_, also between _0_ and _1_, where _0_ is completely transparent and _1_ is completely opaque.

```ts
myMaterial.albedoColor = new Color3(0.5, 0, 0.5)
```

> Note: If you set any color in `albedoColor` to a value higher than _1_, it will appear as _emissive_, with more intensity the higher the value. So for example, `new Color3(15, 0, 0)` produces a very bright red glowing color.

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

Change a color gradually with linear interpolation between two colors, using the `.Lerp()` function.

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
    myMaterial.albedoColor = Color3.Lerp(red, yellow, colorRatio)
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

Reference an image file as a texture by creating a `Texture` component. You can then reference this texture component in the fields of both `Material` and `BasicMaterial` components.

In a `Material` component, you can set the `albedoTexture` field to a texture image. Albedo textures respond to light and can include shades on them.

```ts
//Create entity and assign shape
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

//Create texture
const myTexture = new Texture("materials/wood.png")

//Create a material
const myMaterial = new Material()
myMaterial.albedoTexture = myTexture

//Assign the material to the entity
myEntity.addComponent(myMaterial)
```

While creating a texture, you can also pass additional parameters:

- `hasAlpha`: Allows the texture to have transparent regions
- `samplingMode`: Determines how pixels in the texture are stretched or compressed when rendered
- `wrap`: Determines how a texture is tiled onto an object (CLAMP, WRAP, or MIRROR)

```ts
let smokeTexture = new Texture("textures/smoke-puff3.png", {
  hasAlpha: true,
  wrap: CLAMP,
})
```

#### Textures from an external URL

You can point the texture of your material to an external URL instead of an internal path in the scene project.

```ts
const myTexture = new Texture(
  "https://wearable-api.decentraland.org/v2/collections/community_contest/wearables/cw_tuxedo_tshirt_upper_body/thumbnail"
)

const myMaterial = new Material()
myMaterial.albedoTexture = myTexture
```

The URL must start with `https`, `http` URLs aren't supported. The site where the image is hosted should also have [CORS policies (Cross Origin Resource Sharing)](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) that permit externally accessing it.

#### Textures on basic materials

In a `BasicMaterial` component, you can set the `texture` field to an image texture. This will render a texture that isn't affected by lighting.

```ts
//Create entity and assign shape
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

//Create texture
const myTexture = new Texture("materials/wood.png")

//Create material and configure its fields
const myMaterial = new BasicMaterial()
myMaterial.texture = myTexture

//Assign the material to the entity
myEntity.addComponent(myMaterial)
```

#### Multi-layered textures

It also allows you to use several image files as layers to compose more realistic textures, for example including a `bumpTexture` and a `refractionTexture`.

```ts
//Create entity and assign shape
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

//Create texture
const myTexture = new Texture("materials/wood.png")

//Create second texture
const myBumpTexture = new Texture("materials/woodBump.png")

//Create material and configure its fields
const myMaterial = new Material()
myMaterial.albedoTexture = myTexture
myMaterial.bumpTexture = myBumpTexture

//Assign the material to the entity
myEntity.addComponent(myMaterial)
```

In the example above, the image for the material is located in a `materials` folder, which is located at root level of the scene project folder.

> Tip: We recommend keeping your texture image files separate in a `/materials` folder inside your scene.

> Tip: A material can have multiple layers of texture, you can see what these are on a source code editor by clicking `.` and letting the autocomplete menu show you the list.

#### Texture wrapping

If you want the texture to be mapped to specific scale or alignment on your entities, then you need to configure _uv_ properties on the [shape components]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}).

The `Texture` component lets you configure the wrapping mode by setting the `wrap` field. The wrapping mode can be `CLAMP`, `WRAP` or `MIRROR`.

```ts
myTexture.wrap = 3
```

The example above sets the wrapping mode to `MIRROR`.

- `CLAMP`: The texture is only displayed once in the specified size. The rest of the surface of the mesh will be left transparent.
- `WRAP`: The texture will be repeated as many times as it fits in the mesh, using the specified size.
- `MIRROR`: As in wrap, the texture is repeated as many times as it fits, but the orientation of these repetitions will be mirrored.

To handle texture mapping manually, you set _u_ and _v_ coordinates on the 2D image of the texture to correspond to the vertices of the shape. The more vertices the entity has, the more _uv_ coordinates need to be defined on the texture, a plane for example needs to have 8 _uv_ points defined, 4 for each of its two faces.

```ts
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
  1,
]

//Create entity and assign shape and material
const myEntity = new Entity()
myEntity.addComponent(plane)
myEntity.addComponent(myMaterial)
```

<!--
Use the [Decentraland sprite helpers](https://github.com/decentraland/dcl-sprites) library to map textures easily. Read documentation on how to use this library in the provided link.

To create an animated sprite, use texture mapping to change the selected regions of a same texture that holds all the frames.

-->

#### Texture scaling

When textures are stretched or shrinked to a different size from the original texture image, this can sometimes create artifacts. In a 3D environment, the effects of perspective cause this naturally. There are various [texture filtering](https://en.wikipedia.org/wiki/Texture_filtering) algorithms that exist to compensate for this in different ways. The `Texture` and the `BasicMaterial` components use the _bilinear_ algorithm by default, but let you configure it to use the _nearest neighbor_ or _trilinear_ algorithms instead by setting the `samplingMode`.

```ts
const myTexture = new Texture("materials/myTexture.png")
myTexture.samplingMode = 1
```

The example above uses a nearest neighbor algorithm. This setting is ideal for pixel art style graphics, as the contours will remain sharply marked as the texture is seen larger on screen instead of being blurred.

## Transparent materials

To make a material with a plain color transparent, simply define the color as a `Color4`, and set the 4th value to something between _0_ and _1_. The closer to _1_, the more opaque it will be.

```typescript
let transparentRed = Color4(1, 0, 0, 0.5)
```

To make a material with texture transparent:

- Set an image in `alphaTexture`.

      	> Note: This image can be the same as the texture, or a different image that determines that certain parts of the texture as transparent and others aren't.

- Optionally set the `transparencyMode` to: - `OPAQUE`: No transparency at all - `ALPHATEST`: Each pixel is either completely opaque or completely transparent, based on a threshold. - `ALPHABLEND`: Intermediate values are possible based on the value of each pixel.

* If you set the `transparencyMode` to `ALPHATEST`, you can fine tune the threshold used to determine if each pixel is transparent or not. Set the `alphaTest` property between _0_ and _1_. By default its value is _0.5_.

```ts
const myTexture = new Texture("materials/alpha.png")

// Material with ALPHABLEND
const myMaterial = new Material()
myMaterial.albedoTexture = myTexture
myMaterial.alphaTexture = myTexture

// Material with ALPHATEST
const myMaterial2 = new Material()
myMaterial2.albedoTexture = myTexture
myMaterial2.alphaTexture = myTexture
myMaterial.transparencyMode = 1 // ALPHATEST
myMaterial.alphaTest = 0.3
```

## Reuse materials

If multiple entities in your scene use a same material, there's no need to create an instance of the material component for each. All entities can share one same instance, this keeps your scene lighter to load and prevents you from exceeding the maximum amount of materials per scene.

```ts
//Create entities and assign shapes
const box = new BoxShape()
const myEntity = new Entity()
myEntity.addComponent(box)
const mySecondEntity = new Entity()
mySecondEntity.addComponent(box)
const myThirdEntity = new Entity()
myThirdEntity.addComponent(box)

//Create material and configure fields
const myMaterial = new Material()
myMaterial.albedoColor = Color3.Blue()

//Assign same material to all entities
myEntity.addComponent(myMaterial)
mySecondEntity.addComponent(myMaterial)
myThirdEntity.addComponent(myMaterial)
```
