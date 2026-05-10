module Shared.State

import Shared.Ids

%default total

-- TODO Task 2: flesh out User / Progress / AppState records and derive
-- ToJSON/FromJSON via idris2-json's elab macro.
public export
record AppState where
  constructor MkAppState
  placeholder : ()
