## About

Hangover is a game engine based on Gin.
The primary goals of hangover were:

- Hangover will use opengl for graphics.
- Hangover will have consistant naming.
- Hangover will have a ui system.

## Install

Run:

```
$ nimble install hangover
```

## Usage

Like Gin, Hangover introduces a template, called "Game" which can be used as a game loop.

## Minimal Example

```nim
import hangover

Game:
  var
    bg: Color = newColor(0, 0, 0)

  proc drawLoading(percent: float32, loadStatus: string, ctx: GraphicsContext) =
    ## renders the loading screen
    ## only updates when setPc or setStatus is called in Initialize
    clearBuffer(ctx, bg)
  
  proc Initialize(ctx: var GraphicsContext) =
    ## load content files
    discard

  proc Update(deltaTime: float)
    ## process a frame event
    discard
  
  proc Draw(ctx: var GraphicsContext) =
    ## draws a frame
    clearBuffer(ctx, bg)

  proc closeGame() =
    ## called when the game is closed 
    discard
```

## Games written in hangover

- [Chesker](https://prestosilver.itch.io/chesker)
- [Bugz Bows & Curses](https://prestosilver.itch.io/bugz)
