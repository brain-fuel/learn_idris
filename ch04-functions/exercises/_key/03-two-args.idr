module Main

%default total

add : Int -> Int -> Int
add x y = x + y

main : IO ()
main = printLn (add 12 7)
