---
date: 2018-06-12
title: Scene content
description: Learn how to import 3D models to use in a scene
redirect_from:
  - /sdk-reference/scene-content-guide/
categories:
  - development-guide
type: Document
set: development-guide
set_order: 2
tag: introduction
---

Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an _entity_, and each entity can include _components_ that shape its characteristics and functionality.

Entities can be nested inside others to create a tree structure. In fact, all scenes must output a tree of nested entities. _.xml_ scenes explicitly define this tree, _.xlt_ scenes define typescript code that builds and updates this tree.

This document covers how to achieve common objectives by using different types of entities and components in a scene's tree.

## Create simple geometric shapes

Several basic shapes, often called _primitives_, can be added to a scene as predefined entity types. These already have certain components defined (like their shape) and let you set others (like their rotation and color).

The following types of entities are available:

- `<Box />`
- `<Sphere />`
- `<Plane />`
- `<Cylinder />`
- `<Cone />`

Any of these can be added to your scene, they can all include basic components like position, scale or color.

```tsx
<box position={vector} color="#ff00aa" scale={2} />
```

See [Entity interfaces]({{ site.baseurl }}{% post_url /development-guide/2018-06-21-entity-interfaces %}) for more details on these types of entities.

> Tip: When editing the code via a source code editor (like Visual Studio Code), you can see the list of components supported by a type of entity. Typically, this is done by placing the cursor in the entity and typing _Ctrl + Space bar_.

## Text blocks

You can add text as an entity in a Decentraland scene. You can use these text entities as labels in your scene, display them momentarily as error messages, or whatever you wish.

{% raw %}

```tsx
<text
  value="Users will see this text floating in space in your scene."
  hAlign="left"
  position={{ x: 5, y: 1, z: 5 }}
/>
```

{% endraw %}

To display a value that isn't of type _string_ in a text entity, use the `toString()` function to convert its type to _string_.

{% raw %}

```tsx
<text value={this.state.gameScore.toString()} />
```

{% endraw %}

## Color

Color is set in hexadecimal values. To set an entity's color, simply set its `color` to the corresponding hexadecimal value.

{% raw %}

```tsx
<sphere position={{ x: 0.5, y: 1, z: 0 }} color="#EF2D5E" />
```

{% endraw %}

> Tip: There are many online color-pickers you can use to find a specific color graphically. To name one, you can try the color picker on [W 3 Schools](https://www.w3schools.com/colors/colors_picker.asp).

## Materials

Materials are defined as separate entities in a scene, this prevents material definitions from being duplicated when multiple entities use them, keeping the scene's code lighter.

Materials can be applied to primitive entities and to planes, simply by setting the `material`.

{% raw %}

```tsx
<material
  id="reusable_material"
  albedoTexture="materials/wood.png"
  roughness={0.5}
/>
<sphere material="#reusable_material" />
```

{% endraw %}

In the example above, the image for the material is located in a `materials` folder, which is located at root level of the scene project folder.

When an entity uses a material, you must refer to it prepending a `#` to the material's id. So if the material's id is `reusable_material`, you must set the `material` on an entity to `#reusable_material`.

Materials are also implicitly imported into a scene when you import a glTF model that includes embedded materials. When that's the case, you don't need to declare a `<material />` entity.

Not all shaders are supported by the Decentraland engine. For example, all blender render materials should be supported, in Cycles render only PBR (physically based rendering) materials are supported.

See [entity interfaces]({{ site.baseurl }}{% post_url /development-guide/2018-06-21-entity-interfaces %}) for a full list of all the properties that can be configured in a material. Keep in mind that all materials and textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}).

#### Texture mapping

An entity that uses a material can be configured to map specific regions of the texture to its faces.

