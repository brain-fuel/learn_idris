module Server.Boot

import Data.Maybe
import System

%default total

public export
record Config where
  constructor MkConfig
  udsPath   : String          -- path to the Unix domain socket
  varDir    : String          -- filesystem state root (Storage.FsBackend)

defaultUdsPath : String
defaultUdsPath = "/tmp/learn-idris-server.sock"

defaultVarDir : String
defaultVarDir = "./var/state"

export covering
load : HasIO io => io Config
load = do
  Just uds <- getEnv "UDS_PATH"
    | Nothing => pure (MkConfig defaultUdsPath defaultVarDir)
  Just var <- getEnv "VAR_DIR"
    | Nothing => pure (MkConfig uds defaultVarDir)
  pure (MkConfig uds var)
