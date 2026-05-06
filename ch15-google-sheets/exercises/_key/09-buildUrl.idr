module Main

%default total

-- KEY for Exercise 09.

buildUrl : (id : String) -> (range : String) -> String
buildUrl id range =
  "https://sheets.googleapis.com/v4/spreadsheets/" ++ id ++ "/values/" ++ range

main : IO ()
main = putStrLn (buildUrl "1abc" "Sheet1!A1")
