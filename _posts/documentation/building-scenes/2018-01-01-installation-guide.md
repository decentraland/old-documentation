---
date: 2018-01-01
title: Installation guide
description: Setting up the environment
categories:
  - documentation
type: Document
set: building-scenes
set_order: 0
---

To build scenes for Decentraland you will need our CLI tool, it provides compilation, publication and preview commands.

Currently, you can only create Typescript scenes using our SDK, this series of documents will guide you thru the basic concepts of our SDK.

The Decentraland CLI is distributed via [npm](https://www.npmjs.com/get-npm?utm_source=house&utm_medium=homepage&utm_campaign=free%20orgs&utm_term=Install%20npm).

You can install the CLI with:

```bash
npm install -g decentraland
```

Once you finish, you should have the `dcl` command available globally.

> Please make sure that you have the following dependencies installed before beginning your CLI installation
>  * [Node.js](https://github.com/decentraland/cli#nodejs-installation) (version 8)
>  * [IPFS](https://dist.ipfs.io/#go-ipfs)
>  * [Python 2.7.14](https://www.python.org/downloads/)

## Windows installing notes

1. Install [Node.js v8 LTS](https://nodejs.org/en/download/)
2. Find the Command Prompt app and select **Run as Administrator**
3. Install windows-build-tools by running 
`npm install --global --production windows-build-tools`
4. Wait for both the Visual Studio Build Tools and Python installers to both read `Successfully installed xxxx`. Once these have installed successfully, you will be returned to the command prompt.
5. [Download git](https://git-scm.com/download/win) (you'll likely want the 64-bit Windows version)
6. Install git and when prompted choose to install **git bash**
7. When prompted for a default text editor select **Use the Nano editor by default**
8. When prompted to adjust your path environment, select **Use Git** from the Windows Command Prompt
9. When prompted to choose the SSH executable, select **Use OpenSSH**
10. When prompted to choose the HTTPS transport backend, select **Use the OpenSSL library**
11. When prompted to configure the line ending conversions, select **Checkout Windows-style, commit Unix-style line endings**
12. When prompted to configure the terminal emulator to use with Git Bash select **Use MinTTY**
13. On the final installation screen select the following options
  * **Enable file system caching**
  * **Enable Git Credential Manager**
  * **Enable symbolic links**

## Linux installing notes

If you are installing the CLI on a Linux-based operating system, run

```bash
npm i -g --unsafe-perm decentraland
```