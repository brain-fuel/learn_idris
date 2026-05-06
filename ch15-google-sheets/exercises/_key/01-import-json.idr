module Main

import Language.JSON.Data

%default total

-- KEY for Exercise 01.
--
-- Building a JSON string literal: wrap a Idris String in `JString`.

greeting : JSON
greeting = JString "hello"

main : IO ()
main = putStrLn (show greeting)
