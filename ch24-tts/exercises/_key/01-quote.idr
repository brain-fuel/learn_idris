module Main

%default total

shellQuote : String -> String
shellQuote s = "'" ++ s ++ "'"

main : IO ()
main = putStrLn (shellQuote "hello world")
