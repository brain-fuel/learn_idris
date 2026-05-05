module Main

import Data.SortedMap
import Data.Maybe

%default total

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
  let bobEmail   = case lookup "Bob" book of
        Just c  => c.email
        Nothing => "missing"
  let carolEmail = fromMaybe "missing" (map (.email) (lookup "Carol" book))
  putStrLn aliceEmail
  putStrLn bobEmail
  putStrLn carolEmail
