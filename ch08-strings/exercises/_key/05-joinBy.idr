module Main

import Data.String

%default total

main : IO ()
main = putStrLn (joinBy "-" ["a", "b", "c"])
