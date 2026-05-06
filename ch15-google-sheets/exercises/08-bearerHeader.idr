module Main

%default total

-- Exercise 08: build the Authorization header.
--
-- HTTP headers are (key, value) pairs. For Sheets the auth header
-- looks like:
--
--     ("Authorization", "Bearer <token>")
--
-- TODO: change `bearerHeader` so it returns
--       `("Authorization", "Bearer " ++ token)`.

bearerHeader : (token : String) -> (String, String)
bearerHeader token = ("", "")  -- FIXME: build the Authorization pair

main : IO ()
main = do
  let (k, v) = bearerHeader "FAKE_TOKEN"
  putStrLn (k ++ ": " ++ v)
