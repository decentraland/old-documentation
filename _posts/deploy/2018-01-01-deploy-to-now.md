---
date: 2018-01-01
title: Deploy to Zeit
description: Upload a scene to Zeit to share it offchain.
categories:
  - deploy
type: Document
set: deploy
set_order: 7
---

Decentraland scene previews are compatible with [Now](https://zeit.co/now), a very handy service that lets you upload content to a server and run it for as long as you like, for free. You can easily upload a Decentraland scene preview to one of these servers.

This is a fantastic way to share interactive previews of your content with others! It's also useful to test your scenes in other platforms, such as mobile.

Once uploaded to Now, the only thing that others have to do in order to explore your scene is open a link. They don’t need to install the CLI, Node, NPM, or any of the other tools that would be required to run the preview on their local machine.

For example here are some scenes that are currently running in Now:

- Block Dog
- Humming birds

Note that it's not necessary to own LAND to upload a scene preview to Now. The uploaded content isn't linked to the blockchain in any way. When running the preview, other adjacent parcels appear as empty.

## Get your scene ready

To run your scene in Now, make sure you’re using the latest version of the SDK. Check the **Release notes** section if you're not sure.

Remember that the SDK version is specified in the scene and is determined when you first create it with the CLI. So, if you have a scene you created with an older version of the CLI, and then update the CLI, you will need to manually update the scene so it references the latest version of the SDK.

## Deploy to Now

To deploy a scene to now:

1. Run the following command form the scene folder:

   ```
   npm run deploy:now
   ```

   The console will show you the output of the server as it installs the necessary dependencies to run your scene. This takes a few minutes.

2. When done, the URL to the server should automatically be added to your clipboard, ready to paste in a browser!

   You can otherwise get the link in the console's output, it will resemble something like `https://myscene-gnezxvoayw.now.sh`.

3. Share the link with anyone you want! _Now_ will keep hosting your scene at that link indeterminably.

Keep in mind that the free version of Now enforces a maximum file size of 50 MB.

If your scene exceeds this limit, try deleting the node_modules folder and any other files in the scene folder that don’t need to be uploaded or that can be automatically installed by the server based on what's stated in `package.json`.

## Multiplayer considerations

Note that scenes deployed to _Now_ behave as single player experiences, even though you're able to see other users moving around.

User positions are shared, but each user runs the scene locally in their browser. If the scene can be modified by a user's interaction, each user will see the scene in a different state.

To synchronize the scene's state amongst users, it's currently necessary to use a remote server to sync the state amongst the various users.

## Upload multiplayer scenes

If you created your scene based on the remote scene examples, then you need to make two separate deployments to Now, one for the server and another for the scene client.

1. Change directory to the `/server` folder and run the following command to deploy just the server:
   
   ```
   npm run deploy:now
   ```

2) Copy the URL from the deployed project.

3) In the `/scene` folder, modify the code so that it points to the link of the server you deployed to Now (the URL you just copied).

   If your scene uses a websocket connection, you must modify the URL address manually so that it begins with _wss_ (web socket secure) instead of _https_.

   For example, if the server’s address is `https://dcl-project-fsutefbepd.now.sh/`, you should modify it to `wss://dcl-project-fsutefbepd.now.sh/`.

4) Deploy the full scene folder, running

   ```
   npm run deploy:now
   ```

5) Once the upload is completed, the URL to the scene preview should be in your clipboard, ready to share.
