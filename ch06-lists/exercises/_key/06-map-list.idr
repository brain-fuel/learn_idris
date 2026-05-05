module Main

%default total

main : IO ()
main = printLn (map (\x => x * x) [1..5])
