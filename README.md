# Mint Fullscreen

[![CI](https://github.com/farism/mint-fullscreen/actions/workflows/ci.yml/badge.svg)](https://github.com/farism/mint-battery/actions/workflows/ci.yml)

[Mint](https://mint-lang.com/) wrapper for the browser [Fullscreen API](https://developer.mozilla.org/docs/Web/API/Fullscreen_API)

# `Example`

Example of using the `Fullscreen` module

```mint
component Main {
  fun enter {
    case target {
      Maybe::Just(el) =>
        {
          Fullscreen.enter(el)
          void
        }

      => void
    }
  }

  fun exit {
    Fullscreen.exit()
  }

  fun render {
    <div as target>
      <button onClick={enter}>
        "enter fullscreen"
      </button>

      <button onClick={exit}>
        "exit fullscreen"
      </button>
    </div>
  }
}
```

# `Functions`

The `Fullscreen` module 

- `enter(el : Dom.Element)` - Requests to enter fullscreen mode

- `exit()` - Requests to leave fullscreen mode

- `element() : Maybe(Dom.Element)` - Returns the active fullscreen element

- `isAvailable() : Bool` - Is the Fullscreen API available to use in the browser

- `isActive() : Bool` - Is fullscreen mode currently activated on an element