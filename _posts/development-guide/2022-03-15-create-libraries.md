---
date: 2022-02-08
title: Create a library
description: Create your own Decentraland libraries to share with others
categories:
  - development-guide
type: Document
---

Libraries are a great way to share solutions to common problems. Complex challenges can be approached once, the solutions encapsulated into a library, and whenever they come up you just need to write one line of code. By sharing libraries with the community, we can make the productivity of all creators grow exponentially.

Currently, these libraries in the [Awesome Repository](https://github.com/decentraland-scenes/Awesome-Repository#Libraries) are available for all to use. We encourage you to create and share your own as well.

By using the CLI and following the steps detailed here, you can avoid most of the complexity that comes with creating a library that is compatible with Decentraland scenes and is easy to share with others.

## Create a library

> Note: Make sure you're using Node version 16.x or newer before you build your library.

To create your own library and share it via NPM, do the following:

1. In an empty folder, run `dcl init`, then select the option `Library`.

   This will create all of the default files and dependencies for a Decentraland library.

2. Set a unique `name` in `package.json`. This is the name that will be used when publishing to NPM, make sure there isn't some other existing project using that name on npm.

3. Create a new _public_ GitHub repository for your project.

   The project is configured to use github actions to publish a new version of the package on every push to `main`.

4. Get an NPM token:

   1. Create an account or log in to https://www.npmjs.com/.
   2. Go to **Account > Access Tokens > Generate new Token**
      Create a new token, give it **Publish** permissions.

      The success message includes a string for the newly generated token. Copy this string and store it somewhere safe.

5. In your github repository, go to **Settings > Secrets > Actions**, then click **New Repository Secret**.

   Name your secret **NPM_TOKEN**, and paste the string from the NPM token as its value.

6. Push a change (any change) to the main branch of your GitHub repo and the package will be published.

   That's it, now the package can be installed by anyone using `npm i <package-name>`!

7. Flesh out the `/src` folder of your project with all the functionality you want to expose and push changes to GitHub.

## Develop

Add any functions, components, etc that you want to expose into the library's `index.ts` file, that way they're easy to import.

For example, if you add a `RotatorComponent` component to `index.ts`, you can then import this component into a scene that by writing the following.:

`import { RotatorComponent } from 'my-library'`

Test your library by using it in a new Decentraland scene while you develop it.
Install your npm package into a scene by running `npm i <package-name>`. Then build out a scene that serves for trying out the library's functionality. Try to cover different test cases with your scene, to ensure your library works as expected in every case.

### Fast iterations

If you need to continually make small adjustments to your library and test them, it can get exhausting to have to commit changes and then wait for the npm publication to complete before you can try out the new version in a scene. Fortunately, there's a much faster alternative for running tests with your library.

1. Make sure the library repo has all of its dependencies built, run `npm i` and `npm run build`.
2. On your library's folder run `npm link`.
3. On your test scene folder run `npm link <library name>`, using the name with which your library is exposed on NPM.

This will keep your scene synced to the version of the library that's directly in your local drive. For any changes to the library that you want to test, just run `npm run build` on the library folder, no need to publish changes to GitHub or NPM.

When you're finished testing, remember to unlink the library.

1. On the scene folder run `npm unlink --no-save <library name>`

2. Then in the library run`npm unlink`

> Note: The order of these steps is important.

## Notes on usability

Try your best to make your library easy to use for other creators. Our assumptions always help shape to the tools we make. Often these assumptions appear obvious to us, but others with another context may have completely different assumptions.

- Choose names carefully for everything in your library, including functions, components, and parameters. It's better to have a long name that is self-explanatory than a short one that is a complete mystery.
- Think widely about different possible use cases for your library. Maybe someone uses your library in a smart wearable, maybe someone needs to turn your system on or off at times, maybe someone needs to add multiple instances of your system in the same scene. Not everyone will be facing the same challenges as you.
- That being said, you don't need to support all possible use cases. In fact there's always tradeoffs to make between flexibility vs simplicity of use, creating good tools is all about striking the right balance. Be strategic about where you draw the line for what you chose not to support. It's important to clearly document the limitations you decided to go with, though.
- This brings us to Documentation. Document your library clearly, with examples, descriptions of what each parameter does, comments about what scenarios wouldn't work and what assumptions you're making about the context where it's being used. The library's README.md is often the best place to expose this content.
- Another great tool is to add metadata comments directly into your code. These comments get displayed by the IDE (like VS Studio Code) as users of your library type. You can describe what each function/component is for, describe what each parameter expects to receive, and what a function returns. Thanks to this, users of your library don't need to switch between code and the docs, it's all there in one place! For example, look at this function from the `@dcl/ecs-scene-utils` library:

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

  Users of this library see these hints displayed as they type the `clamp()` function:

  ![]({{ site.baseurl }}/images/media/library-hints.png)

- Always declare types. Don't leave people guessing what object structure they'll have to consume.
- Keep your library light and focused on one functionality. When a Decentraland scene is compiled, all of the code in all of its libraries gets packaged with it, even code that is never called by the scene. For this reason, it's best to avoid creating large bulky libraries. It's better to have lean libraries that let creators only use what they really need.
- Keep an eye on your library's repo, people might make pull requests or report issues.
- Include licensing info on your repo, that way others know if they are free to use your library. The default library includes an open Apache 2 license, feel free to change that if you wish.
