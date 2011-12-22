# mozilla-hubot-scripts

This repo is modeled after the [hubot-scripts](https://github.com/github/hubot-scripts) repos. For installation instructions, check that out.

## Goals

This project was started as an attempt to replace firebot (a varient of [mozbot](https://www.mozilla.org/projects/mozbot/)?).

Ultimately the goal of this is to make our jobs at Mozilla easier. Automating common tasks (merge incoming & mozilla-central, send to build, etc.) is one way to do that.

## Writing

For now, scripts are written in CoffeeScript because @zpao wanted to try it out. Vanilla JS should work (and may be preferred in the long run).

## Scripts

### uuid

This is a direct port of firebot's `uuid` and `cid` commands.

### bug

This listens for references to bugs and linkifys them. The format is slightly different than firebot's.