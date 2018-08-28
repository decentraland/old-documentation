---
date: 2018-01-01
title: Entity reference
redirect_from:
  - /docs/entities
description: Entities and the available interfaces for constructing entities.
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 4
---

## Introduction

Entities are the basic unit for building everything in Decentraland scenes, think of them as the equivalent of Elements in a DOM tree in web development. All entities share the same base constructor, they all have a tag, attributes, and children entitiies.

`<entity>` is the base element of Decentraland, all elements are built by extending the base `entity` object. An `<entity>` can contain several components, each component introduces attributes that modify the entity in different ways. For example, you can include the `color` component on an entity to set its color, or include the `withCollisions` component to make it collidable.

> Tip: When editing the code via a source code editor (like Visual Studio Code or Atom), you can see the list of components supported by a type of entity. Typically, this is done by placing the cursor in the entity and pressing _Ctrl + Space bar_.

An entity can have other entities as children, these inherit the components from the parent. If a parent entity is positioned, scaled or rotated, its children are also affected. Thanks to this, we can arrange entities into trees.

```ts
interface IEntity {
  /** name of the entity */
  tag: string
  /** dictionary of attributes a.k.a.: properties */
  attributes: Dictionary<any>
  /** children entities */
  children: IEntity[]
}
```

## Box

Creates a cube geometry.

Example:

{% raw %}

```tsx
<box position={{ x: 5, y: 0, z: 2 }} color="#ff00aa" scale={2} />
```

{% endraw %}

Interface reference:

```tsx
interface BoxEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string
  /** Material selector */
  material?: string
  /** Set to true to turn on the collider for the entity. */
  withCollisions?: boolean
}
```

## Sphere

Creates a sphere geometry.

Example:

{% raw %}

```tsx
<sphere position={{ x: 5, y: 0, z: 2 }} color="#ff00aa" scale={2} />
```

{% endraw %}

Interface reference:

```tsx
interface SphereEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string
  /** Material selector */
  material?: string
  /** Set to true to turn on the collider for the entity. */
  withCollisions?: boolean
}
```

## Plane

Creates a plane geometry.

Example:

{% raw %}

```tsx
<plane
  position={{ x: 5, y: 0, z: 2 }}
  color="#ff00aa"
  scale={{ x: 10, y: 5, z: 1 }}
/>
```

{% endraw %}

Interface reference:

{% raw %}

```tsx
interface PlaneEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string

  /** Material selector */
  material?: string

  /** Set to true to turn on the collider for the entity. */
  withCollisions?: boolean
}
```

{% endraw %}

## Cylinder and Cone

Creates a cone geometry. A cylinder is defined as a cone with the same base and top radius.

Example cone:

```tsx
<cone
  radiusTop={0}
  radiusBottom={1}
  position={vector}
  color="#ff00aa"
  scale={2}
/>
```

Example cylinder:

```tsx
<cylinder
  openEnded
  arc={180}
  radius={0.5}
  position={vector}
  color="#ff00aa"
  scale={2}
/>
```

Interface reference:

```tsx
interface CylinderEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string

  /** Material selector */
  material?: string

  /** Set to true to turn on the collider for the entity. */
  withCollisions?: boolean

  /** Radius (meters) */
  radius?: number

  /** How much of the arc should be rendered, 360 by default (degrees) */
  arc?: number

  /** Radius of the top face (meters) */
  radiusTop?: number

  /** Radius of the bottom face (meters) */
  radiusBottom?: number

  /** Radial segments of the geometry. 4 will render a tetrahedron. */
  segmentsRadial?: number

  /** Vertical segments of the geometry */
  segmentsHeight?: number

  /** Render caps */
  openEnded?: boolean
}
```

## Text entity

A text entity can display a string of text in your scene. You can configure some basic text properties like the text color, its font, font weight, line spacing, etc.

