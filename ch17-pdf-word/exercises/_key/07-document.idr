module Main

import Data.String

%default total

document : List String -> String
document sections = joinBy "\n\n" sections

main : IO ()
main = putStrLn (document ["# Title", "Hello.", "- one", "- two"])
