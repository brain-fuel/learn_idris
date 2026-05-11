module Server.Main

import Server.Boot
import Server.Router
import Server.Uds
import Shared.Protocol

%default total

covering
handler : Envelope ClientMsg -> IO (Envelope ServerMsg)
handler env = do
  reply <- Router.dispatch env.msg
  pure (MkEnvelope env.v env.ts reply)

covering
main : IO ()
main = do
  cfg <- Boot.load
  putStrLn ("server: listening on UDS " ++ cfg.udsPath)
  Uds.acceptLoop cfg.udsPath handler