```tsx
type TextEntity = BaseEntity & {
  /**
   * The width of the texts outline
   */
  outlineWidth?: number
  /**
   * The outline color in hexadecimal format (`#ff0000`)
   */
  outlineColor?: string
  /**
   * The text color in hexadecimal format (`#ff0000`)
   */
  color?: string
  /**
   * The name of the font to be used
   */
  fontFamily?: string
  /**
   * The text size
   */
  fontSize?: number
  /**
   * The weight of the text
   */
  fontWeight?: string
  /**
   * The text size
   */
  opacity?: number
  /**
   * The content of the text
   */
  value: string
  /**
   * The size of the space between lines
   */
  lineSpacing?: string
  /**
   * If set to true the text will wrap to the next line when the maximun width is reached
   */
  textWrapping?: boolean
  /**
   * Horizontal alignment (`top`, `right`, `bottom` or `left`)
   */
  hAlign?: string
  /**
   * Vertical alignment (`top`, `right`, `bottom` or `left`)
   */
  vAlign?: string
  /**
   * The text width
   */
  width?: number
  /**
   * The text height
   */
  height?: number
  lineCount?: number
  resizeToFit?: boolean
  shadowBlur?: number
  shadowOffsetX?: number
  shadowOffsetY?: number
  shadowColor?: string
  zIndex?: number
  paddingTop?: number
  paddingRight?: number
  paddingBottom?: number
  paddingLeft?: number
}
```

## glTF models

[glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common,
extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

The _gltf-model_ entity loads a 3D model using a glTF file. It supports both _.gltf_ or _.glb_ extensions.

> _.gltf_ is a more human-readable format, _.glb_ is a more compact version of the same.

Simple example:

{% raw %}

```tsx
<gltf-model
  position={{ x: 5, y: 3, z: 5 }}
  scale={0.5}
  src="models/shark_anim.gltf"
/>
```

{% endraw %}

Example with animations:

{% raw %}

```tsx
<gltf-model
  position={{ x: 5, y: 3, z: 5 }}
  scale={0.5}
  src="models/shark_anim.gltf"
  skeletalAnimation={[
    { clip: "shark_skeleton_bite", playing: false },
    {
      clip: "shark_skeleton_swim",
      weight: 0.2,
      playing: true
    }
  ]}
/>
```

{% endraw %}

Interface reference:

```tsx
interface GltfEntity extends BaseEntity {
  /**
   * The source URL of the .gltf or .glb model, required
   */
  src: string

  /**
   * List of weighted skeletal animations
   */
  skeletalAnimation?: Array<SkeletalAnimation>
}

interface SkeletalAnimation {
  /**
   * Name or index of the animation in the model
   */
  clip: string | number
  /**
   * Does the animation loop?, default: true
   */
  loop?: boolean
  /**
   * Weight of the animation, values from 0 to 1, used to blend several animations. default: 1
   */
  weight?: number

  /**
   * Is the animation playing? default: true
   */
  playing?: boolean
}
```

> Note: Keep in mind that all models and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-06-scene-limitations %}).

## Base Entity

The `BaseEntity` interface is the most flexible of all, as it comes with no predefined components and lets you set values for any of the possible components.

Example:

{% raw %}

```tsx
<entity position={{ x: 2, y: 1, z: 0 }} scale={{ x: 2, y: 2, z: 0.05 }} />
```

{% endraw %}

You add a base entity to a scene via the XML tag `<entity>`. You can add an entity with no components to a scene to act as a container. The `<entity>` element has no components by default, so it's invisible and has no direct effect on the scene, but it can be positioned, scaled, and rotated and it can contain other child entities in it. Child entities are scaled, rotated, and positioned relative to the parent entity.

In dynamic scenes, it's also useful to include entities with no components as wrappers to group entities into a single object that can then be passed as an input for certain functions.

Interface reference:

```tsx
interface BaseEntity {
  /**
   * Moves the entity center to a given point in the scene or relative to a parent entity
   */
  position?: Vector3

  /**
   * Rotates the entity
   * The `x,y,z` components are degrees (0°-360°), and every component represents the rotation in that axis
   */
  rotation?: Vector3

  /**
   * Scales the entity in three dimensions
   */
  scale?: Vector3 | number

  /**
   * Defines if the entity and its children should be rendered
   */
  visible?: string

  /**
   * The ID is used to attach events and identify the entity in the scene tree
   */
  id?: string

  /**
   * The function that handles the click interaction event
   */
  onClick?: (e: IEvents["click"]) => void

