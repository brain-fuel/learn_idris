module Main

%default total

-- New idea: `filter pred xs` keeps only the elements where `pred x` is
-- True. The predicate is a function from the element type to `Bool`.
--
-- TODO: change the predicate so only numbers GREATER than 5 survive.
--       Replace `< FIXME` with `> 5`. Output should be [6,7,8,9,10].

main : IO ()
main = printLn (filter (\x => x < 0) [1..10])
