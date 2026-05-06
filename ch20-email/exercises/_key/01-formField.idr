module Main

import Data.String

%default total

-- Exercise 01 key: glue a (k, v) pair into `k=v`.

formField : (String, String) -> String
formField (k, v) = k ++ "=" ++ v

main : IO ()
main = putStrLn (formField ("from", "Ada"))