  /**
   * Used to differentiate similar entities in lists
   */
  key?: string | number

  /**
   * Used to animate the transitions in the same fashion as CSS
   */
  transition?: {
    position?: TransitionValue
    rotation?: TransitionValue
    scale?: TransitionValue
    color?: TransitionValue
  }

  /**
   * Billboard defines a behavior that makes the entity face the camera in any moment.
   * There are three combinable types of camera-facing options defined in the object BillboardModes.
   *   BILLBOARDMODE_NONE: 0
   *   BILLBOARDMODE_X: 1
   *   BILLBOARDMODE_Y: 2
   *   BILLBOARDMODE_Z: 4
   *   BILLBOARDMODE_ALL: 7
   *
   * To combine billboard types, write those in the form:
   *   BillboardModes.BILLBOARDMODE_X | BillboardModes.BILLBOARDMODE_Y
   */
  billboard?: IBillboardModes

  /**
   * Adds spatial sound to the entities
   */
  sound?: SoundComponent
}

/**
 * This data type defines a three component vector. It is used for scaling, positioning and rotations
 */
interface Vector3 {
  x: number
  y: number
  z: number
}

/**
 * This data type defines the configurations for the animations of some components like "position".
 */
interface TransitionValue {
  duration: number
  timing?: TimingFunction
  delay?: number
}

type TimingFunction =
  | "linear"
  | "ease-in"
  | "ease-out"
  | "ease-in-out"
  | "quadratic-in"
  | "quadratic-out"
  | "quadratic-inout"
  | "cubic-in"
  | "cubic-out"
  | "cubic-inout"
  | "quartic-in"
  | "quartic-out"
  | "quartic-inout"
  | "quintic-in"
  | "quintic-out"
  | "quintic-inout"
  | "sin-in"
  | "sin-out"
  | "sin-inout"
  | "exponential-in"
  | "exponential-out"
  | "exponential-inout"
  | "bounce-in"
  | "bounce-out"
  | "bounce-inout"
  | "elastic-in"
  | "elastic-out"
  | "elastic-inout"
  | "circular-in"
  | "circular-out"
  | "circular-inout"
  | "back-in"
  | "back-out"
  | "back-inout"

export type SoundComponent = {
  /** Distance fading model, default: 'linear' */
  distanceModel?: "linear" | "inverse" | "exponential"
  /** Does the sound loop? default: false */
  loop?: boolean
  /** The src of the sound to be played */
  src: string
  /** Volume of the sound, values 0 to 1, default: 1 */
  volume?: number
  /** Used in inverse and exponential distance models, default: 1 */
  rolloffFactor?: number
  /** Is the sound playing?, default: true */
  playing?: boolean
}
```

## Obj

> WARNING: We only support the `obj-model` interface for legacy compatibility. We will probably get rid of it in the future, please use GLTF when
> possible.

Example:

```tsx
<obj-model src="models/shark.obj" />
```

Interface reference:

```tsx
interface ObjEntity extends BaseEntity {
  /**
   * The source URL of the .obj model, required
   */
  src: string
}
```

## Materials

Materials are defined as separate entities in a scene, this prevents material definitions from being duplicated, keeping the scene's code lighter.

Materials can then be applied to any entity that is a child of MaterialEntity (which is itself a child of BaseEntity). All primitives and plane entities can have a material, which is set by adding a `material` component to it.

Example:

```tsx
  <material
    id="reusable_material"
    albedo-color="materials/wood.png"
    roughness={0.5}
    />
  <sphere
    material="#reusable_material"
    />
