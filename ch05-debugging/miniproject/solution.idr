module Main

import Data.String

%default total

-- Miniproject: a one-line calculator that reads an expression like
-- `12 + 7` from stdin and prints the result. Same shape as ch04, but
-- this starter has THREE deliberate bugs. Unlike a typecheck error,
-- these bugs let the program COMPILE and RUN -- they just make it
-- print the wrong thing. Use the tools you've practiced in this
-- chapter (printLn traces, holes, REPL) to track them down:
--
--   1. Run it. With stdin `12 + 7` you should see `19`. What do you
--      actually see?
--   2. If you suspect a value is wrong, sprinkle in `printLn` traces
--      (you can `printLn` an `Integer` or a `Maybe Integer`).
--   3. If you're stuck on what to write somewhere, replace it with
--      `?something` and load in the REPL: idris2 solution.idr, then
--      `:t something` to see the type and the local context.
--
-- Bug 1: `apply`'s body ignores its operator and operands. Every
--   call returns `Just 0`, so the calculator always prints `0`. The
--   signature is correct; replace the catch-all with real clauses.
--
-- Bug 2: `apply` only handles one (catch-all) case. After fixing
--   bug 1, you'll need clauses for "+", "-", "*", and "/" -- plus
--   a catch-all returning `Nothing` for unknown operators.
--
-- Bug 3: division by zero. A real calculator should refuse `5 / 0`
--   gracefully; the `apply "/"` clause needs to check `b == 0` and
--   return `Nothing` in that case (so `main` falls through to the
--   `error` branch).
--
-- After fixing, with stdin `12 + 7` the output should be `19`.

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
