---
date: 2020-04-16
title: External links
description: Link out to an external site
categories:
  - development-guide
type: Document
---

To add a link to an external website, use the `openExternalURL()` command.

```ts
const entity = new Entity()
entity.addComponent(new BoxShape())
const transform = new Transform({ position: new Vector3(4, 0, 4) })
entity.addComponent(transform)
entity.addComponent(
  new OnPointerDown(() => {
    openExternalURL("https://docs.decentraland.org")
  })
)
engine.addEntity(entity)
```

To prevent any abusive usage of this feature to spam players, it's only possible to call the `openExternalURL` from an explicit click or button event on an entity. It's not possible to call this function as a result of a timer, or a collision area, or a global click event.

When `openExternalURL` is called, players are prompted with a confirmation screen, where they are informed of where the link will take them, and where can accept of decline to visit the link.

The link is opened in a new tab, keeping the original tab in Decentraland.

If players tick the _trust this domain_ checkbox, they won't be prompted again during their session, as long as the link comes from the same scene and is to the same domain.
