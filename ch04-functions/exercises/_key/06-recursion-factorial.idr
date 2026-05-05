module Main

%default total

fact : Nat -> Nat
fact Z     = 1
fact (S k) = (S k) * fact k

main : IO ()
main = printLn (fact 5)
