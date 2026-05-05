module Main

%default total

main : IO ()
main = printLn (filter (\x => x > 5) [1..10])
