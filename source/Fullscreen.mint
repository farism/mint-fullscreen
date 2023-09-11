enum Fullscreen.NavigationUi {
  /* The browser will choose which of the above settings to apply. This is the default value. */
  Auto

  /* The browser's navigation interface will be hidden and the entire dimensions of the screen will be allocated to the display of the element. */
  Hide

  /* The browser will present page navigation controls and possibly other user interface; the dimensions of the element (and the perceived size of the screen) will be clamped to leave room for this user interface. */
  Show
}

record Fullscreen.Options {
  navigationUi : Fullscreen.NavigationUi
}



module Fullscreen {
  /* Tells you the Element that's currently being displayed in fullscreen mode on the DOM (or shadow DOM). If this `is Maybe::Nothing`, the document (or shadow DOM) is not in fullscreen mode. */
  fun element : Maybe(Dom.Element) {
    `
    (() => {
      const el = document.fullscreenElement
      
      return el 
        ? #{Maybe::Just(`el`)} 
        : #{Maybe::Nothing}
    })()
    `
  }

  /*
  Issues an asynchronous request to make the element be displayed in fullscreen mode.

  It's not guaranteed that the element will be put into full screen mode. If permission to enter full screen mode is granted, the returned Promise will resolve and the element will receive a fullscreenchange event to let it know that it's now in full screen mode. If permission is denied, the promise is rejected and the element receives a fullscreenerror event instead. If the element has been detached from the original document, then the document receives these events instead.
  */
  fun enter (
    element : Dom.Element,
    options : Fullscreen.Options = { navigationUi: Fullscreen.NavigationUi::Auto }
  ) : Promise(Result(String, Void)) {
    `
    (() => {
      const opts = { 
        navigationUI: #{navigationUiToString(options.navigationUi)} 
      }

      return #{element}
        .requestFullscreen()
        .then(() => #{Result::Ok(void)})
        .catch((e) => #{Result::Err(`e.message`)})
    })()
    `
  }

  /* Requests that the element on this document which is currently being presented in fullscreen mode be taken out of fullscreen mode, restoring the previous state of the screen. This usually reverses the effects of a previous call to `Fullscreen.enter`. */
  fun exit : Promise(Result(String, Void)) {
    `
    (() => {
      return document
        .exitFullscreen()
        .then(() => #{Result::Ok(void)})
        .catch((e) => #{Result::Err(`e.message`)})
    })()
    `
  }

  /* Tells you whether or not fullscreen mode is currently activated */
  fun isActive : Bool {
    element() != Maybe::Nothing
  }

  /* Tells you whether or not it is possible to engage fullscreen mode. This is false if fullscreen mode is not available for any reason (such as the "fullscreen" feature not being allowed, or fullscreen mode not being supported). */
  fun isAvailable : Bool {
    `document.fullscreenEnabled`
  }

  fun navigationUiToString (navigationUi : Fullscreen.NavigationUi) : String {
    case navigationUi {
      Fullscreen.NavigationUi::Auto => "auto"
      Fullscreen.NavigationUi::Hide => "hide"
      Fullscreen.NavigationUi::Show => "show"
    }
  }
}
