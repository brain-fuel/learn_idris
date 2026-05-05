module Main

%default total

greet : String -> String
greet name = "Hello, " ++ name

main : IO ()
main = putStrLn (greet "world")
