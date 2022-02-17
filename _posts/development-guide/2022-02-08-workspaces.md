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

1. Create a top-level folder to hold the workspace.

2. Inside this folder, add one folder at root level for each project you want to work with. You can drag in existing folders with scenes or smart wearables. For new folders, run `dcl init` inside each, to create a Decentraland project.

   > Note: Make sure that the parcels on each of the scenes don't overlap.

3. Standing on the workspace folder, run the following, to create the necessary files:

   `dcl workspace init`

To add or remove projects from the workspace, you must modify the `dcl-workspace.json` file. Modify the file to include the relative paths to each of the projects in the workspace in the `folders` array.

```json
{
  "folders": [
    {
      "path": "example-scene"
    },
    {
      "path": "example-scene2"
    }
  ]
}
```
 > Note: You can also manually add projects that are not inside the workspace folder, by referring to their absolute path in their "path" field.


## Run a workspace

Run `dcl start` on the root folder of the workspace. This runs all of the projects at the same time, viewable in a single preview window. This preview behaves just like when previewing a single scene.

Any smart wearables in the workspace are available to try on by looking for them in the backpack.
