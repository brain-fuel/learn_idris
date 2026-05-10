module Server.Boot

%default total

-- TODO: load config from env (PORT, COOKIE_SECRET, SANDBOX_WS_URL).
public export
record Config where
  constructor MkConfig
  port           : Int
  cookieSecret   : String
  sandboxWsUrl   : String
