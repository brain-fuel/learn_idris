module Main

%default total

square : Int -> Int
square n = n * n

main : IO ()
main = printLn (square 5)
