module Main

import Data.Vect

%default total

scores : Vect 5 Int
scores = [80, 75, 92, 60, 88]

average : Vect (S n) Int -> Int
average xs = sum xs `div` cast (length xs)

main : IO ()
main = printLn (average scores)
