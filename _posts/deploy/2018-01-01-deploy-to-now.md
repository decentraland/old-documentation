---
date: 2018-01-01
title: Upload a preview
description: Upload a preview of your scene to a server and share it offchain.
categories:
  - deploy
type: Document
---

Previews of Decentraland scenes can run as standalone pages, just as you can run a preview locally in your machine. This is a fantastic way to share interactive previews of your content with others! It's also useful to test your scenes in other platforms, such as mobile.

Decentraland scene previews are compatible with the following hosting platforms:

- [Zeit Now](https://zeit.co/now) _(free)_
- [GitHub pages](https://pages.github.com/) _(free)_
- [Amazon S3](https://aws.amazon.com/s3/)

Once uploaded to one of these platforms, the only thing that others have to do in order to explore your scene is open a link. They don’t need to install the CLI, Node, NPM, or any of the other tools that would be required to run the preview on their local machine.

For example here are some scenes that are currently running in Zeit Now:

- [Block Dog](https://blockdog-wtciaozdbo.now.sh)
- [Humming birds](https://hummingbirds-ujovmbtmui.now.sh)

Note that it's not necessary to own LAND to upload a scene preview to a server. The uploaded content isn't linked to the blockchain in any way. When running the preview, other adjacent parcels appear as empty.

## Before you begin

To upload a preview to a server, make sure you’re using the latest version of the SDK. Check the **Release notes** section if you're not sure.

Remember that the SDK version is specified in the scene and is determined when you first create it with the CLI. So, if you have a scene you created with an older version of the CLI, and then update the CLI, you will need to manually update the scene so it references the latest version of the SDK.

Your scene must also be compiled, as what you'll be uploading are the files in the `/bin` folder instead of in the `/src` folder.

If you haven't compiled your scene with the latest changes, you can do it by running `npm install`. The scene is also compiled automatically every time you run a preview with `dcl start`.

> Note: If the scene you want to deploy was built with an older version of the CLI (2.2.6 or older), update the `dclignore` file in your project to include the following entries:

    - node_modules
    - dist
    - export

## Prepare a scene for deploying

To deploy your scene to a hosting service like Zeit Now, GitHub pages, or Amazon S3, you must first export your scene's code to the format of a static webpage. To do this, run the following command:

```
dcl export
```

This creates a new folder named `export` in your project directory. This folder contains everything needed to run your scene, in a format that's compatible with most hosting services.

Upload only the contents of the `export` folder to the hosting service.

> Note: The `/export` folder is built based on the contents of the `/bin` folder. Make sure that the latest version of your scene's source code has been compiled before running the `dcl export` command. You can compile your scene by running `npm install` or `dcl start`.

## Deploy to Zeit Now

To deploy a scene to now:

1. Make sure you have the latest version of the _Zeit Now CLI_, and of the _Decentraland CLI_ installed.

   ```
   npm i -g decentraland now
   ```

2. Run the following command form the scene's `export` folder (that you created with the `dcl export` command):

   ```
   now
   ```

   The console will show you the output of the server as it installs the necessary dependencies to run your scene. This takes a few minutes.

3. When done, the URL to the server should automatically be added to your clipboard, ready to paste in a browser!

   You can otherwise get the link in the console's output, it will resemble something like `https://myscene-gnezxvoayw.now.sh`.

   > Tip: The URL will take the folder name as part of the path. You can rename the `export` folder to anything you want. That won't affect the scene, but it will change the URL.

4. Share the link with anyone you want! _Now_ will keep hosting your scene at that link indeterminably.

> Note: Keep in mind that the free version of Now enforces a maximum file size of 50 MB.

Optionally, you can alias your deployment with now.sh domain, or any domain you have registered at Now. The following eample uses the decentraland.now.sh domain:

```
now alias {deploymentId} decentraland.now.sh
```

> Note: for scenes that were originally built with version 6.0 or older, you will have to make a couple of manual adjustments to your project. See [this blogpost](https://decentraland.org/blog/announcements/decentraland-on-now/) for more details.

## Multiplayer considerations

Note that scenes deployed to a server behave as single player experiences, even though you're able to see other users moving around.

User positions are shared, but each user runs the scene locally in their browser. If the scene can be modified by a user's interaction, each user will see the scene in a different state.

To synchronize the scene's state amongst users, there are two approaches (see [multiplayer considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-10-remote-scene-considerations %}) ) If you use a remote server to sync the state amongst the various users, then you should also deploy the server somewhere, separate from the scene. You can also deploy the server to `now`, by following the steps below.

#### Upload multiplayer scenes

If you created your scene based on one of the remote scene examples, then you need to make two separate deployments, one for the server and another for the scene client.

For example, to deploy both server and the scene client to Zeit now, follow these steps:

1. Change directory to the `/server` folder and run the following command to deploy just the server:

   ```
   now
   ```

2) Copy the URL from the deployed project.

3) In the `/scene` folder, modify the code so that it points to the link of the server you deployed to Now (the URL you just copied).

   If your scene uses a websocket connection, you must modify the URL address manually so that it begins with _wss_ (web socket secure) instead of _https_.

   For example, if the server’s address is `https://dcl-project-fsutefbepd.now.sh/`, you should modify it to `wss://dcl-project-fsutefbepd.now.sh/`.

4) Deploy the full scene folder, running

   ```
   now
   ```

5) Once the upload is completed, the URL to the scene preview should be in your clipboard, ready to share.
