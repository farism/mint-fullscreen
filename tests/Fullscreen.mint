component Test.Fullscreen {
  state enterResult : String = ""
  state exitResult : String = ""

  fun enter {
    let res =
      await case el {
        Maybe::Just(el) =>
          case await Fullscreen.enter(el) {
            Result::Err(err) => err
            => ""
          }

        => Promise.resolve("")
      }

    next { enterResult: res }
  }

  fun exit {
    let res =
      await case el {
        Maybe::Just(el) =>
          case await Fullscreen.exit() {
            Result::Err(err) => err
            => ""
          }

        => Promise.resolve("")
      }

    next { exitResult: res }
  }

  fun render : Html {
    <div as el>
      <btn
        id="enter"
        onClick={enter}/>

      <btn
        id="exit"
        onClick={exit}/>

      <enterresult>
        <{ enterResult }>
      </enterresult>

      <exitresult>
        <{ exitResult }>
      </exitresult>
    </div>
  }
}

suite "Fullscreen" {
  test "element()" {
    Test.Context.of(Fullscreen.element())
    |> Test.Context.assertEqual(Maybe::Nothing)
  }

  test "isAvailable()" {
    Test.Context.of(Fullscreen.isAvailable())
    |> Test.Context.assertEqual(true)
  }

  // this test breaks for some reason. if using `true` for assert value it passes

  // test "isActive()" {

  // Test.Context.of(Fullscreen.isActive())

  // |> Test.Context.assertEqual(false)

  // }
  test "isActive()" {
    Fullscreen.isActive() == false
  }

  test "enter()" {
    <Test.Fullscreen/>
    |> Test.Html.start()
    |> Test.Html.triggerClick("#enter")
    |> Test.Html.assertTextOf("enterresult", "Permissions check failed")
    |> Test.Html.triggerClick("#exit")
    |> Test.Html.assertTextOf("exitresult", "Failed to execute 'exitFullscreen' on 'Document': Document not active")
  }

  test "exit()" {
    <Test.Fullscreen/>
    |> Test.Html.start()
  }
}
