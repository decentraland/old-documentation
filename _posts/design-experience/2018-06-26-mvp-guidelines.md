---
date: 2018-01-06
title: Scene MVP Guidelines
description: Recommended guidelines for producing your first MVP scene or experience using the SDK
redirect_from:
  - /documentation/mvp-guidelines/
categories:
  - design-experience
type: Document
---

The purpose of this document is to help guide you through the process of building the first iterations of scenes in Decentraland. We’ll refer to these as a Minimum Viable Product (MVP).

**When creating the Minimum Viable Product (MVP) for your scene, you need to think about two areas of focus:**

1.  The basic user experience and functionality of your project.
2.  The creation of a basic "pipeline", or team workflow and content management system for building your experience and iteratively improving it.

An MVP should not try to demonstrate every possible outcome of every possible experience. Instead, an MVP should be the best first impression of your experience that you can make using Decentraland’s SDK.

It is important to consider your own limitations, how you plan to provide content to your users, and the expectations of your users. Approaching your MVP in this way requires three different perspectives:

1.  As a developer or producer, how do I deliver an experience to my user/player?
2.  As a user or player, what do I expect from this experience?
3.  As a contributor or stakeholder, how do I contribute to the pipeline or experience?

It's important to distinguish this approach from traditional agile development, because you may have to use non-optimum methods to meet your design goals.

You will have to examine your own goals in the context of your users’ expectations to decide if a certain release is focused more on the player, the pipeline and content contributors, or little of both.

When planning each release, it is critical that you conscientiously and deliberately set your priorities according to each of these three perspectives.

You can expect your development backlog to follow two tracks:

- The backlog of user experiences you want to create.
- The development of the tools and interfaces needed to build your delivery pipeline. (Or to optimize your existing pipeline for contributors as well as your development team.)

These two tracks will also follow two different approaches to testing:

- Testing your user experiences is more akin to traditional user interface testing, and does not require the same scripting resources.
- Testing your tools and pipeline interfaces will require more technical resources.

The sooner you can get a value proposition in front of your user or player, the sooner you can get feedback to either confirm or reject that proposition. Confirming value quickly is critical. Many experienced developers will share stories of how they were certain beyond a shadow of a doubt of how amazing a new mechanic would be until they used it and it felt awkward and glitchy, the players didn’t respond to it at all, or it didn’t solve a consumer want/need. You want to fail quickly with as little effort as possible, so that you can learn from your failure and plan the next iteration.

How do you fail quickly? You do the minimum needed to get your player to touch your product.

<!--
For example, let’s say that you’ve determined your players want to ride unicorns, so you spend months developing a pipeline to create blue unicorns and only blue unicorns. Then you give your blue unicorns to your players, only to find out that they despise blue unicorns and want only purple unicorns. You’ve wasted months of effort, and now you have to create a new pipeline to deliver your users the experience they want.

However, if you gave the minimum viable blue unicorn to your players as quickly as possible, with a pipeline you could modify, then you would quickly learn that they want purple unicorns. Putting forward the minimum amount of effort needed to poll your users allows you meet their needs faster, without wasting effort and resources.
-->

## Factors for Minimum Viable Products

Here is the list of factors to consider for your basic MVP. It is acceptable to state that you will use something as a placeholder and will then phase it out as you develop a more solid replacement.

1.  Art Creation

    - First, begin with basic still images
    - Your first test should be for style: does the style you’ve chosen appeal to your users?
    - This could be the start of a style guide to provide to an outsourced artist

2.  Scene Creation

    - Develop a basic sense of your space
    - Player should feel they are in a new, unique space
    - Delineate your space from neighboring spaces
    - Borders are evident and obvious – if only by a drawn line
    - Cover entire area with static content/art

3.  Art Rendered in Scene

    - Using billboards is ok or other signage (this could simply be actual billboards or more sophisticated camera facing sprites)
    - Establish the tone and aesthetics of your space (i.e. style, bright, dark)
    - Note your process: how was art created and deployed into the scene?
    - How do you want to organize your art files for repeated deployment?

4.  Player experience

    - Players are able to visit your space/scene
    - Players can distinguish your space from neighboring spaces

5.  Pipeline Goals

    - Deploy sample static scene: no interaction with player
    - Deploy animated scene: elements like water fountains or waving flags loop their animations
    - Deploy interactive scene: including player engagement
    - Demonstrate deploy pipeline by re-deploying content: from art creation to in scene including scripting + QA]
    - Expose pipeline gaps: identify the unknowns in specific content deployment areas

## Levels of prototypes

Failing quickly allows you to develop your experience by creating successive prototypes, with each iteration building upon the last.

**Start with a single player prototype. Then you can plan for scripting multiplayer interactions. Finally, you can tackle your persistent core loop that demonstrates transactional layers.**

