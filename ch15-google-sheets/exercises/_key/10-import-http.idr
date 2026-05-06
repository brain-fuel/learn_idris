module Main

import Network.HTTP.Client

%default total

-- KEY for Exercise 10.

note : String
note = "imported HTTP client"

main : IO ()
main = putStrLn note
