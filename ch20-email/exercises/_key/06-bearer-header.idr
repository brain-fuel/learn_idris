module Main

import Data.String

%default total

-- Exercise 06 key: build the Authorization header.

bearerHeader : String -> (String, String)
bearerHeader key = ("Authorization", "Bearer " ++ key)

main : IO ()
main = do
  let (name, value) = bearerHeader "FAKE_KEY"
  putStrLn (name ++ ": " ++ value)
