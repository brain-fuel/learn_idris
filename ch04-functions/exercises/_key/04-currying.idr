module Main

%default total

add : Int -> Int -> Int
add x y = x + y

-- `add 3` is a function that still wants the second number.
incBy3 : Int -> Int
incBy3 = add 3

main : IO ()
main = printLn (incBy3 10)
