module Main

%default total

-- New idea: more arguments = more arrows. The TYPE
--   add : Int -> Int -> Int
-- reads "give me an Int, then another Int, and I will give you back an Int."
-- On the left of `=` you list both argument names.
--
-- TODO: change `FIXME` so that `add 12 7` returns 19.

add : Int -> Int -> Int
add x y = 0

main : IO ()
main = printLn (add 12 7)
