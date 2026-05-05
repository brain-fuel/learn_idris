module Main

%default total

main : IO ()
main = printLn (length (the (List Int) [10, 20, 30, 40]))
