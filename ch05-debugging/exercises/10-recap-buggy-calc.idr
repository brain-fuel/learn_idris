module Main

import Data.String

%default total

-- Recap: a tiny calculator that mirrors the chapter's themes (operator
-- dispatch, parsing, Maybe, case analysis). This stub COMPILES, but
-- with stdin `12 + 7` it prints `0` instead of `19`. Three deliberate
-- bugs, each a runtime / logic problem rather than a typecheck error.
-- Use the tools you've practiced -- `printLn` traces, holes, REPL --
-- to track them down.
--
-- Bug 1 (cf. ex02): `apply` ignores its operator and operands. Every
--   clause returns `Just 0` regardless. The signature is correct;
--   the BODY is the lie.
--
-- Bug 2 (cf. ex03): `apply` only has one clause -- a catch-all. With
--   `%default total` that's not a coverage error (it covers everything),
--   but it does mean `+`, `-`, `*`, and `/` all behave the same way.
--   Add real clauses for "+", "-", "*", and "/".
--
-- Bug 3 (cf. ex07): `main` parses `aStr` and `bStr` as `Maybe Integer`,
--   but on the `Nothing` branches it just falls through to `error`.
--   That's actually correct -- the bug is that with the broken `apply`
--   above, even valid input prints `0`. Fix `apply` and the calculator
--   starts producing the right numbers.
--
-- TODO: rewrite `apply` so the calculator produces correct results.
-- After the fix, stdin `12 + 7` should print `19`.

apply : String -> Integer -> Integer -> Maybe Integer
apply _ _ _ = Just 0

main : IO ()
main = do
  line <- getLine
  case words line of
    [aStr, op, bStr] =>
      case (parseInteger aStr, parseInteger bStr) of
        (Just a, Just b) =>
          case apply op a b of
            Just r  => printLn r
            Nothing => putStrLn "error"
        _ => putStrLn "error"
    _ => putStrLn "error"
