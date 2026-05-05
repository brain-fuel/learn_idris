module Main

%default total

main : IO ()
main = printLn (the (List Nat) [1, 2, 3, 4, 5])
