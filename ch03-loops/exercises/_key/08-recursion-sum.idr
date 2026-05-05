module Main

%default total

mySum : List Nat -> Nat
mySum []        = 0
mySum (x :: xs) = x + mySum xs

main : IO ()
main = printLn (mySum [1, 2, 3, 4, 5])
