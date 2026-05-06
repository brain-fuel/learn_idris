module Main

import Data.String

%default total

-- Exercise 06: HTTP bearer-token auth puts the API key in an
-- `Authorization: Bearer <key>` header. Build the (name, value) pair.
--
-- TODO: replace `bearerHeader` so it returns
-- `("Authorization", "Bearer " ++ key)`. The stub returns
-- `("", "")`, which prints as `: `.

bearerHeader : String -> (String, String)
bearerHeader key = ("", "")

main : IO ()
main = do
  let (name, value) = bearerHeader "FAKE_KEY"
  putStrLn (name ++ ": " ++ value)