Use the [Decentraland sprite helpers](https://github.com/decentraland/dcl-sprites) library to map textures easily. Read documentation on how to use this library in the provided link.

To handle texture mapping manually, you set _u_ and _v_ coordinates on the 2D image of the texture to correspond to the vertices of the entity. The more vertices the entity has, the more _uv_ coordinates need to be defined on the texture, a plane for example needs to have 8 _uv_ points defined, 4 for each of its two faces.

{% raw %}

```tsx
async render() {
  return (
    <scene position={{ x: 5, y: 1.5, z: 5 }}>
      <basic-material
        id="sprite001"
        texture="materials/atlas.png"
        samplingMode={DCL.TextureSamplingMode.NEAREST}
      />
      <plane
        material="#sprite001"
        uvs={[
          0,
          0.75,
          0.25,
          0.75,
          0.25,
          1,
          0,
          1,
          0,
          0.75,
          0.25,
          0.75,
          0.25,
          1,
          0,
          1
        ]}
      />
    </scene>
  )
}
```

{% endraw %}

To create an animated sprite, use texture mapping to change the selected regions of a same texture that holds all the frames.

#### Transparent materials

To make a material transparent, you must add an alpha channel to the image you use for the texture. The _material_ entity ignores the alpha channel of the texture image by default, so you must either:

- Set `hasAlpha` to true.
- Set an image in `alphaTexture`, which can be the same or a different image.

{% raw %}

```tsx
<material
  albedoTexture="materials/semiTransparentTexture.png"
  hasAlpha
/>
// or
<material
  albedoTexture="materials/semiTransparentTexture.png"
  alphaTexture="materials/semiTransparentTexture.png"
/>
```

{% endraw %}

#### Basic materials

Instead of the _material_ entity, you can define a material through the _basic-material_ entity. This creates materials that are shadeless and are not affected by light. This is useful for creating user interfaces that should be consistently bright, it can also be used to give your scene a more minimalist look.

{% raw %}

```tsx
<basic-material
  id="basic_material"
  texture="materials/profile_avatar.png"
/>
<sphere
  material="#basic_material"
/>
```

{% endraw %}

When textures are stretched or shrinked to a different size from the original texture image, this can sometimes create artifacts. There are various [texture filtering](https://en.wikipedia.org/wiki/Texture_filtering) algorithms that exist to compensate for this in different ways. The _basic material_ entity uses the _bilinear_ algorithm by default, but you can configure it to use the _nearest neighbor_ or _trilinear_ algorithms instead by setting the `samplingMode`.

{% raw %}

```tsx
<basic-material
  id="basic_material"
  texture="materials/profile_avatar.png"
  samplingMode={DCL.TextureSamplingMode.NEAREST}
/>
```

{% endraw %}

The example above uses a nearest neighbor algorithm. This setting is ideal for pixel art style graphics, as the contours will remain sharply marked as the texture is seen larger on screen instead of being blurred.

## Import 3D models

For more complex shapes, you can build a 3D model in an external tool like Blender and then import them in _glTF_ format. [glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common, extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

To add an external model into a scene, add a _gltf-model_ element and set its `src` to the path of the glTF file containing the model.

{% raw %}

```tsx
<gltf-model
  position={{ x: 5, y: 3, z: 5 }}
  scale={0.5}
  src="models/myModel.gltf"
/>
```

{% endraw %}

In the example above, the model is located in a `models` folder, which is located at root level of the scene project folder.

> Tip: We recommend keeping your models separate in a `/models` folder inside your scene.

glTF models can also include their own textures, materials, colliders and animations. See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for more information on this.

Keep in mind that all models, their shaders and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}).

> Note: obj models are also supported as a legacy feature, but will likely not be supported for much longer. To add one, use an `<obj-model>` entity.

#### Animations

Files with .gltf extensions can be opened with a text editor to view their contents. There you can find the list of animations included in the model and how they're named. Typically, an animation name is comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for information on how to create animations for a 3D model before importing it to a Decentraland scene.

You handle animations to a _gltf-model_ entity by adding _skeletalAnimation_ settings to it. This setting receives an array of JSON entries, where each entry handles one of the animations in the model. For an animation to be activated, you must set the `playing` property of a clip to _true_.

The example below imports a model that includes animations and configures them.

{% raw %}

```tsx
<gltf-model
  position={{ x: 5, y: 3, z: 5 }}
  scale={0.5}
  src="models/shark_anim.gltf"
  skeletalAnimation={[
    {
      clip: "shark_bite",
      weight: 0.8,
      playing: false
    },
    {
      clip: "shark_swim",
      weight: 0.2,
      playing: true
    }
  ]}
/>
```

{% endraw %}

In this example, the armature is named _shark_ and the two animations contained in it are named _bite_ and _swim_.

An animation can be set to loop continuously by setting its `loop` property. If `loop:false` then the animation will be called only once when activated.

The `weight` property allows a single model to carry out multiple animations at once, calculating a weighted average of all the movements involved in the animation. The value of `weight` determines how much importance the animation will be given in the average.

The `weight` value of all active animations should add up to 1 at all times. If it adds up to less than 1, the weighted average will be referencing the default position of the armature for the remaining part of the calculation.

For example, in the code example above, if only _shark_swim_ is active with a `weight` of 0.2, then the swimming movements are quite subtle, only 20% of what the animation says it should move. The other 80% of what's averaged represents the default position of the armature.

The `weight` property can be used in interesting ways, for example the `weight` property of _shark_swim_ could be set in proportion to how fast the shark is swimming, so you don't need to create multiple animations for fast and slow swimming. You could also change the `weight` value gradually when starting and stopping the animation to give it a more natural transition and avoid jumps from one pose to another.

#### Free libraries for 3D models

Instead of building your own 3d models, you can also download them from several free or paid libraries.

To get you started, below is a list of libraries that have free or relatively inexpensive content:

- [Google Poly](https://poly.google.com)
- [SketchFab](https://sketchfab.com/)
- [Clara.io](https://clara.io/)
- [Archive3D](https://archive3d.net/)
- [SketchUp 3D Warehouse](https://3dwarehouse.sketchup.com/)
- [Thingiverse](https://www.thingiverse.com/) (3D models made primarily for 3D printing, but adaptable to Virtual Worlds)
- [ShareCG](https://www.sharecg.com/)

> Note: Pay attention to the licence restrictions that the content you download has.

Note that most of the models that you can download from these sites won't be in glTF. If that's the case, you must convert them to glTF before you can use them in a scene. We recommend importing them into Blender and exporting them with one of the available glTF export add-ons.

## Sound

You can add sound to your scene by including a sound component in any entity.

{% raw %}

```tsx
<sphere
  position={{ x: 5, y: 3, z: 5 }}
  sound={{
    src: "sounds/carnivalRides.ogg",
    loop: true,
    playing: true,
    volume: 0.5
  }}
/>
```

{% endraw %}

The `src` property points to the location of the sound file.

In the example above, the audio file is located in a `sounds` folder, which is located at root level of the scene project folder.

> Tip: We recommend keeping your sound files separate in a `/sounds` folder inside your scene.

Supported sound formats vary depending on the browser, but it's safe to use _.mp3_, _.accc_ and _.ogg_.

_.wav_ files are also supported but not generally recommended as they are significantly larger.

Each entity can only play a single sound file. This limitation can easily be overcome by including multiple invisible entities, each with their own sound file.

The `distanceModel` property of the sound component conditions how the user's distance to the sound's source affects its volume. The model can be _linear_, _exponential_ or _inverse_. When using the linear or exponential model, you can also set the `rolloffFactor` property to set the steepness of the curve.

<!---

Setting loop to false stops the audio, it doesn't pause it. So when setting loop to true the audio will start from the beginning.

Setting playing to false pauses??????

same for video??

-->

## Video

You can add video to your scene by including a _video_ entity.

{% raw %}

```tsx
<video
  id="myVideo"
  position={{ x: 2, y: 3, z: 1 }}
  width={4}
  height={2.5}
  volume={currentVolume}
  src="video/myVideo.mp4"
  play={true}
/>
```

{% endraw %}

The _video_ entity needs to have a video selected in `src`, this can either be a local file or a url pointing to a remote video for streaming.

In the example above, the video is located in a `video` folder, which is located at root level of the scene project folder.

Supported video formats vary depending on the browser, but it's safe to use _.mp4_ and _.avi_.

With `volume` you set the volume from 0 to 100.

## Entity collision

Entities that have collisions enabled occupy space and block a user's path, objects without collisions can be walked through by a user`s avatar.

{% raw %}

```tsx
<box position={{ x: 10, y: 0, z: 0 }} scale={2} withCollisions={true} />
```

{% endraw %}

The example above defines a box entity that can't be walked through.

All entities have collisions disabled by default. Depending on the type of entity, collisions are enabled as follows:

- For most entities, including _primitives_ (boxes, spheres, etc), planes and base entities, you enable collisions by setting the `withCollisions` component to _true_.

      > Note: Plane entities only block in one direction.

- To enable collisions in _glTF models_, you can either:

  - Overlay an invisible entity with the `withCollisions` component set to _true_.
  - Edit the model in an external tool like Blender to include a _collider object_. The collider must be named _x_collider_, where _x_ is the name of the model. So for a model named _house_, the collider must be named _house_collider_.

A _collider_ is a set of geometric shapes or planes that define which parts of the model are collided with. This allows for much greater control and is a lot less demanding on the system, as the collision object is usually a lot simpler (with less vertices) than the original model.

See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for more details on how to add colliders to a 3D model.

Collision settings currently don't affect how other entities interact with each other, entities can always overlap. Collision settings only affect how the entity interacts with the user's avatar.

Decentraland currently doesn't have a physics engine, so if you want entities to fall, crash or bounce, you must code this behavior into the scene.

> Tip: To view the limits of all collider meshes in the scene, launch your scene preview with `dcl start` and then click `c`. This draws blue lines that delimit all colliders in place.
