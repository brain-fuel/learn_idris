module Main

%default total

main : IO ()
main = traverse_ printLn [1..3]
