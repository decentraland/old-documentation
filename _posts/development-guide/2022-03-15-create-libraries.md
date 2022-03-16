---
date: 2022-02-08
title: Create a library
description: Create your own Decentraland libraries to share with others
categories:
  - development-guide
type: Document
---

Libraries are a great way to share solutions to a common problems. Complex problems can be approached once, the solutions encapsulated into a module, and then tackled each time they come up with a simple one-liner. By sharing libraries with the community, we can make the productivity of other creators grow exponentially.

Currently, these libraries in the [Awesome Repository](https://github.com/decentraland-scenes/Awesome-Repository#Libraries) are available for all to use. We encourage you to create and share your own as well.

## Create a library

To create your own library, do the following

1. In an empty folder, run `dcl init`
2. Select the option `Library`.

   This will create all of the default files and dependencies for a Decentraland library.

3. Set a unique `name` in `package.json`. This is the name that will be used when publishing to NPM.

4. Upload your project to a new _public_ GitHub repository.

   We are going to use github actions to publish a new version of the package on every push to `main`.

5. Get an NPM token.

   1. To publish this package as a npm package, you must first have an account at https://www.npmjs.com/.
   2. Go to **Account > Access Tokens > Generate new Token**
      Create a new token, make sure you give it
      Publish permissions.

      You'll see a success message that includes a string for the newly generated token. Copy this string and store it somewhere safe.

   3. In your github repository, go to **Settings > Environments**, then create a new environment. Name it "prod" or anything else you prefer.

   Once the environment exists, go to **Add Secret** and create a new `NPM_TOKEN` secret, and for its value paste token from NPM.

   4. Force a push to main and the package will be published.

   That's it, now the package can be installed by anyone using `npm i package-name`.

6. Flesh out the `/src` folder of your project with all the functionality you want to expose and push changes to GitHub.

## Test

easier option is to publish changes to npm each step
Now you can go to your scene and run `npm i package-name`, and run `dcl start`.

better option
npm run link

## Structure

add everything in index

in a scene you import the library via...

maybe create a namespace?

## notes on usability

- clear naming
- think about different cases... what if the creator is making a smart wearable rather than a scene
- documentation!!! if not all use cases are covered, that's fine, but be clear about that in the docs
- keep the library light
- leave a way to contact you or create issues in the readme

other

- can't package 3d models or images or sounds
  workaround for images: fetch from a server
