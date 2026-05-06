module Main

import Data.String
import Data.List

%default total

-- Exercise 04 key: map formField, joinBy "&".

formField : (String, String) -> String
formField (k, v) = k ++ "=" ++ v

formFields : List (String, String) -> String
formFields ps = joinBy "&" (map formField ps)

main : IO ()
main = putStrLn (formFields [("from", "Ada"), ("to", "Bob"), ("subject", "hi")])
