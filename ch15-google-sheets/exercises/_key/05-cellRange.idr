module Main

%default total

-- KEY for Exercise 05.

cellRange : (sheet : String) -> (tl : String) -> (br : String) -> String
cellRange sheet tl br = sheet ++ "!" ++ tl ++ ":" ++ br

main : IO ()
main = putStrLn (cellRange "Sheet1" "A1" "B2")
