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

To update the CLI to the latest supported version, run the following command:

```bash
npm update -g decentraland
```

## Update the SDK version of a scene

By updating the CLI, the new scenes you create with it will use the latest version of the SDK. Projects that you created before you updated the CLI will keep using the original version of the SDK that they had when you created them. The only way to change this is to manually update the SDK version in the scene.

> Note: To migrate from versions that are older than 5.0 to 5.0 or newer, you're going to have to create a new scene project and migrate content manually.

To update the version of the Decentraland SDK:

1.  Open the file _package-lock.json_ in the scene folder.
2.  Look for the version of _decentraland-ecs being used and manually change it to the latest version of the SDK.

> Tip: If you're not sure what's the latest version, check the release notes.

> Note: Checking the SDK version you have installed using `npm` won't tell you what version of the SDK is being used when previewing a specific scene. The only way to know what version they are using is by checking _package-lock.json_.
