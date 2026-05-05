module Main

%default total

isOdd : Integer -> Bool
isOdd n = n `mod` 2 /= 0

main : IO ()
main = printLn (filter isOdd [1..10])
