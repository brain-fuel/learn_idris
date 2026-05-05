module Main

%default total

loop : Nat -> Nat
loop Z     = 0
loop (S k) = loop k

main : IO ()
main = printLn (loop 5)
