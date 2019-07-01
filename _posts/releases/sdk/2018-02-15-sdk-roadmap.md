---
date: 2018-02-15
title: SDK Roadmap
description: SDK features planned for future releases
categories:
  - releases
  - sdk
type: Document
set: releases
set_order: 1
---

Features after 6.1 will be released one at a time as they're developed.


## Next features

- Improve scene boundaries checking
- Display 2D NFTs
- Timing helpers:
	- Execute every x milliseconds
	- Delay x milliseconds
	- Remove entity after x milliseconds
- Collision triggers - clipping events (contact with surface)
- Sticky collisions (enable user movement, ex: elevator)
- Smooth animation transitions
- Positioning helpers:
	- Return direction vector from Transform & Camera objects: (forward, up, right, left, down, and back)
	- Get and set the full transformation matrix from a Transform
	- OutOfBounds component: remove entity if it leaves a region

## Later


- Collision triggers - AABB (overlapping with area)
- Raycasting functions
- A/B buttons with actions defined by developer
- Raycasting helpers: 
	- OnPointerIn: Called when cursor points at an entity
	- OnPointerOut: Called when cursor stops pointing at an entity
- State-machine component
- Change GLTF materials in runtime
- Event when player leaves scene
- Improve the experience of setting UVs somehow for texture tiling.
- Integrate with Identity service to query player data
- Multiplayer helpers
- Helpers for AI behavior and querying for other entities in the scene
- In-world UIs (not fixed on the player's screen)
