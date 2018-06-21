---
date: 2018-01-01
title: Entities
description: Entities and the available interfaces for constructing entities.
categories:
  - api-reference
type: Document
set: api-reference
set_order: 2
---


# Introduction

Entities are the basic unit for building everything in Decentraland scenes, think of them as the equivalent of Elements in a DOM tree in web development. All entities share the same base constructor, they all have a tag, attributes, and children entitiies. 

> Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an *entity*, and each entity can include *components* that shape its characteristics and functionality. 

`<entity>` is the base element of Decentraland, all elements are built by extending the base `entity` object. An `<entity>` can contain several components, each component introduces attributes that modify the entity in different ways. For example, you can include the `color` component on an entity to set its color, or include the `ignoreCollision` component to change how it reponds to collisions with other entities.

An entity can have other entities as children, these inherit the components from the parent. If a parent entity is positioned, scaled or rotated, its children are also affected. Thanks to this, we can arrange entities into trees.

```ts
interface IEntity {
  tag: string;                 // name of the entity
  attributes: Dictionary<any>; // dictionary of attributes a.k.a.: properties
  children: IEntity[];         // children entities
}
```



## Base Entity


The `BaseEntity` interface is the most flexible of all, as it comes with no predefined components and lets you set values for any of the possible components.

You add a base entity to a scene via the XML tag `<entity>`. You can add an entity with no components to a scene to act as a container. The `<entity>` element has no components by default, so it's invisible and has no direct effect on the scene, but it can be positioned, scaled, and rotated and it can contain other child entities in it. Child entities are scaled, rotated, and positioned relative to the parent entity. 

Entities with no components can also be added to a scene to group entities into a single object that can then be passed as an input for certain functions.


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
    'linear'
  | 'ease-in'
  | 'ease-out'
  | 'ease-in-out'
  | 'quadratic-in'
  | 'quadratic-out'
  | 'quadratic-inout'
  | 'cubic-in'
  | 'cubic-out'
  | 'cubic-inout'
  | 'quartic-in'
  | 'quartic-out'
  | 'quartic-inout'
  | 'quintic-in'
  | 'quintic-out'
  | 'quintic-inout'
  | 'sin-in'
  | 'sin-out'
  | 'sin-inout'
  | 'exponential-in'
  | 'exponential-out'
  | 'exponential-inout'
  | 'bounce-in'
  | 'bounce-out'
  | 'bounce-inout'
  | 'elastic-in'
  | 'elastic-out'
  | 'elastic-inout'
  | 'circular-in'
  | 'circular-out'
  | 'circular-inout'
  | 'back-in'
  | 'back-out'
  | 'back-inout'
```

## Box

Creates a cube geometry.

```tsx
interface BoxEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string
  /** Material selector */
  material?: string
  /** Set to true to turn off the collider for the entity. */
  ignoreCollisions?: boolean
}

const example = <box position={vector} color="#ff00aa" scale={2} />
```

## Sphere

Creates a sphere geometry.

```tsx
interface SphereEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string
  /** Material selector */
  material?: string
  /** Set to true to turn off the collider for the entity. */
  ignoreCollisions?: boolean
}

const example = <sphere position={vector} color="#ff00aa" scale={2} />
```


## Plane

Creates a plane geometry

```tsx
interface PlaneEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string

  /** Material selector */
  material?: string

  /** Set to true to turn off the collider for the entity. */
  ignoreCollisions?: boolean
}

const example = <plane position={vector} color="#ff00aa" scale={ { x: 10, y: 5, z: 1 } } />
```

## Cylinder and Cone

Creates a cone geometry, a cylinder is a cone with the same base and top radius

```tsx
interface CylinderEntity extends BaseEntity {
  /** Color of the vertices */
  color?: string

  /** Material selector */
  material?: string

  /** Set to true to turn off the collider for the entity. */
  ignoreCollisions?: boolean

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

const example1 =
  <cylinder
    position={vector}
    color="#ff00aa"
    scale={2}
    openEnded
    arc={180}
    radius={0.5}
  />

const example2 =
  <cone
    radiusTop={0}
    radiusBottom={1}
  />
```

## glTF models

[glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common,
extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

The `gltf-model` entity loads a 3D model using a glTF (`.gltf` or `.glb`) file.

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

const example =
  <gltf-model
    position={ { x: 5, y: 3, z: 5 } }
    scale={0.5}
    src="models/shark_anim.gltf"
    skeletalAnimation={[
      { clip: 'shark_skeleton_bite', playing: false },
      { clip: 'shark_skeleton_swim', weight: 0.2, playing: true }
    ]}
  />
```



## Obj

> WARNING: We only support the `obj-model` interface for legacy compatibility. We will probably get rid of it in the future, please use GLTF when
possible.

```tsx
interface ObjEntity extends BaseEntity {
  /**
   * The source URL of the .obj model, required
   */
  src: string
}

const example = <obj-model src="models/shark.obj" />
```

## Custom Interfaces

You can create your own interface to create entities with customized default behavior and characteristics. To define the interface, create a new *.tsx* file that includes all the components and methods needed to construct and handle the entity.

For example, the sample below defines an entity type `button`:

{% raw %}
```tsx
import { createElement, Vector3Component } from "metaverse-api";

export interface IProps {
  position: Vector3Component;
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
  );
};
```
{% endraw %}

Before you can use this entity type, save it as a *.tsx* file and import it to *scene.tsx*:
```tsx
import { Button } from "./src/Button";
```

After importing the file, you can add buttons to a scene by simply writing the following:

{% raw %}
```tsx
<Button position={{ x: 0, y: 1.5, z: 0 }} />
```
{% endraw %}