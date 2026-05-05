module Main

%default total

myName : String
myName = "Johannes"

main : IO ()
main = putStrLn ("Hello, " ++ myName)
