---
date: 2018-01-05
title: Обработка событий
description: Описание различных событий в сцене и способы их обработки.
redirect_from:
  - /sdk-reference/event-handling/
categories:
  - development-guide
type: Document
set: development-guide
set_order: 3
---

В процессе взаимодействия пользователя с объектами в вашей сцене генерируется несколько типов событий. Эти события могут влиять на [состояние]({{ site.baseurl }}{% post_url /development-guide/2018-01-04-scene-state %}) сцены, что в свою очередь вызывает перерисовку всей сцены.

![](/images/media/events_state_diagram.jpeg)

В общем случае, для того чтобы ваша сцена реагировала на события, хорошей практикой будет установить обработчик событий в методе `sceneDidMount()`. Смотри [динамическая сцена]({{ site.baseurl }}{% post_url /development-guide/2018-01-05-scriptable-scene %}) где подробно описано когда вызывается этот метов.

{% raw %}

```tsx
async sceneDidMount() {
  this.eventSubscriber.on(`pointerDown`, () => console.log("pointer down"))
}
```

{% endraw %}

Для отладки сцены можно использовать `console.log()`, чтобы отслеживать вызовы различных событий и убедиться что вы передаете именно те параметры, которые необходимо.

## Клик

Кликнуть можно с помощью мыши, прикосновения в тач интерфейсах, в VR контроллере или другом устройстве, события которые генерируются в этом случае не относятся к чему-то определенному. Когда же взгляд аватара направлен на некий объект в сцене, создается событие `click`.

> Замечание: Кликнуть можно с расстояния менее 10 метров от объекта.

#### onClick

Самый простой способ обработки событий этого типа добавить компонент `onClick` к самому объекту. Если сделать это, то нет необходимости слушать обработчик событий в ожидании события click для какого-то объекта, обработка уже задана неявно.

Вы можете описать что будет происходить в случае click с помощью лямбда выражения в самом событии `onClick` , или вызвать отдельную функцию, чтобы не загромождать код.

{% raw %}

```tsx
<box
  onClick={() => console.log("Clicked!")}
  position={{ x: 5, y: 1, z: 5 }}
  scale={{ x: 2, y: 2, z: 1 }}
/>
```

{% endraw %}

 В случае вызова функции в onClick, любое использование оператора `this` будет относиться к самой функции, а не к [динамическому объекту в сцене]({{ site.baseurl }}{% post_url /development-guide/2018-01-05-scriptable-scene %}). Иногда это может вызывать трудности, если есть необходимость обратиться к самой сцене или к другим функциям, описанным для сцены. Чтобы избежать этого, можно либо  вызвать стрелочную функцию, либо описать лямбда-функцию напрямую из свойства `onClick` объекта (как в примере выше). Смотри [TypeScript Tips]({{ site.baseurl }}{% post_url /development-guide/2018-01-08-typescript-tips %}) где можно найти больше примеров и объяснений.

Объект, генерируемый событием click, передается в качестве аргумента функции, которая вызывается в событии `onClick`. Этот объект содержит следующие параметры, к которым есть доступ из вашей функции:

- `elementId`: ID объекта на который кликнули (если у него есть id).
- `pointerId`: ID пользователя, который совершил click.

{% raw %}

```tsx
import { ScriptableScene, createElement } from "decentraland-api/src"

export default class Scene extends ScriptableScene {
  async render() {
    return (
      <scene>
        <box
          position={{ x: 5, y: 0, z: 5 }}
          id="myBox"
          onClick={e => {
            console.log(`elementId: ` + e.elementId)
            console.log(`pointerId: ` + e.pointerId)
          }}
        />
      </scene>
    )
  }
}
```

{% endraw %}

Данный пример пишет в консоль оба параметра каждый раз, когда вы нажимаете на куб.

#### Базовое событие click

Базовое событие `click` представляет все события click на все объекты, которые его поддерживают. Только объекты, у которых есть id будут генерировать это событие. Объект, генерируемый после click, будет содержать следующие параметры:

- `elementId`: ID элемента, на который кликнули.
- `pointerId`: ID пользователя, который совершил это действие.

{% raw %}

