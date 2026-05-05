module Main

%default total

main : IO ()
main = for_ [1..10] $ \i => printLn i
