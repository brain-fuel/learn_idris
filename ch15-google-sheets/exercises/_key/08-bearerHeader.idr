module Main

%default total

-- KEY for Exercise 08.

bearerHeader : (token : String) -> (String, String)
bearerHeader token = ("Authorization", "Bearer " ++ token)

main : IO ()
main = do
  let (k, v) = bearerHeader "FAKE_TOKEN"
  putStrLn (k ++ ": " ++ v)
