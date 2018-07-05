---
date: 2018-01-01
title: Creating your first scene
description: Learn the basics of Decentraland scenes
categories:
  - documentation
type: Document
set: building-scenes
set_order: 2
tag: introduction
---


## Before you begin
## 开始之前

Please make sure you first install the CLI tools. In Mac OS, you do this by running the following command:

请确保首先安装 CLI 工具。在 Mac OS 中，您可以通过运行以下命令来执行此操作：

```bash
npm install -g decentraland
```

See the [Installation Guide]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-01-installation-guide %}) for more details and specific instructions for Windows and Linux systems.

针对 Windows 和 Linux 系统的更多详细信息和特定说明，请参阅[安装指南]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-01-installation-guide %})。

## Kinds of scenes

## 场景类别

In Decentraland, a scene is the representation of the content of in an estate/LAND. All scenes are made up of [entities]({{ site.baseurl }}{% post_url /sdk-reference/2018-06-21-entity-interfaces %}), which represent all of the elements in the scene and are arranged into tree structures, very much like elements in a DOM tree in web development.

在 Decentraland 中，场景就是是 LAND 土地上的内容。所有场景都是由 [entities]({{ site.baseurl }}{% post_url /sdk-reference/2018-06-21-entity-interfaces %}) 组成，构成场景中的所有元素并以树结构组织，非常类似于 Web 开发中 DOM 树中的元素。


There are essentially two different types of scenes:

基本上有两种不同类型的场景：

