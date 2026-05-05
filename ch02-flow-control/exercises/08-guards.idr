module Main

%default total

-- New idea: when you'd reach for "else if X, else if Y, else Z" in
-- Python, in Idris you can pack the conditions into a tuple of `Bool`
-- and `case` on that tuple. Each arm is one branch:
--
--       case (cond1, cond2) of
--         (True,  _)    => ...   -- cond1 wins
--         (_,     True) => ...   -- cond2 wins
--         (_,     _)    => ...   -- fallback
--
-- TODO: replace the placeholder `"FIXME"` with `"big"` (a String) so
--       the function returns `"big"` when `n > 100`.

classify : Int -> String
classify n =
  case (n < 0, n > 100) of
    (True, _)    => "neg"
    (_,    True) => "FIXME"
    (_,    _)    => "small"

main : IO ()
main = putStrLn (classify 250)
