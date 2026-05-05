module Main

%default total

-- New idea: `::` (pronounced "cons") sticks one new element on the FRONT
-- of a list. So `0 :: [1, 2, 3]` is the list `[0, 1, 2, 3]`. The left
-- side is a single element; the right side is a list of those same
-- elements.
--
-- TODO: replace `FIXME` with the expression `0 :: [1, 2, 3]`.

main : IO ()
main = printLn (the (List Int) ([]))
