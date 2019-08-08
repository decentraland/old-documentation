
# Let’s build the metaverse together

### The Decentraland SDK provides everything you need to build interactive 3D content for Decentraland.

## Shortcuts

<div class="shortcuts">
  <a href="{{ site.baseurl }}{% post_url /getting-started/2018-01-02-coding-scenes %}">
    <div>
      <div class="image"><img src="/images/home/1.png"/></div>
      <div class="title">Coding scenes</div>
      <div class="description">An overview of the tools and the essential concepts surrounding the SDK.</div>
    </div>
  </a>
  <a href="https://github.com/decentraland/ecs-reference">
    <div>
      <div class="image"><img src="/images/home/2.png"/></div>
      <div class="title">Component and object reference</div>
      <div class="description">A complete reference of the default components and other available objects, with their functions.</div>
    </div>
  </a>
  <a href="{{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}">
    <div>
      <div class="image"><img src="/images/home/3.png"/></div>
      <div class="title">Scene examples</div>
      <div class="description">Several code examples to get you started, and inspire your creations.</div>
    </div>
  </a>
</div>

## Install the CLI

To get started, install the Command Line Interface (CLI).

The CLI allows you to compile and preview your scene locally. After testing your scene locally, you can use the CLI to upload your content.

> **Note**: Install the following dependencies before you install the CLI:
>
> - [Node.js](https://www.npmjs.com/) (version 8 or later)

To install the CLI, run the following command in your command line tool of choice:

```bash
npm install -g decentraland
```

Read [Installation guide]({{ site.baseurl }}{% post_url /getting-started/2018-01-01-installation-guide %}) for more details about installing the CLI.

## Create your first scene

Create a new scene by running the following code in an empty folder:

```bash
dcl init
```

Preview the 3D scene in your browser by running the following command in that same folder:

```bash
dcl start
```

Read more about the scene preview in [preview a scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-04-preview-scene %})

## Edit the scene

Open the `src/game.ts` file from your scene folder with the source code editor of your choice.

> Tip: We recommend using a source code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/). An editor like this helps you by marking syntax errors, autocompleting while you write and even showing smart suggestions that depend on context. Also click on an object to see the full definition of its class.

```ts
/// --- Set up a system ---

class RotatorSystem {
  // this group will contain every entity that has a Transform component
  group = engine.getComponentGroup(Transform)

  update(dt: number) {
    // iterate over the entities of the group
    for (let entity of this.group.entities) {
      // get the Transform component of the entity
      const transform = entity.getComponent(Transform)

      // mutate the rotation
      transform.rotate(Vector3.Up(), dt * 10) 
    }
  }
}

// Add a new instance of the system to the engine
engine.addSystem(new RotatorSystem())

/// --- Spawner function ---

function spawnCube(x: number, y: number, z: number) {
  // create the entity
  const cube = new Entity()

  // set a transform to the entity
  cube.addComponent(new Transform({ position: new Vector3(x, y, z) }))

  // set a shape to the entity
  cube.addComponent(new BoxShape())

  // add the entity to the engine
  engine.addEntity(cube)

  return cube
}

/// --- Spawn a cube ---

const cube = spawnCube(5, 1, 5)

cube.addComponent(
  new OnClick(() => {
    cube.getComponent(Transform).scale.z *= 1.1
    cube.getComponent(Transform).scale.x *= 0.9

    spawnCube(Math.random() * 8 + 1, Math.random() * 8, Math.random() * 8 + 1)
  })
)
```


Change anything you want from this code, for example change the _x_ position of the first `cube` entity that's spawned. If you kept the preview running in a browser tab, you should now see the changes show in the preview.

Download this 3D model of an avocado from [Google Poly](https://poly.google.com) in _glTF_ format. [link](https://poly.google.com/view/cgLBGFfm5FU)

![](/images/media/landing_avocado_gltf.png)

Create a new folder under your scene’s directory named `/models`. Extract the downloaded files and place them all in that folder.

At the end of your scene’s code, add the following lines:


```ts
let avocado = new Entity()
avocado.addComponent(new GLTFShape("models/avocado.gltf"))
avocado.addComponent(new Transform({ 
    position: new Vector3(3, 1, 3), 
    scale: new Vector3(10, 10, 10)
    }))
engine.addEntity(avocado)
```

Check your scene preview once again to see that the 3D model is now there too.

![](/images/media/landing_avocado_in_scene.png)

The lines you just added create a new [entity]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %}), give it a [shape]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}) based on the 3D model you downloaded, and [set its position and scale]({{ site.baseurl }}{% post_url /development-guide/2018-01-12-entity-positioning %}).

Note that the avocado you added rotates, just like all other entities in the scene. That's because the `RotatorSystem` [system]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) that was defined in the default code of this scene is iterating over every entity in the scene and rotating it. 

Read [coding-scenes]({{ site.baseurl }}{% post_url /getting-started/2018-01-02-coding-scenes %}) for a high-level understanding of how Decentraland scenes function.

See the **Development guide** section for more instructions about adding content to your scene.

## Publish your scene

Once you're done creating the scene and want to upload it to your LAND, see [publishing]({{ site.baseurl }}{% post_url /deploy/2018-01-07-publishing %}).

## Scene examples

<div class="examples">
  <a target="_blank" href="https://github.com/decentraland-scenes/Hypno-wheels">
    <div>
      <img src="/images/home/example-hypno-wheel.png"/>
      <span>Hypno wheels</span>
    </div>
  </a>
  <a target="_blank" href="https://github.com/decentraland-scenes/Hummingbirds">
    <div>
      <img src="/images/home/hummingbirds.png"/>
      <span>Hummingbirds</span>
    </div>
  </a>
  <a target="_blank" href="https://github.com/decentraland-scenes/Gnark-patrol">
    <div>
      <img src="/images/home/example-gnark.png"/>
      <span>Gnark patrolling</span>
    </div>
  </a>
</div>

See [scene examples]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}) for more scene examples.

Also see [tutorials]({{ site.baseurl }}{% post_url /tutorials/2018-01-03-tutorials %}) for detailed instructions for building scenes like these.

## Other useful information

- [Design constraints for games]({{ site.baseurl }}{% post_url /design-experience/2018-01-08-design-games %})
- [3D model considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %})
- [Scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %})