**What’s a persistent core loop?**

In game design, a persistent core loop is the fundamental “game loop” that drives player actions and the game’s response to those actions. These persistent loops extend to any form of virtual experience (like those provided by Districts).

> Note: The Decentraland client borrows some architectural ideas from [React.js](https://reactjs.org/) and only renders a scene when a change has taken place, not at a constant rate.

**What are transactional layers?**

The transactional layers are the interfaces between systems like an update to the blockchain or another application that has been interfaced with your experience to maintain a persistent record of player actions. Creating and maintaining this persistent record is what builds a more personal experience.

We recommend creating your MVP as a single player experience.

For example, you could design a scene with the following successive experiences:

- A single player can enter the world.
- The player can interact with one or two simple entities within the scene.
- Other players can join and interact with the world and the other player.
- Finally, you can add the ability to remember that each player entered the scene, and to track the players’ events and activities.

## How to share your MVP

Although the Decentraland world is not yet open to all, you can upload a scene preview to a server and easily share a link to it with people who can give you feedback.

Even once Decentraland is made available to all, we still recommend testing changes with test users in a separate preview server first, before uploading a new version of your scene to Decentraland.

Read [this blogpost](https://decentraland.org/blog/announcements/decentraland-on-now/) for details on how to upload your scene preview to a free server.

## Additional considerations

Once basic use cases are covered, you can start to get more sophisticated with your release management strategy by focusing on mechanics. **Mechanics** are a broad term covering all of the actions a player can take and the responses the system will provide based on those player actions.

<!--
**Camera perspective** is another critical aspect of the user experience that will require specific and sequential goals. Since the ultimate vision of Decentraland is to build a VR world, the camera will eventually take a first person perspective. So, depending on the experience, this perspective will drive the individual experience of each player.
-->

**Device interoperability** is an important thing to be aware of. Users of your scene may be accessing your scene using a desktop, a mobile device or a VR headset. Users should be able to interact with your scene reasonably well using either. For those using a VR headset try to avoid dizzying movements that could cause motion sickness.

**Audio** is another critical aspect of a scene's atmosphere. Background sounds like wind, crickets, distant conversations, maybe even music can be a very powerful way to increase immersion and give context. You can also change how volume levels relate to distance from the sound source to put more or less emphasis on a sound's location.

Read [design constraints for games]({{ site.baseurl }}{% post_url /design-experience/2018-01-08-design-games %}) for a detailed look at a number of other considerations.

Consider the MVP as one of many prototypes that you can use to establish your cadence for releases once you have established your pipeline. The focus of each release may vary, or it may be a hybrid of each aspect of the experience. However, you should aim to deliver successively more complicated experiences, each iteration building upon the last.

1.  **MVP**: Single player
2.  **Release 2**: Add multiplayer and/or interaction support
3.  **Release 3**: Introduce your first mechanic
4.  **Release 4**: Add audio support
5.  **Release 5**: Finalize your art pipeline

For example, let’s say we are building an MVP for a Frisbee golf game. The MVP will include some still images of the course. The player may even be able to throw a disc, in a very rudimentary, block-style fashion. This allows us to work out our basic throwing mechanics. The next release may include a prototype for multiplayer support so we can demo and test two users logged in and playing on our LAND at the same time.

Remember, while the end goal is a truly immersive 3D world, that is not where your MVP will start. Getting a player into your world as quickly as possible should be your first goal. Taking weeks, not months, to test your releases is critical to learning and iterating without wasting effort.

We strongly recommend that you stay mindful of the first impression your experience presents. An empty experience will leave players disappointed. On the other hand, a scene with some initial content and basic experiences shows players the potential for what is to come and encourages them to engage with your community and return to the next few releases.

<!--
## A note on persistence and security



If you plan to include a number of applications within your experience, then you may need to think about authentication at multiple layers. The interaction with these applications should be seamless for your players. They should only have to log in once, with your applications operating “behind the scenes” to ensure that their login info is passed on to your other downstream systems. This will require a robust and thoroughly tested security architecture.

Given this complexity and stakes of security, please allocate the time and attention to these processes. Do not rush your security architecture to delivery.
-->

## Persistence factors to consider

Ultimately, you want reach a level of persistence where you can demonstrate that the transactional layers of your architecture are operational. Transactional is not limited to the players actions, but also the system’s reactions to players.

1.  **Account information**: login name, time zone, location for your specific experience/game
2.  **Leaderboard stats**: previous game play results, global/regional standings, competitions
3.  **Identity validation**: Ethereum wallet address, or any other backend identity management
4.  **Blockchain updates**: as required based on your experience/game to update the blockchain ledger for transactional transparency
5.  **Runtime persistence**: temporary data for persistence across a potentially distributed platform (i.e. health for just the single game experience)
