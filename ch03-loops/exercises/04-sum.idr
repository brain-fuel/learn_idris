module Main

%default total

-- New idea: `sum` adds up every number in a list. So `sum [1, 2, 3]`
-- is 6. No loop needed -- the prelude already wrote one for you.
--
-- TODO: replace `FIXME` so the program prints 55. (Hint: `1..10` adds
--       up to 55, and ranges work inside list brackets.)

main : IO ()
main = printLn (sum [0])
