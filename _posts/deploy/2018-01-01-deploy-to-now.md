---
date: 2018-01-01
title: Deploy to Zeit
description: Upload a scene to Zeit to share it offchain.
redirect_from:
  - /documentation/publishing/
categories:
  - deploy
type: Document
set: deploy
set_order: 7
---

Decentraland scene previews are compatible with Now, a very handy service that lets you upload content to a server to run for as long as you like, for free. You can very easily upload a Decentraland scene to one of these servers, and the preview for that scene will be automatically launched for each visitor.

This is a fantastic way to share your content with others! District leaders can use this to demonstrate their progress, developers can get feedback from others, or you can simply share what you’ve built with the community to get recognition for your work and to inspire others.

Once uploaded to Now, the only thing people have to do to see your scene is follow a link. They don’t need to install the CLI, Node, NPM, or any of the other tools that would be required to run the preview on their local machine.

For example here are some scenes that are currently running in Now:

- Block Dog
- Humming birds

Note that it's not necessary to own LAND to upload a scene preview to Zeit. The uploaded content isn't linked to the blockchain in any way. When running the preview, other adjacent parcels appear as empty.

## Get your scene ready

To run your scene in Now, make sure you’re using the latest version of the SDK. Check [Release notes]() if you're not sure.

Remember that the SDK version is specified in the scene and is determined when you first create it with the CLI. So, if you have a scene you created with an older version of the CLI, and then update the CLI, you will need to manually update the scene so it references the latest version of the SDK.

Once your scene has been updated to the latest version, modify the `package.json` file to include a new script called `now-start`. This script should run `dcl start --ci`.

Your package.json file should contain something like:

```json
{
  "name": "dcl-project",
  "version": "1.0.0",
  "description": "My new Decentraland project",
  "scripts": {
    "start": "dcl start",
    "now-start": "dcl start --ci",
    "build": "decentraland-compiler build.json",
    "watch": "decentraland-compiler build.json --watch"
  },
  "author": "",
  "license": "MIT",
  "devDependencies": {
    "decentraland-api": "latest",
    "decentraland": "latest"
  },
  "dependencies": {
    "ajv": "^6.5.3"
  }
}
```

Now will automatically run the script that’s on `now-start` as soon as the scene is deployed. We’re using the `--ci` flag on the `dcl start` command to make the preview run in a slightly different way that’s fully compatible with Now and other hosting and testing services.

## Download and use the Now Desktop Client

1. Go to [zeit.co’s website](https://zeit.co/now) to download the _Now Desktop Client_.

2. Once you’ve installed and opened the desktop client, you should see the triangular _Now_ icon appear next to your other running programs.

![](/images/media/now_deployment.png)

3. Click the entire scene folder and drop it on the _Now_ icon on the toolbar. That will start uploading the folder’s contents to the server.

4. A new tab will open automatically in your web browser, showing you the server’s console as it installs the necessary dependencies to run your scene. This takes a few minutes, but eventually the scene preview should open automatically once everything is installed.

5. Share the link with anyone you want! _Now_ will keep hosting your scene at that link indeterminably.

Keep in mind that the free version of Now enforces a maximum file size of 50 MB.

If your scene exceeds this limit, try deleting the node_modules folder and any other files in the scene folder that don’t need to be uploaded or that can be automatically installed by the server based on `package.json`.

## Multiplayer considerations

Note that all scenes deployed to _Now_ behave as multiplayer. This is because the preview is running off a server, not locally. If multiple users are accessing the scene, they will all interact with the same scene state.

This is not how scenes currently work when viewed in Decentraland. When a user views a scene, it's running locally in their own machine. To synchronize the scene's state, it's currently necessary to use a remote server to sync the state amongst the various users.

The fact that in a Zeit scene multiple users can interact with a single consistent state it a great way to playtest a scene before having to develop interactions with the server.

## Upload multiplayer scenes

If you created your scene based on the remote scene examples, then you need to make two separate deployments to Now, one for the server and another for the scene client.

First drag the `/server` folder over to the Now icon on your toolbar to deploy it. A browser window will open showing you a console as all of the dependencies are installed. Once that’s done and the preview is launched, copy the URL from the browser tab.

In the `/scene` folder, modify the code so that it points to the link of the server you deployed to Now (the URL you just copied). You must modify the URL address manually so that it begins with wss (web socket secure) instead of https.

For example, if the server’s address is `https://dcl-project-fsutefbepd.now.sh/`, you should modify it to `wss://dcl-project-fsutefbepd.now.sh/`.

After making the necessary adjustments to the scene, you can drag the `/scene` folder over to the _Now_ icon in your toolbar to deploy it.