```tsx
import { createElement, ScriptableScene } from "decentraland-api"

export default class LastClicked extends ScriptableScene {
  state = {
    lastClicked: "none"
  }

  async sceneDidMount() {
    this.subscribeTo("click", e => {
      this.setState({ lastClicked: e.elementId })
      console.log(this.state.lastClicked)
    })
  }

  async render() {
    return (
      <scene>
        <box id="box1" position={{ x: 2, y: 1, z: 0 }} color="ff0000" />
        <box id="box2" position={{ x: 4, y: 1, z: 0 }} color="00ff00" />
      </scene>
    )
  }
}
```

{% endraw %}

Пример выше использует метод `subscribeTo` для подписки на все события click. Когда пользователь кликает на любой из двух кубов, сцена записывает ID объекта, на который кликнули в свойство `lastClicked` и выводит это значение в консоль.

#### Нажатие на определенные объекты

Более простым способом обработки событий click на конкретный объект является подписка на эти события именно у этого объекта. Имена, которые мы получим в результате клика по этому объекту: id элемента, нижнее подчеркивание и затем _click_. Например, событие, генерируемое после клика на элемент с названием `redButton` будет называться `redButton_click`.

> Примечание: у таких событий нет свойств, то есть вы не сможете обрптиться к ID пользователя, совершившего это действие.

{% raw %}

```tsx
import { createElement, ScriptableScene } from "decentraland-api"

export default class RedButton extends ScriptableScene {
  state = {
    buttonState: false
  }

  async sceneDidMount() {
    this.eventSubscriber.on("redButton_click", () => {
      this.setState({ buttonState: !this.state.buttonState })
      console.log(this.state.buttonState)
    })
  }

  async render() {
    return (
      <scene>
        <box id="redButton" color="ff0000" />
      </scene>
    )
  }
}
```

{% endraw %}

В сцене, представленной выше, используется подписка `eventSubscriber` для инициализации подписки, которая будет ожидать события click на элемент `redButton`. Как только это произойдет значение свойства `buttonState` инвертируется.

## Событие pointer up и pointer down

События pointer down и pointer up (эти два события, идушие один за другим, генерируют событие click) случаются когда пользователь нажимает или отпускает какое-либо поле ввода. Событие может генерироваться мышью, сенсорным экраном, VR контроллером или иным устройством ввода. Неважно куда направлен взгляд пользователя, события генерируются в любом случае.

{% raw %}

```tsx
import { createElement, ScriptableScene } from "decentraland-api"

export default class BigButton extends ScriptableScene {
  state = {
    buttonState: 0
  }

  async sceneDidMount() {
    this.subscribeTo("pointerDown", e => {
      this.setState({ buttonState: 0 })
    })
    this.subscribeTo("pointerUp", e => {
      this.setState({ buttonState: 1 })
    })
  }

  async render() {
    return (
      <scene>
        <box
          id="button"
          position={{ x: 3, y: this.state.buttonState, z: 3 }}
          transition={{ position: { duration: 200, timing: "linear" } }}
        />
      </scene>
    )
  }
}
```

{% endraw %}

В сцене выше используются два метода `subscribeTo` для подписки на событие нажатия / отпускания указателя над элементом. Обе подписки вызывают функции, которые меняют значение переменной `buttonState` в сцене. В дальнейшем эта переменная используется чтобы поменять высоту кубика, который имитирует нажатие на кнопку.

## Изменение местоположения

Событие `positionChanged` генерируется каждый раз, когда пользователь меняет свое местоположение.

У события `positionChanged` есть следующие свойства:

- `position`: Vector3Component который содержит положение пользователя, относительно базового участка сцены.
- `cameraPosition`: Vector3Component содержит положение пользователя в системе координат всего мира decentraland.
- `playerHeight`: высота глаз пользователя в метрах.

{% raw %}

```tsx
import { createElement, ScriptableScene } from "decentraland-api"

export default class BoxFollower extends ScriptableScene {
  state = {
    boxPosition: { x: 0, y: 0, z: 0 }
  }

  async sceneDidMount() {
    this.subscribeTo("positionChanged", e => {
      this.setState({ boxPosition: e.position })
    })
  }

  async render() {
    return (
      <scene>
        <box position={this.state.boxPosition} />
      </scene>
    )
  }
}
```

