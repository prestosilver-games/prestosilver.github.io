## About

Gin (Gameengine In Nim) is a game engine written in nim, but the more I look back at it the more I realize it was just a graphics & sound library. Yes it managed the game loop but it didnt manage anything else, resulting in the user essentially writing a whole engine ontop of gin.

## Install

Run:

```
nimble install http://github.com/bob16795/gin
```

## Usage

Gin introduces a template, called "Game" which can be used as a game loop.

## Minimal Example

```
import gin
import gin/graphics

Game:
  var
    background: Color # the background color

  template Initialize() =
    # get the game ready to load
    setWindowName("Minimal gin game") # set the window title
    setAppName("Minimal") # set the save folder name
    setWindowSize(Point(X: 1024, Y: 600)) # set the window size
    setDt(16) # set the frame rate to 60 fps
    background = initColor(255, 255, 255) #ffffff

  template drawLoading(pc: float, status: string): untyped =
    # renders the loading screen
    clearBuffer(background) # clear the screen

  template Setup(): untyped =
    # load resources
    discard

  template Update(dt: cuint) =
    # main update function in loop
    discard

  template Draw(dt: cuint, ctx: GraphicsContext) =
    # render the next frame
    clearBuffer(background) # clear the screen
  
  template Close() =
    # ran when the game is closed
    discard
```

## Games written in gin

- [Sleep to defend](https://prestosilver.itch.io/sleep-to-defend)
- [The grand finale](https://prestosilver.itch.io/finale)
