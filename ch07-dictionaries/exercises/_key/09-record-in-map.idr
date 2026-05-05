module Main

import Data.SortedMap

%default total

record Contact where
  constructor MkContact
  email : String
  phone : String

showC : Contact -> String
showC c = c.email ++ " / " ++ c.phone

main : IO ()
main = do
  let alice = MkContact "alice@x.com" "555-0001"
  let bob   = MkContact "bob@y.com" "555-0002"
  let book0 = the (SortedMap String Contact) (fromList [("Alice", alice)])
  let book  = insert "Bob" bob book0
  case lookup "Bob" book of
    Just c  => putStrLn (showC c)
    Nothing => putStrLn "not found"