* **Static scenes**: An [XML](https://en.wikipedia.org/wiki/XML) file describes static objects in the scene.
* **Dynamic scenes**: A [TypeScript (TSX)](https://www.typescriptlang.org/docs/handbook/jsx.html) file, with a `.tsx` extension, that has dynamic content. Through these you can create, move and mutate the entities in the scene.

* **静态场景**：一个 [XML](https://en.wikipedia.org/wiki/XML) 文件用于描述场景中的静态对象。

* **动态场景**：[TypeScript (TSX)](https://www.typescriptlang.org/docs/handbook/jsx.html) 文件，扩展名为.tsx`，具有动态内容。通过这些，您可以创建、移动和改变场景中的实体。


## Creating the file structure

##创建文件结构

Use our CLI tool to automatically build the initial boilerplate scene. To do so, run `dcl init` in an empty folder. See [SDK Overview]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-01-SDK-Overview %}) for details on how to install and use the CLI.

使用我们的CLI工具自动构建初始样板场景。为此，请在空文件夹中运行`dcl init`。有关如何安装和使用CLI的详细信息，请参阅[SDK概述]（{{site.baseurl}} {％post_url / sdk-reference / 2018-01-01-SDK-Overview％}）。

The `dcl init` command creates a Decentraland **project** in your current working directory containing a **scene**. It prompts you to select a scene type (static, dynamic & singleplayer, or dynamic & multiplayer) and builds a different file structure depending on the case.

`dcl init`命令在当前工作目录中创建一个包含**场景**的Decentraland **项目**。它会提示您选择场景类型（静态，动态和单人，或动态和多人），并根据具体情况构建不同的文件结构。

*A static scene* includes the following files:

*静态场景*包括以下文件：

1.  `scene.json`: The manifest that contains metadata for the scene.
2.  `scene.xml`: The content of the static scene.

1.`post.json`：包含场景元数据的清单。
2.`scene.xml`：静态场景的内容。

*A dynamic scene* incldes the following files:
*动态场景*包括以下文件：

1.  `scene.json`: The manifest that contains metadata for the scene.
2.  `build.json`: The file with the instructions to build the scene.
3.  `tsconfig.json`: Typescript configuration file.
4.  `scene.tsx`: The entry point of the scene.

1.`post.json`：包含场景元数据的清单。
2.`build.json`：包含构建场景的指令的文件。
3.`tsconfig.json`：Typescript配置文件。
4.“scene.tsx`：场景的入口点。



The `dcl init` command also prompts you to enter some descriptive metadata, these datais are stored in
the [scene.json](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki) manifest file for the scene. All of this
metadata is optional for building a scene locally, except for scene type.

`dcl init`命令还会提示您输入一些描述性元数据，这些数据存储在其中
清单文件。所有这些
元数据是可选的，用于在本地构建场景，场景类型除外。


> If you run `dcl init` in a folder containing other Decentraland projects, any existing files with duplicate names will be overwritten with the new, initialized project files.

>如果在包含其他Decentraland项目的文件夹中运行`dcl init`，则任何具有重复名称的现有文件都将被新的初始化项目文件覆盖。

## scene.xml (static scenes)
## scene.xml（静态场景）

For both static and dynamic scenes, the end result is the same: a tree of entities. The root of the tree is always a `<scene>` element. XML scenes call out this structure explicitly, Type Script scenes provide the script to build and update this structure.  

对于静态和动态场景，最终结果是相同的：实体树。树的根始终是一个`<scene>`元素。 XML场景显式调用此结构，类型脚本场景提供用于构建和更新此结构的脚本。


```xml
<scene>
  <sphere position="1 1 1"></sphere>
  <box position="3.789 2.3 4.065" scale="1 10 1"></box>
  <box position="2.212 7.141 4.089" scale="2.5 0.2 1"></box>
  <gitf-model src="crate/crate.gitf" position="5 1 5"></box>
</scene>
```

Since the root scene element is a transform node, it can also be translated, scaled and rotated. Those capabilities are useful to, for example, change the center of coordinates of the entire parcel:

由于根场景元素是变换节点，因此它也可以被平移，缩放和旋转。例如，这些功能对于更改整个宗地的坐标中心非常有用：

```xml
<scene position="5 5 5">
  <box position="0 0 0"></box>
  <!-- in this example, the box is located at the world position 5 5 5 -->
</scene>
```

## scene.tsx (dynamic scenes)

## scene.tsx（动态场景）

This file contains the code that generates an entity tree, which is what end users of your parsel will see. Below is a basic example of a `scene.tsx` file:

此文件包含生成实体树的代码，这是您的parsel的最终用户将看到的内容。下面是`scene.tsx`文件的基本示例：

```tsx
import { ScriptableScene, createElement } from "metaverse-api";

// The ScriptableScene class is a React-style component.
export default class MyScene extends ScriptableScene<any, any> {
  async render() {
    return (
      <scene>
        <box position={ { x: 5, y: 0, z: 5 } } scale={ { x: 1, y: 1, z: 1 } } />
      </scene>
    );
  }
}
```

> **Important note:** Your `scene.tsx` must always include an `export default class`, that's how our SDK finds the class to initialize the scene.

> **重要说明：**您的`scene.tsx`必须始终包含`export default class`，这就是我们的SDK如何找到初始化场景的类。


## scene.json

The `scene.json` file is a JSON formatted manifest for a scene in the world. A scene can span a single or multiple LAND parcels. The `scene.json` manifest describes what objects exist in the scene, a list of any assets needed to render it, contact information for the parcel owner, and security settings. For more information and an example of a
`scene.json` file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

`scene.json`文件是世界上场景的JSON格式清单。场景可以跨越单个或多个LAND宗地。 `scene.json`清单描述了场景中存在的对象，渲染它所需的任何资产的列表，宗地所有者的联系信息以及安全设置。有关更多信息和示例
`scene.json` file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

`scene.json`文件，请访问[Decentraland规范提案]（https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki）。

## package.json

This file provides information to NPM that allows it to identify the project, as well as handle the project's dependencies. Decentraland scenes need two packages:

此文件向NPM提供信息，使其能够识别项目，以及处理项目的依赖项。 Decentraland场景需要两个包：

* `metaverse-api`, which allows the scene to communicate with the world engine.
* `typescript`, to compile the file `scene.tsx` to javascript.

*`metaverse-api`，它允许场景与世界引擎进行通信。
*`typescript`，将文件`scene.tsx`编译为javascript。

> You don’t need the `typescript` package when creating static scenes. This is only required when you are building remote and interactive scenes.

>创建静态场景时不需要`typescript`包。只有在构建远程和交互式场景时才需要这样做。

## build.json

This is the Decentraland build configuration file.
这是Decentraland构建配置文件。

We provide a tool called `metaverse-compiler`, it comes with the `metaverse-api` package. This tool is in charge of
reading the `build.json` file and compile your scene in a way that the client can run it. The only thing it really does is to bundle Typescript code into a WebWorker using WebPack.

我们提供了一个名为`metaverse-compiler`的工具，它带有`metaverse-api`包。这个工具负责
读取`build.json`文件并以客户端可以运行它的方式编译场景。它唯一真正做的是使用WebPack将Typescript代码捆绑到WebWorker中。

> You can also use the CLI to create Node.js servers for multiplayer experiences.

>您还可以使用CLI为多人游戏体验创建Node.js服务器。

## tsconfig.json

Directories containing a `tsconfig.json` file are root directories for TypeScript Projects. The `tsconfig.json` file specifies the root files and options required to compile your project in JavaScript.

包含`tsconfig.json`文件的目录是TypeScript Projects的根目录。 `tsconfig.json`文件指定在JavaScript中编译项目所需的根文件和选项。

> You can use another tool or language instead of TypeScript, so long as your scripts are contained within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

>只要脚本包含在单个Javascript文件（scene.js）中，您就可以使用其他工具或语言而不是TypeScript。所有提供的类型声明都是在TypeScript中生成的，并且其他语言和转换器不受官方支持。


## Preview your scene

##预览你的场景

To preview your rendered scene locally (without uploading it to IPFS) run the following command on the scene's main folder:

要在本地预览渲染的场景（不将其上传到IPFS），请在场景的主文件夹上运行以下命令：

```bash
dcl preview
```
Note that the preview command runs only on your local system, it creates a web server and opens a new web browser tab pointing at its local address.

请注意，预览命令仅在本地系统上运行，它会创建一个Web服务器并打开一个指向其本地地址的新Web浏览器选项卡。


Every time you make changes to the scene, the preview reloads and updates automatically, so there's no need to run the command again.

每次对场景进行更改时，预览都会自动重新加载和更新，因此无需再次运行该命令。

Running a preview also provides some useful debugging information and tools to help you understand how different entities are rendered. The preview mode provides information that describes parcel boundaries, the environment and resources, for example the number of entities being rendered, the current FPS rate, user position, and whether or not different elements are exceeding parcel boundaries.

运行预览还提供了一些有用的调试信息和工具，可帮助您了解不同实体的呈现方式。预览模式提供描述宗地边界，环境和资源的信息，例如，正在渲染的实体数量，当前FPS速率，用户位置以及不同元素是否超出宗地边界。


You can add the following flags to the command:

您可以将以下标志添加到命令：

* `--no-browser` to prevent the preview from opening a new browser tab.
* `--port` to assign a specific to run the scene. Otherwise it will use whatever port is available.
* `--skip` to skip the confirmation prompt.

*`--no-browser`以防止预览打开新的浏览器选项卡。
*`--port`指定一个特定的运行场景。否则它将使用任何可用的端口。
*`--skip`跳过确认提示。


> To preview old scenes that were built for older versions of the SDK, you must install the latest versions of the `metaverse-api` and `metaverse-rpc` packages in your project. Check the CLI version via the command `dcl -v`

>要预览为旧版本SDK构建的旧场景，必须在项目中安装最新版本的`metaverse-api`和`metaverse-rpc`包。通过命令`dcl -v`检查CLI版本


## Edit your scene

##编辑你的场景

To edit a scene, we recommend using an IDE like [Visual Studio Code](https://code.visualstudio.com/). An IDE helps you create scenes a lot faster and with less errors, as it marks errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in.

要编辑场景，我们建议使用类似[Visual Studio Code]（https://code.visualstudio.com/）的IDE。 IDE可以帮助您更快地创建场景并减少错误，因为它可以标记错误，在您编写时自动完成，甚至可以显示依赖于您所处的上下文的智能建议。

See [scene content guide]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) for simple instructions about adding content to your scene.

有关向场景添加内容的简单说明，请参阅[场景内容指南]

Once you're done creating the scene and want to upload it to your LAND, see [publishing]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-07-publishing %}).

完成创建场景并想要将其上传到LAND后，请参阅[发布]（{{site.baseurl}} {％post_url / documentation / building-scenes / 2018-01-07-publishing％}）。
