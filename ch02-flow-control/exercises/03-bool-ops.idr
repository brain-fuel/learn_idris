module Main

%default total

-- New idea: `&&`, `||`, and `not` combine `Bool` values. There is no
-- truthiness in Idris -- `Bool` is `True` or `False` only.
--
--       True  && False  ==  False
--       True  || False  ==  True
--       not True        ==  False
--
-- TODO: replace the placeholder `False` with the predicate
--       `a > 0 && b > 0` so the program prints `both` when both
--       numbers are positive.

main : IO ()
main = do
  let a = 4
  let b = 7
  putStrLn (if False then "both" else "not both")
