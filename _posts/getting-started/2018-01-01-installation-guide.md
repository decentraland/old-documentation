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

Для разработки с сцен в Decentraland вам нужно установить интерфейс командной строки (CLI).

CLI позволяет компилировать и просматривать вашу сцену в локальном окружении. После того, как вы протестировали сцену на вашем компьютере, вы можете загрузить ее в IPFS, привязав к вашему участку земли.

**Внимание:** На данный момент Decentraland SDK поддерживает только TypeScript.

Для установки Decentraland CLI воспользуйтесь [npm](https://www.npmjs.com/get-npm?utm_source=house&utm_medium=homepage&utm_campaign=free%20orgs&utm_term=Install%20npm).

## Прежде чем начать

Вам необходимо поставить следующе пакеты, от которых зависит CLI:

- [Node.js](https://github.com/decentraland/cli#nodejs-installation) (version 8)
- [IPFS](https://dist.ipfs.io/#go-ipfs)
- [Python 2.7.x](https://www.python.org/downloads/)

## Для установки CLI на Mac OS

Для Mac OS, просто запустите эту команду:

```bash
npm install -g decentraland
```

Как только установка завершится, команда  `dcl` будет доступна для исполнения.

## Для установки CLI на Linux

Если вы устанавливаете CLI на ОС Linux, то запустите:

```bash
npm i -g --unsafe-perm decentraland
```

Как только установка завершится, команда  `dcl` будет доступна для исполнения.

## Для установки CLI на Windows

1.  Запустите коммандную строку с правами администратора
2.  Установите windows-build-tools с помощью команды :
    `npm install --global --production windows-build-tools`
    ... Дождитесь успешной установки Visual Studio Build Tools и Python . Как только установка завершена вы вернетесь в командную строку.
3.  Установите CLI с помощью еоманды:
    `npm install -g decentraland`

Как только установка завершится, команда  `dcl` будет доступна для исполнения.

#### Необязательно: установка Git

В связи с тем, что в ОС windows не встроен инерпритатор bash, мы рекомендуем вам установить git, а так же git bash
Вы так же можете запускать команды CLI напрямую, из командной строки windows.

1.  Скачайте [git](https://git-scm.com/download/win) (скорее всего вам нужна 64битная версия):
2.  На запрос выберите установку **git bash**
3.  На запрос выбора текстового редактора по умолчанию выберите **Use the Nano editor by default**
4.  На запрос выбора путей по умолчанию, выберите **Use Git from the Windows Command Prompt**
5.  На запрос выбора исполняемого фпайла SSH, выберите **Use OpenSSH**
6.  На запрос выбора библиотеки HTTPS, выберите **Use the OpenSSL library**
7.  На запрос типа переноса строки, выберите **Checkout Windows-style, commit Unix-style line endings**
8.  На запрос выбора эмулятора термиала, выберите **Use MinTTY**
9.  На последнем этапе установки выберите следующие опции:
    - **Enable file system caching**
    - **Enable Git Credential Manager**
    - **Enable symbolic links**

## Обновление CLI на любой платформе

Чтобы обновить Decentraland CLI до последней актуальной версии, используйте команду:

```bash
npm update -g decentraland
```

## Обновление версии SDK для сцены

Когда вы обновили CLI до последней версии, все новые сцены, созданные вами будут созданы с использованием последней версии SDK. Проекты же созданные ранее будут использовать ту версию SDK, с которой они создавались. Чтобы обновить версию SDK для существующего проекта, необходимо вручную обновить версию SDK в json файле проекта.

Для обновления версии Decentraland SDK:

1.  Откройте файл _package-lock.json_ в директории со сценой.
2.  Найдите строку _metaverse_api_ и поменяйте версию на последнюю.

> Подсказка: Если вы не уверены какой номер версии сейчас актуален, можно посмотреть в [release notes]({{ site.baseurl }}{% post_url /releases/sdk/2018-01-01-4.0.0 %}).

> Примечание: проверка текущей версии SDK с помощью команды `npm` не даст вам информации, какая версия SDK используется для предпросмотра вашей сцены. Единственный способ посмотреть версию SDK для текущей сцены - смотреть в файле _package-lock.josn_.
