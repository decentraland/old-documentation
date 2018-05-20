---
date: 2018-01-01
title: Entities
description: An overview of entities, and how to use them to build 3D scenes.
categories:
  - SDK
type: Document
set: getting-started-sdk
set_order: 3
---

# Basics

Here are all of the currently supported elements, or entities, that you can use to create three dimensional scenes in Decentraland.

## `<entity>`
`<entity>` is the base element of Decentraland. It acts as a container object that can be positioned, scaled, and rotated. The `<entity>` element can contain a set of components that might modify the base entity. For example, you can include the `color` component to change the color of your base `<entity>`.

Entities may contain other child entities; those children are scaled, rotated, and positioned relative to the parent entity.

# Possible components
- `position: {x: float, y: float, z: float}`: Moves the entity center to that point
- `rotation: {x: float, y: float, z: float}`: Rotates the entity with the center in the coordinate `0, 0, 0`. 
  The `x,y,z` components are degrees (0°-360°), and every component represents the rotation in that axis
- `scale: {x: float, y: float, z: float}`: Scales the entity in three dimensions
- `visible: boolean`: Defines if the entity and its children should be rendered
- `id: string`: The ID is used to attach events and identify the entity in the scene tree

## `<scene>`
`<scene>` is a plain entity used to define the root of a scene.

# Geometries

The following examples are written in JSX. 

```xml
<scene>
  <box />
  <sphere />
  <cone />
  <cylinder />

  <plane />
  <circle />
  <ring />

  <gltf-model src="model.glb" />
  <obj-model src="model.obj" mtl="materials.mtl" />

  <text value="Hello" />

  <video 
    src="https://..../video.mp4"
    height={0.48}
    width={0.64}
    volume={50} />
</scene>
```