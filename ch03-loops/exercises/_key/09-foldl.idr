module Main

%default total

main : IO ()
main = printLn (foldl (*) 1 [1..5])
