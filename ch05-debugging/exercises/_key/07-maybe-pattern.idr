module Main

import Data.String

%default total

parse : String -> Maybe Integer
parse s = parseInteger s

main : IO ()
main = case parse "42" of
         Just n  => printLn n
         Nothing => putStrLn "not a number"
