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
- Collision triggers - clipping events (contact with surface)
- Moving ground moves player (enable user movement, ex: elevator)
- Raycasting functions
- A/B buttons with actions defined by developer

## Later

- Multiplayer helpers
- Smooth animation transitions
- Positioning helpers:
	- Return direction vector from Transform & Camera objects: (forward, up, right, left, down, and back)
	- Get and set the full transformation matrix from a Transform
	- OutOfBounds component: remove entity if it leaves a region
- Collision triggers - AABB (overlapping with area)
- Raycasting helpers: 
	- OnPointerIn: Called when cursor points at an entity
	- OnPointerOut: Called when cursor stops pointing at an entity
- State-machine component
- Change GLTF materials in runtime
- Event when player leaves scene
- Improve the experience of setting UVs somehow for texture tiling.
- Integrate with Identity service to query player data
- Helpers for AI behavior and querying for other entities in the scene
- In-world UIs (not fixed on the player's screen)
