module Main

import Data.String
import Data.SortedMap

%default total

record Contact where
  constructor MkContact
  email : String

showC : String -> Contact -> String
showC name c = name ++ ": " ++ c.email

Book : Type
Book = SortedMap String Contact

partial
loop : Book -> IO ()
loop book = do
  putStr "> "
  line <- getLine
  let toks = words line
  case toks of
    ["quit"] => pure ()
    [] => pure ()
    ("add" :: name :: email :: []) => do
      let book' = insert name (MkContact email) book
      putStrLn "ok"
      loop book'
    ("lookup" :: name :: []) =>
      case lookup name book of
        Just c  => do putStrLn (showC name c); loop book
        Nothing => do putStrLn "not found"; loop book
    ("list" :: []) => do
      for_ (Data.SortedMap.toList book) $ \(n, c) =>
        putStrLn (showC n c)
      loop book
    _ => do putStrLn "?"; loop book

partial
main : IO ()
main = loop empty
