---
date: 2018-01-01
title: Installation Guide
description: Step-by-step guide to installing the SDK
redirect_from:
  - /documentation/installation-guide/
categories:
  - getting-started
type: Document
set: getting-started
set_order: 2
---

To build scenes for Decentraland you will need to install the Command Line Interface (CLI).

The CLI allows you to compile and preview your scene in an "off-chain" development environment. After testing your scene locally, you can use the CLI to upload your content to the content server, linking it with your LAND.

**Please note:** Currently, the Decentraland SDK (bundled with the CLI installation) only supports TypeScript.

The Decentraland CLI is distributed via [npm](https://www.npmjs.com/get-npm?utm_source=house&utm_medium=homepage&utm_campaign=free%20orgs&utm_term=Install%20npm).

## Before you Begin

Please install the following dependencies before you install the CLI:

- [Node.js](https://github.com/decentraland/cli#nodejs-installation) (version 8)

## To install the CLI

Open the _Terminal_ app and run the following command:

```bash
npm install -g decentraland
```

Once the installation is complete, the `dcl` command will be globally available.


#### Optional: Install Git

Since Windows machines don't use bash, we recommend that you install git and include git bash. You can otherwise run the CLI commands on the Windows command prompt.

1.  Download [git](https://git-scm.com/download/win) (you'll likely want the 64-bit Windows version):
2.  When prompted choose to install **git bash**
3.  When prompted for a default text editor select **Use the Nano editor by default**
4.  When prompted to adjust your path environment, select **Use Git from the Windows Command Prompt**
5.  When prompted to choose the SSH executable, select **Use OpenSSH**
6.  When prompted to choose the HTTPS transport backend, select **Use the OpenSSL library**
7.  When prompted to configure the line ending conversions, select **Checkout Windows-style, commit Unix-style line endings**
8.  When prompted to configure the terminal emulator to use with Git Bash select **Use MinTTY**
9.  On the final installation screen select the following options
    - **Enable file system caching**
    - **Enable Git Credential Manager**
    - **Enable symbolic links**

## Update the CLI on any platform

To update the CLI to the latest supported version, we recommend first uninstalling the CLI and then reinstalling a fresh version. To do this, run the following commands:

```bash
// uninstall
npm rm decentraland -g

// install
npm install -g decentraland
```

## Update the SDK version of a scene

If your CLI is up to date, the new projects you create with it will use the latest version of the SDK.

The SDK version used by your existing projects doesn't change by updating the CLI. You need to manually update the SDK version in the projects.

> Note: Checking the SDK version you have installed using `npm` won't tell you what version of the SDK is being used when previewing a specific scene.

To update the version of the Decentraland SDK used by a project:

1.  Open the file `package.json` in the project folder.
2.  In this file, look for the field `decentraland-ecs`:

    * If the value is `latest`, keep it.
    * If the version points to a number or a build that isn't the latest version of the SDK, change it to `latest`.
    <!--
    * If your project is a [static XML scene]({{ site.baseurl }}{% post_url /development-guide/2018-01-13-xml-static-scenes %}) then you won't find this field. Instead, set the field `decentraland-api` to `latest`.
    -->
    * If you can't find the field `decentraland-ecs`, but do find the field `decentraland-api`, then your project is written with a deprecated version that's older than `5.0`. Create a new project with the CLI and [migrate the content manually](https://decentraland.org/blog/tutorials/sdk-migration/) to it.

3. Delete the file `package-lock.json` and the folder `node-modules` from the project.
4. Run the scene preview with `dcl start`. All the dependencies should be automatically reinstalled, according to the versions listed in `package.json`.



