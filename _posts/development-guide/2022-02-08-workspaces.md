---
date: 2022-02-08
title: Workspaces
description: Run multiple DCL projects at a time
categories:
  - development-guide
type: Document
---

Run multiple Decentraland projects in preview by grouping these into a workspace. Run multiple adjacent scenes to see how they fit, or also run multiple [smart wearables]({{ site.baseurl }}{% post_url /development-guide/2022-02-02-smart-wearables %}) together to see how they interact with each other and with different scenes.

Running multiple projects in a workspace provides a much more complete testing alternative, to ensure different content works well together.

## Create a workspace

1. Create a top-level folder to hold the workspace.

2. Inside this folder, add one folder at root level for each project you want to work with. You can drag in existing folders with scenes or smart wearables. For new folders, run `dcl init` inside each, to create a Decentraland project.

   > Note: Make sure that the parcels on each of the scenes don't overlap.

3. Standing on the workspace folder, run the following, to create the necessary files:

   `dcl workspace init`

You can confirm that the projects are part of the workspace by running `dcl workspace ls`.

## Run a workspace

Run `dcl start` on the root folder of the workspace. This runs all of the projects at the same time, viewable in a single preview window. This preview behaves just like when previewing a single scene.

Any smart wearables in the workspace are available to try on by looking for them in the backpack.

## Add projects

Once a workspace is created, you can add additional projects `dcl workspace add`, including the relative address of the folder you want to add. For example `dcl workspace add my-other-example`.

You can also add a project that is not inside the workspace folder, by using the absolute path.

> Note: The folder must already contain a decentraland project initatied with `dcl init`. It can't be an empty folder.

You can also edit the `dcl-workspace.json` file manually to add or remove projects. Modify the file to include the relative paths to each of the projects in the workspace in the `folders` array.

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
