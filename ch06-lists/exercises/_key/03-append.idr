module Main

%default total

main : IO ()
main = printLn (the (List Int) ([1, 2] ++ [3, 4]))
