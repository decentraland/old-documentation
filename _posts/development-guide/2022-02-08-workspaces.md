---
date: 2022-02-02
title: Workspaces
description: Run multiple DCL projects at a time
categories:
  - development-guide
type: Document
set: getting-started
---

Run multiple Decentraland projects in preview by grouping these into a workspace. Run multiple adjacent scenes to see how they fit, or also run multiple [smart wearables]({{ site.baseurl }}{% post_url /development-guide/2022-02-08-smart-wearables %}) together to see how they interact with each other and with different scenes.

Running multiple projects in a workspace provides a much more complete testing alternative, to ensure different content works well together.

## Create a workspace

1. Create a top-level folder to hold the workspace. Create a node project in this folder.

   `npm i --yes`

2. In the root folder install the `decentraland-ecs` library. This installation is shared between all the projects of the workspace.

   `npm i decentraland-ecs`

3. Create new folders as children of this root folder, or drag in the folders of existing projects. Each of these projects can either be a Decentraland scene or a smart wearable. Add as many projects as you want.

   > Note: Make sure that the parcels on each of the scenes don't overlap.

4. Create a new file in the root folder named `dcl-workspace.json`. Paste the following into that file:

   ```json
   {
     "folders": [
       {
         "path": "example-scene"
       },
       {
         "path": "example-scene2"
       }
     ],
     "settings": {}
   }
   ```

   Modify the file to include the relative paths to each of the projects in the workspace.

Settings????

## Run a workspace

Run `dcl start` on the root folder of the workspace. This runs all of the projects at the same time, viewable in a single preview window. This preview behaves just like when previewing a single scene.

Any smart wearables in the workspace are available to try on by looking for them in the backpack.
