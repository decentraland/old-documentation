---
date: 2018-01-01
title: Upload a preview
description: Upload a preview of your scene to a server and share it offchain.
redirect_from:
  - /deploy/deploy-to-now/
categories:
  - development-guide
type: Document
---

If you don't own parcels in Decentraland or are not ready to [deploy]({{ site.baseurl }}{% post_url /development-guide/2018-01-07-publishing %}) your scene to Decentraland, you can upload your scene preview to run as an app in a free server.

Once uploaded, the only thing that others have to do to explore your scene is follow a link. They don’t need to install the CLI, Node, NPM, or any of the other tools that would be required to run the preview on their local machine.

Note that it's not necessary to own LAND to upload a scene preview to a Heroku server. The uploaded content isn't linked to the blockchain in any way. When running the preview, other adjacent parcels appear as empty.

Follow the steps below to upload your scenes to a free Heroku server:

1. Make sure you have the latest Decentralnd CLI version installed on your machine `npm i -g decentraland@latest`.

2. Create a free [Heroku](https://dashboard.heroku.com/) account, if you don't already have one.

3. Install the Heroku CLI. Do this via `npm i -g heroku`, or see [their documentation](https://devcenter.heroku.com/articles/heroku-cli#install-the-heroku-cli) for alternatives.

4. Create a git repository for your project.

   a) Create with `git init`

   b) Do `git add` and `git commit -m 'initial commit'

   c) Set the current branch to _main_ via `git branch -m master main`

   d) Make sure the `.gitignore` file contains the following:

   ```
   /node_modules
   package-lock.json
   npm-debug.log
   .DS_Store
   /*.env
   bin
   ```
   > Note: Make sure your Decentraland project uses the latest SDK version, do `npm i decentraland-ecs@latest`. Projects uploaded to Heroku or similar platformas and built with versions older than 6.10.0 will not be supported and will not be allowed to fech avatar data from content servers.

5. Use the Heroku CLI to log into your Heroku account with `heroku login`. This opens a browser window to provide your user and password.

6. Create a new Heroku application and give it a unique name. In the Heroku site do that via **New** > **Create new App**. Otherwise, in the Heroku CLI do it via `heroku create -a example-dcl-scene`

7. Link your Decentraland project to your Heroku application. On the project folder run `heroku git:remote -a example-dcl-scene` (using the name you created you heroku application with)

8. Edit `package.json` in your scene to change the `start` script to `CI=true dcl start -p ${PORT:=8000}`

9. Explicitly install the Decentraland CLI as a dependency of your project, running `npm i --save decentraland`

10. Deploy your scene preview with `git push heroku main`

11. To access the scene, copy the link shared by the Heroku deploy command. Then manually add the following parameters to the URL `?realm=localhost-stub&renderer-branch=master`.

    For example if the link shared by Heroku is `https://example-dcl-scene.herokuapp.com`, the link you should enter is `https://example-dcl-scene.herokuapp.com/?realm=localhost-stub&renderer-branch=master`.

Every time you make changes to your scene, make sure you:

- Commit and push your changes to the git repo
- Push the new version to the Heroku app `git push heroku main`

You can read the console logs of the scene preview by running `heroku logs --tail`
