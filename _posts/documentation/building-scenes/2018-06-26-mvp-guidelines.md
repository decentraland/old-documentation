---
date: 2018-01-06
title: District Minimum Viable Product Guidelines
description: Recommended guidelines for producing your first MVP scene or experience using the SDK
categories:
  - documentation
type: Document
set: building-scenes
set_order: 8
---

_Note: We originally wrote this document to help guide Decentraland's Community Districts through the process of creating their initial "minimum viable products". Building such large and comprehensive projects successfully will require an approach broken into different stages, with each stage building upon the last. We feel that this development philosophy can prove valuable to anyone creating games and experiences using the SDK, so we would like to share it with the entire developer community._

# District Minimum Viable Products

The purpose of this document is to help guide districts through the process of building their initial experiences and environments. We’ll refer to these initial experiences and environments as the Minimum Viable Product (MVP). 

**When creating your MVP, you need to think about two areas of focus: **

1. The basic user experience and functionality in your district
2. The creation of a basic "pipeline", or team workflow and content management system for building your district and iteratively improving it.

An MVP should not try to demonstrate every possible outcome of every possible experience. Instead, an MVP should be the best first impression of your district that you can make using Decentraland’s SDK.

It is important to consider your own limitations, how you plan to provide content to your users, and the expectations of your users. Approaching your District’s MVP in this way requires three different perspectives:

1. As a district leader, how do I deliver an experience to my user/player?
2. As a user/player, what do I expect from this experience? 
3. As a contributor, how do I contribute to the pipeline or experience? 

It is incredibly important to distinguish this approach from traditional agile development, because you may have to use non-optimum methods to meet your design goals.

You will have to examine your own goals in the context of your users’ expectations to decide if a certain release is focused more on the player, the pipeline and content contributors, or little of both. 

When planning each release, it is critical that you conscientiously and deliberately set your priorities according to each of these three perspectives.

Separating these goals will allow you to provide your users with greater value in addition to optimizing your pipeline.

You can expect your development backlog to follow two tracks:

- The development of the tools and interfaces needed to build your delivery pipeline. (Or to optimize your existing pipeline for contributors as well as your development team.)
- The backlog of user experiences you want to create. 

These two tracks will also follow two different approaches to testing: 

- Testing your tools and pipeline interfaces will require more technical resources.
- Testing your user experiences is more akin to traditional user interface testing, and does not require the same scripting resources.

The sooner you can get a value proposition in front of your user or player, the sooner you can get feedback to either confirm or reject that proposition. Confirming value quickly is critical. Many experienced developers will share stories of how they were certain beyond a shadow of a doubt of how amazing a new mechanic would be until they used it and it felt awkward and glitchy,  the players didn’t respond to it at all, or it didn’t solve a consumer want/need. Your want to fail quickly with as little effort as possible, so that you can learn from your failure and plan the next iteration.

So, how do you fail quickly? Very easily. You do the minimum needed to get your player to touch your product.

For example, let’s say that you’ve determined your players want to ride unicorns, so you spend months developing a pipeline to create blue unicorns and only blue unicorns. Then you give your blue unicorns to your players, only to find out that they despise blue unicorns and want only purple unicorns. You’ve wasted months of effort, and now you have to create a new pipeline to deliver your users the experience they want.

However, if you gave the minimum viable blue unicorn to your players as quickly as possible, with a pipeline you could modify, then you would quickly learn that they want purple unicorns. Putting forward the minimum amount of effort needed poll your users allows you meet their needs faster, without wasting effort and resources.

## Factors for Minimum Viable Products

Here is the list of factors to consider for your basic MVP. It is absolutely acceptable to state that you will use X and will phase in Y. Planning your post-MVP product using a phased approach will help guarantee success. 

1. Art Creation 
  - First, begin with basic still images 
  - Your first test is for style: does the style you’ve chosen appeal to your users?
  - This could be the start of a style guide to provide to an outsourced artist 
2. Scene Creation
  - Develop a basic sense of your space
  - Player should feel they are in a new, unique space
  - Delineate your space from neighboring spaces
  - Borders are evident and obvious – if only by a drawn line
  - Cover entire area with static content/art
3. Art Rendered in Scene
  - Using billboards is ok or other signage (this could simply be actual billboards or more sophisticated camera facing sprites)
  - Establish the tone and aesthetics of your space (i.e. style, bright, dark)
  - Note your process: how was art created and deployed into the scene? 
  - How do you want to organize your art files for repeated deployment?
