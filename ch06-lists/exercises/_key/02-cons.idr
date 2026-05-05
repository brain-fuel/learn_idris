module Main

%default total

main : IO ()
main = printLn (the (List Int) (0 :: [1, 2, 3]))