{% endraw %}

Сцена выше использует метод `subscribeTo` для инициализации подписки на координаты местоположения пользователя. Когда пользователь двигается, сцена записывает текущее местоположение в переменную `boxPosition`, которая используется чтобы установить координаты кубика, который следует за пользователем.

## Вращение объектов

Событие `rotationChanged` отправляет угол, с которого пользователь смотрит на объект, как только этот угол изменяется.

У события `rotationChanged` есть следующие свойства:

- `rotation`: Vector3Component вектор, описывающий изменение угла зрения пользователя.

- `quaternion`: изменение угла зрения пользователя в 4х значном виде.

{% raw %}

```tsx
import { createElement, ScriptableScene } from "decentraland-api"

export default class ConeHead extends ScriptableScene {
  state = {
    rotation: { x: 0, y: 0, z: 0 }
  }

  async sceneDidMount() {
    this.subscribeTo("rotationChanged", e => {
      e.rotation.x += 90
      this.setState({ rotation: e.rotation })
    })
  }

  async render() {
    return (
      <scene>
        <cone position={{ x: 0, y: 1, z: 2 }} rotation={this.state.rotation} />
      </scene>
    )
  }
}
```

{% endraw %}

В сцене, представленной выше, используется метод `subscribeTo` для отслеживания изменения угла зрения пользователя. Когда пользователь смотрит в другом направлении, сцена сохраняет текущий угол в свойство `rotation`. В этом примере мы добалвляем дополнительные 90 градосов по оси X к текущему углу поворота, просто чтобы показать как это работает. Этот угол используется для того, чтобы сориентировать конус, который имитирует пользователя.

## Создание собственных событий

Для сцен, в которых используется более сложная логика, например для игр, можно создавать свои собственные события. Например, в своей игре вы можете объявить собственное событие _lose_ и отправлять его как только пользователь проигрывает, вы так же можете подписаться в различных методах, чтобы среагировать это событие, как только оно произойдет.

Чтобы создать собственные события, вам сначала необходимо создать свой подписчик (event subscriber) и импортировать его в сцену, как описано ниже


#### Создание собственного менеджера событий (event manager)

Для чистоты кода рекоменуем сохранить ваш event manager в отдельный файл, например `ts\EventManager.ts`.

{% raw %}

```tsx
import { EventSubscriber } from "metaverse-api"

export namespace EventManager {
  let eventSubscriber: EventSubscriber

  export function init(_eventSubscriber: EventSubscriber) {
    eventSubscriber = _eventSubscriber
  }

  export function emit(eventType: string, ...params: any[]) {
    eventSubscriber.emit(eventType, ...params)
  }
}
```

{% endraw %}

У менеджера событий есть две простых функции, одна - подписка на инициализацию подписчика, другая - создает свои экземпляры события.

#### Подписка на события

В вашей сцене вам нужно инициализировать подписку на события прежде чем вы сможете использовать эту возможность. Мы рекомендуем делать это в методе `sceneDidMount()`, так что эта возможность начнет работать сразу, как только сцена будет загружена. Не забудьте так же импортировать ваш менеджер событий, который вы описали в файле  `EventManager.ts` в основной проект `scene.tsx`.

{% raw %}

```tsx
 sceneDidMount() {
    EventManager.init(this.eventSubscriber);
    ...
  }
```

{% endraw %}

Пример ниже инициализирует подписку на события и затем подписывается на собственное событие _lose_, которое происходит, когда пользователь проигрывает. Как только происходит событие _lose_, вызывается функция `userLost()`.

{% raw %}

```tsx
 sceneDidMount() {
    EventManager.init(this.eventSubscriber);
    this.eventSubscriber.on('lose', e => this.userLost());
  }
```

{% endraw %}

#### Генерация собственных событий

Вы можете вызвать собственное событие в любой части кода сцены. Для этого вызовите функцию `emit()` и ваш обработчик событий для данной функции будет вызван, в какой бы части кода сцены он не находился.

{% raw %}

```tsx
 harmUser(){
    this.setState({health: this.state.health -= 1})
    if (this.state.health <= 0)
    {
      EventManager.emit("lose")
    }
  }
```

{% endraw %}
