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

Creating a library that is compatible with Decentraland and easy to share can be tricky. By using the CLI and following the steps detailed here, you can avoid most of the complexity.

## Create a library

To create your own library and share it via NPM, do the following

1. In an empty folder, run `dcl init`

   Select the option `Library`.

   This will create all of the default files and dependencies for a Decentraland library.

2. Set a unique `name` in `package.json`. This is the name that will be used when publishing to NPM.

3. Create a new _public_ GitHub repository for your project.

   The project is configured to use github actions to publish a new version of the package on every push to `main`.

4. Get an NPM token.

   1. Create an account or log in to https://www.npmjs.com/.
   2. Go to **Account > Access Tokens > Generate new Token**
      Create a new token, make sure you give it
      Publish permissions.

      You'll see a success message that includes a string for the newly generated token. Copy this string and store it somewhere safe.

   3. In your github repository, go to **Settings > Environments**, then create a new environment. Name it "prod" or anything else you prefer.

   Once the environment exists, go to **Add Secret** and create a new `NPM_TOKEN` secret, and for its value paste token from NPM.

   4. Force a push to main and the package will be published.

   That's it, now the package can be installed by anyone using `npm i package-name`.

5. Flesh out the `/src` folder of your project with all the functionality you want to expose and push changes to GitHub.

## Develop

Test your library in a Decentraland scene while you develop it.

easier option is to publish changes to npm each step
Now you can go to your scene and run `npm i package-name`, and run `dcl start`.

better option
npm run link

add everything in index

in a scene you import the library via...

maybe create a namespace?

## Notes on usability

Try your best to make your library easy to use for others. It's very common for the creator of a tool to make assumptions that may appear obvious to them, but that are not for a user with less context.

- Choose names carefully for everything in your library, including functions, components, parameters. It's better to have a long name that is self-explanatory than a short one that is a complete mystery.
- Think widely about different possible use cases for your library. Maybe someone uses your library in a smart wearable, maybe someone needs to turn your system on or off at will, maybe someone needs to add multiple instances of your system in the same scene. Not everyone will be facing the same challenges as you.
- That being said, you don't need to support all possible use cases. In fact there's always tradeoffs to make between flexibility vs simplicity of use. Creating good tools is all about striking the right balance and being strategic about where you draw the line for what you chose not to support. It's important to clearly document the limitations you decided to go with, though.
- This brings us to Documentation. Document your library clearly, with examples, descriptions of what each parameter does, comments about what scenarios wouldn't work and what assumptions you're making about the context where it's being used. The library's README.md is often the best place to expose this content.
- Another great tool is to add metadata comments directly into your code. These comments get displayed by the IDE (like VS Studio Code) as users of the library type. You can describe what each function/component is for, describe what each parameter expects to receive, and what a function returns. Thanks to this, users of your library don't need to switch between code and the docs, it's all there in one place! For example, look at this function from the ECS Utils library:

  ```ts
  /**
   * Clamps a value so that it doesn't exceed a minimum or a maximum value.
   *
   * @param value - input number
   * @param min - Minimum output value.
   * @param max - Maximum output value.
   * @returns The resulting mapped value between the min and max
   * @public
   */
  export function clamp(value: number, min: number, max: number) {
    let result = value

    if (value > max) {
      result = max
    } else if (value < min) {
      result = min
    }
    return result
  }
  ```

  Users of this library see these hints displayed as they type the function:

  ![]({{ site.baseurl }}/images/media/library-hints.png)

- Always declare types. Don't make the output of your function `type: any`, don't leave people guessing what object structure they'll have to consume.
- Keep your library light and focused on one functionality. When a Decentraland scene is compiled, all of the code in all of its libraries gets packaged with it, even code that is never called by the scene. For this reason, it's best to avoid creating large bulky libraries. It's better to have lean libraries that let creators only use what they really need.
- Keep an eye on your library's repo, people might make pull requests or report issues.
- Include licensing info on your repo, that way others know if they are free to use your library. The default library includes an Apache 2 license, feel free to change that if you wish.
