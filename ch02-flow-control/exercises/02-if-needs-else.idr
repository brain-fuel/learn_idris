module Main

%default total

-- New idea: every `if` MUST have an `else`. There is no "if without an
-- else" in Idris -- the whole expression has to produce a value, even
-- when the condition is False.
--
-- TODO: replace the placeholder `"FIXME-else"` with `"not hot"` so the
--       program prints `not hot` (because `temp` is 70, not greater
--       than 80).

main : IO ()
main = do
  let temp = 70
  putStrLn (if temp > 80 then "hot" else "FIXME-else")
