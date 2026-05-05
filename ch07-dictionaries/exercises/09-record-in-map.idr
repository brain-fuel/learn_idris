module Main

import Data.SortedMap

%default total

-- New idea: the values in a `SortedMap` can be records. That gives you
-- the standard "name -> contact" address-book shape, with one tidy
-- record type per value.
--
-- TODO: define `bob` (currently `FIXME`) as `MkContact "bob@y.com"
--       "555-0002"`, then replace the second `FIXME` with
--       `insert "Bob" bob book0` to add Bob to the address book.

record Contact where
  constructor MkContact
  email : String
  phone : String

showC : Contact -> String
showC c = c.email ++ " / " ++ c.phone

main : IO ()
main = do
  let alice = MkContact "alice@x.com" "555-0001"
  let bob   = MkContact "FIXME" "FIXME"
  let book0 = the (SortedMap String Contact) (fromList [("Alice", alice)])
  let book  = book0
  case lookup "Bob" book of
    Just c  => putStrLn (showC c)
    Nothing => putStrLn "not found"
