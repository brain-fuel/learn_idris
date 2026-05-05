module Main

%default total

main : IO ()
main = printLn (map (\x => x * 2) [1..5])
