---
date: 2018-01-01
title: Installation Guide
description: Step-by-step guide to installing the SDK
categories:
  - documentation
type: Document
set: building-scenes
set_order: 0
---


Decentraland에서 Scene을 구축하고 싶다면 먼저 CLI(Command Line Interface)를 인스톨 해야 합니다.

CLI는 "off-chain" 개발 환경에서 Scene을 컴파일하거나 미리보기 할 수 있습니다. Scene을 로컬에서 테스트한 후 CLI를 이용해서 IPFS에 콘텐츠를 업로드하고, 콘텐츠를 LAND와 연결할 수 있습니다.

**참고:** 현재 Decentraland SDK(CLI 인스톨시 함께 제공됨)는 TypeScript만 지원합니다.

Decentraland CLI은 [npm](https://www.npmjs.com/get-npm?utm_source=house&utm_medium=homepage&utm_campaign=free%20orgs&utm_term=Install%20npm)을 통해 배포됩니다.

## 시작하기 전 준비사항

CLI를 인스톨 하기 전에 다음 프로그램을 함께 설치하세요:
* [Node.js](https://github.com/decentraland/cli#nodejs-installation) (Ver 8)
* [IPFS](https://dist.ipfs.io/#go-ipfs)
* [Python 2.7.x](https://www.python.org/downloads/)


## Mac OS에서 CLI 설치

Mac에서 다음 명령을 실행합니다:

```bash
npm install -g decentraland
```

설치가 완료되면 `dcl` 명령어 입력이 전역적으로 가능하게 됩니다.


## Linux에서 CLI 설치

Linux기반 OS에서 CLI를 설치하려면 다음 명령을 실행합니다.

```bash
npm i -g --unsafe-perm decentraland
```

설치가 완료되면 `dcl` 명령어 입력이 전역적으로 가능하게 됩니다.

## Windows에서 CLI 설치

1. 명령 프롬프트(Command Prompt) 프로그램을 **관리자 권한으로 실행** 으로 실행하세요.
2. windows-build-tools을 설치하기 위해 다음의 명령어를 실행해서 설치하세요:
`npm install --global --production windows-build-tools`
... Visual Studio Build Tool 과 Python 설치가 모두 완료 되어 `Successfully installed xxxx` 라는 메시지를 확인하면 명령 프롬프트 화면으로 다시 돌아옵니다.
3. 다음의 명령어를 실행해서 CLI를 설치합니다:
`npm install -g decentraland`


설치가 완료되면 `dcl` 명령어 입력이 전역적으로 가능하게 됩니다.

#### 옵션: Git 설치

Windows는 bash를 사용하지 않으므로 git과 git bash를 포함해서 설치하는 것이 추천됩니다. 그렇지 않으면 Windows 명령 프롬프트에서 CLI 명령을 실행하십시오.

1. [git](https://git-scm.com/download/win)을 다운로드 합니다. (Windows 64비트 버전이 권장됩니다):
2. 설치중 메시지가 표시되면 **git bash**를 선택하세요.
3. 텍스트 편집기에 대한 메시지가 표시되면 **Use the Nano editor by default** 를 선택하세요.
4. 경로 환경을 조정하라는 메시지가 표시되면 **Use Git from the Windows Command Prompt** 를 선택하세요.
5. SSH 실행 파일을 선택하라는 메시지가 표시되면 **Use OpenSSH**을 선택합니다.
6. HTTPS 전송 백엔드를 선택하라는 메시지가 표시되면 **Use the OpenSSL library** 를 선택하세요.
7.  Line ending 전환을 구성하라는 메시지가 표시되면 **Checkout Windows-style, commit Unix-style line endings** 을 선택하세요.
8. Git Bash와 함께 터미널 에뮬레이터를 구성하라는 메시지가 표시되면 **Use MinTTY** 를 선택하세요.
9. 최종 설치 화면에서 다음 옵션들을 선택하세요.
    * **Enable file system caching**
    * **Enable Git Credential Manager**
    * **Enable symbolic links**


## CLI 업데이트(모든 플랫폼 동일)

최신 버전으로 CLI를 업데이트 하려면 다음 명령을 실행하세요.

``bash
npm update -g decentraland
```