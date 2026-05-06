module Main

import Language.JSON.Data

%default total

-- KEY for Exercise 04.

render : JSON -> String
render v = show v

main : IO ()
main = putStrLn (render (JString "x"))
