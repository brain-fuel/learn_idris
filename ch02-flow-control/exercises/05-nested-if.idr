module Main

%default total

-- New idea: chain `if`s for three-way decisions. The trick is that the
-- `else` branch of one `if` is itself another `if` expression:
--
--       if cond1 then x
--         else if cond2 then y
--           else z
--
-- TODO: replace the placeholder `"FIXME"` with the rest of the chain
--       so the program prints `neg` for negative `n`, `zero` for `0`,
--       and `pos` for positive `n`. Use
--       `if n == 0 then "zero" else "pos"`.

main : IO ()
main = do
  let n = 0
  putStrLn (if n < 0 then "neg" else "FIXME")
