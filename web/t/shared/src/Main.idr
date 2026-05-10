module Main

import Hedgehog
import Test.Ids
import Test.State
import Test.Protocol

main : IO ()
main = test
  [ groupIds
  , groupState
  , groupProtocol
  ]
