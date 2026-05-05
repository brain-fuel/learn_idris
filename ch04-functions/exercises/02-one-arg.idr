module Main

%default total

-- New idea: a function takes arguments. The TYPE shows that with arrows:
-- `square : Int -> Int` means "give me an Int, I will give you back an Int."
-- The equation introduces a NAME for the argument on the left of `=` and
-- uses it on the right.
--
-- TODO: change `FIXME` so that `square 5` returns 25.

square : Int -> Int
square n = 0

main : IO ()
main = printLn (square 5)