```

This example shows the definition of a new material and then a shpere entity that uses it.

Interface reference:

```tsx
export type MaterialDescriptorEntity = {
  /**
   * Id of the material, it will be used to pick this material from other entities
   */
  id: string

  /**
   * Opacity.
   */
  alpha?: number

  /**
   * The color of a material in ambient lighting.
   */
  ambientColor?: ColorComponent

  /**
   * AKA Diffuse Color in other nomenclature.
   */
  albedoColor?: ColorComponent

  /**
   * AKA Specular Color in other nomenclature.
   */
  reflectivityColor?: ColorComponent

  /**
   * The color reflected from the material.
   */
  reflectionColor?: ColorComponent

  /**
   * The color emitted from the material.
   */
  emissiveColor?: ColorComponent

  /**
   * Specifies the metallic scalar of the metallic/roughness workflow.
   * Can also be used to scale the metalness values of the metallic texture.
   */
  metallic?: number

  /**
   * Specifies the roughness scalar of the metallic/roughness workflow.
   * Can also be used to scale the roughness values of the metallic texture.
   */
  roughness?: number

  /**
   * Texture applied as material.
   */
  albedoTexture?: string

  /**
   * Texture applied as opacity. Default: the same texture used in albedoTexture.
   */
  alphaTexture?: string

  /**
   * Emmisive texture.
   */
  emisiveTexture?: string

  /**
   * Stores surface normal data used to displace a mesh in a texture.
   */
  bumpTexture?: string

  /**
   * Stores the refracted light information in a texture.
   */
  refractionTexture?: string

  /**
   * Intensity of the direct lights e.g. the four lights available in scene.
   * This impacts both the direct diffuse and specular highlights.
   */
  directIntensity?: number

  /**
   * Intensity of the emissive part of the material.
   * This helps controlling the emissive effect without modifying the emissive color.
   */
  emissiveIntensity?: number

  /**
   * Intensity of the environment e.g. how much the environment will light the object
   * either through harmonics for rough material or through the refelction for shiny ones.
   */
  environmentIntensity?: number

  /**
   * This is a special control allowing the reduction of the specular highlights coming from the
   * four lights of the scene. Those highlights may not be needed in full environment lighting.
   */
  specularIntensity?: number

  /**
   * AKA Glossiness in other nomenclature.
   */
  microSurface?: number

  /**
   * If sets to true, disables all the lights affecting the material.
   */
  disableLighting?: boolean

  /**
   * Sets the transparency mode of the material.
   *
   * | Value | Type                                |
   * | ----- | ----------------------------------- |
   * | 0     | OPAQUE  (default)                   |
   * | 1     | ALPHATEST                           |
   * | 2     | ALPHABLEND                          |
   * | 3     | ALPHATESTANDBLEND                   |
   */
  transparencyMode?: ITransparencyModes

  /**
   * Does the albedo texture has alpha?
   */
  hasAlpha?: boolean
}

export type MaterialEntity = BaseEntity & {
  /**
   * Color of the vertices
   */
  color?: string | number

  /**
   * Material selector
   */
  material?: string

  /**
   * Set to true to turn on the collider for the entity.
   */
  withCollisions?: boolean
}

export type BasicMaterialEntity = {
  /**
   * Id of the material, it will be used to pick this material from other entities
   */
  id: string

  /**
   * The source of the texture image
   */
  texture: string

  /**
   * Enabled crisper images based on the provided sampling mode
   * | Value | Type      |
   * |-------|-----------|
   * |     1 | NEAREST   |
   * |     2 | BILINEAR  |
   * |     3 | TRILINEAR |
   */
  samplingMode?: number

  /**
   * A number between 0 and 1.
   * Any pixel with an alpha lower than this value will be shown as transparent.
   */
  alphaTest?: number
}
```

## Creating custom interfaces

You can create your own interface to create entities with customized default behavior and characteristics. To define the interface, create a new _.tsx_ file that includes all the components and methods needed to construct and handle the entity.

For example, the sample below defines an entity type `button`:

{% raw %}

```tsx
import { createElement, Vector3Component } from "decentraland-api"

export interface IProps {
  position: Vector3Component
}

export const Button = (props: IProps) => {
  return (
    <entity position={props.position}>
      <gltf-model
        id="start_button"
        src="assets/My_Button.gltf"
        rotation={{ x: 90, y: 0, z: 0 }}
        scale={{ x: 0.5, y: 0.5, z: 0.5 }}
      />
    </entity>
  )
}
```

{% endraw %}

Before you can use this entity type, save it as a _.tsx_ file and import it to _scene.tsx_:

```tsx
import { Button } from "./src/Button"
```

After importing the file, you can add buttons to a scene by simply writing the following:

{% raw %}

```tsx
<Button position={{ x: 0, y: 1.5, z: 0 }} />
```

{% endraw %}