4. Player experience
  - Players are able to log in and visit your space/scene
  - Players can distinguish your space from neighboring spaces
5. Pipeline Goals
  - Deploy sample static scene: no interaction with player
  - Deploy interactive scene: including player engagement
  - Deploy animated scene: not necessarily VR just demo movement
  - Demonstrate deploy pipeline by re-deploying content: from art creation to in scene including scripting + QA]
  - Expose pipeline gaps: identify the unknowns in specific content deployment areas

## Levels of prototypes

Failing quickly allows you to develop your experience by creating successive prototypes, with each iteration building upon the last.

**Start with a single player prototype. Then you can plan for scripting multiplayer interactions. Finally, you can tackle your persistent core loop that demonstrates transactional layers.**

**What’s a persistent core loop?**

In game design, a persistent core loop is the fundamental “game loop” that drives player actions and the game’s response to those actions. These persistent loops extend to any form of virtual experience (like those provided by Districts).

**What are transactional layers?**

The transactional layers are the interfaces between systems like an update to the blockchain or another application that has been interfaced with your experience to maintain a persistent record of player actions. Creating and maintaining this persistent record is what builds a personal and immersive experience. 

We recommend creating your MVP as a single player experience. However, your MVP will ultimately be limited by the current capabilities of the SDK.

For example, you could design a scene with the following successive experiences:

- A single player can enter the world.
- That player can navigate within the world, moving from point A to B. 
- The player can interact with one or two simple entities within the scene.
- Another players can join and interact with the world and the other player.
- Finally, you can add the ability to remember that each player entered the scene, and to track the players’ events and activities. 

## Additional considerations

Once these basic use cases are covered, you can start to get more sophisticated with your release management strategy by focusing on mechanics. **Mechanics** are a broad term covering all of the actions a player can take and the responses the system will provide based on those player actions.

**Camera perspective** is another critical aspect of the user experience that will require specific and sequential goals.  Since the ultimate vision of Decentraland is to build a VR world, the camera will eventually take a first person perspective. So, depending on the experience, this perspective will drive the individual experience of each player.

**Audio** is another critical aspect that may require its own prototype release. As with all major software releases, you may both number and name them for fun and for feedback engagement.

Consider the MVP as one of many, many prototypes that you can use to establish your cadence for releases once you have established your pipeline. The focus of each release may vary, or it may be a hybrid of each aspect of the experience. However, you should aim to deliver successively more complicated experiences, each iteration building upon the last.

1. MVP: Single player
2. Release 2: Add multiplayer and/or interaction support
3. Release 3: Introduce your first mechanic
4. Release 4: Add audio support
5. Release 5: Finalize your art pipeline 

For example, let’s say we are building an MVP for a Frisbee golf game. The MVP will include some still images of the course that can be seen by the player in the world. The player may even be able to throw a disc, in a very rudimentary, block-style fashion. This allows us to work out our basic throwing mechanics. The next release may include a prototype for multiplayer support so we can demo and test two users logged in and playing on our LAND at the same time.

Remember, while the end goal is a truly immersive 3D world, that is not where your MVP will start. Getting a player into your world as quickly as possible should be your first goal. Taking weeks, not months, to test your releases is critical to learning and iterating without wasting effort.

Finally, we strongly recommend that you stay mindful of the first impression your district presents. An empty district will leave players disappointed. On the other hand, a district with some initial content and basic experiences shows players the potential for what is to come and encourages them to engage with your community and return to the next few releases.

## A note on persistence and security

Ultimately, you want reach a level of persistence where you can demonstrate that the transactional layers of your architecture are operational. Transactional is not limited to the players actions, but also the system’s reactions to players.

If you plan to include a number of applications within your district, then you may need to think about authentication at multiple layers. The interaction with these applications should be a seamless experience for your players. They should only have to log in once, with your applications operating “behind the scenes” to ensure that their login info is passed on to your other downstream systems. This will require a robust and thoroughly tested security architecture.

Given this complexity and stakes of security, please allocate the time and attention to these processes. Do not rush your security architecture to delivery.

### Persistence factors to consider

1. **Account information** - login name, time zone, location for your specific experience/game
2. **Leaderboard stats** - previous game play results, global/regional standings, competitions
3. **Identity validation** - Ethereum or BitCoin IDs, or any other backend identity management 
4. **Blockchain updates** - as required based on your experience/game to update the blockchain ledger for transactional transparency
5. **Runtime persistence** - temporary data for persistence across a potentially distributed platform (i.e. health for just the single game experience)
