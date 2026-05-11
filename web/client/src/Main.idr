module Main

import Client.App
import Client.State
import Generated.Routes
import JS
import Web.MVC

%default total

-- Bootstrap: initial event is NavTo RStub so the first render fetches the
-- stub lesson asset. dom-mvc handles the rest via update / display.
covering
main : IO ()
main =
  runMVC update display
    (\_ => consoleLog "web-client: MVC error")
    (NavTo RStub)
    initModel
