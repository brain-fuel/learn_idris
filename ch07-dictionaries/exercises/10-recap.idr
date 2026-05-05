module Main

import Data.SortedMap
import Data.Maybe

%default total

-- New idea (recap): records + `SortedMap` together make a tiny address
-- book. You build the map with `fromList`, look up names, and use
-- `fromMaybe` (or `case`) to handle missing keys.
--
-- TODO: replace each `FIXME` so the program prints Alice's email, then
--       Bob's email, then the placeholder `"missing"` for Carol.

record Contact where
  constructor MkContact
  email : String

main : IO ()
main = do
  let alice = MkContact "alice@x.com"
  let bob   = MkContact "bob@y.com"
  let book  = the (SortedMap String Contact)
                  (fromList [("Alice", alice), ("Bob", bob)])
  let aliceEmail = case lookup "Alice" book of
        Just c  => c.email
        Nothing => "missing"
  let bobEmail   = "PLACEHOLDER"
  let carolEmail = fromMaybe "PLACEHOLDER" (map (.email) (lookup "Carol" book))
  putStrLn aliceEmail
  putStrLn bobEmail
  putStrLn carolEmail
