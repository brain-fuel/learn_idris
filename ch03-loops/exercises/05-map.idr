module Main

%default total

-- New idea: `map f xs` builds a NEW list by applying `f` to every
-- element of `xs`. The original list is untouched -- in Idris, lists
-- (and most everything else) cannot be mutated.
--
-- TODO: change the lambda so each number is DOUBLED, not "plus FIXME".
--       Replace `+ FIXME` with `* 2`. The output should be [2,4,6,8,10].

main : IO ()
main = printLn (map (\x => x + 0) [1..5])
