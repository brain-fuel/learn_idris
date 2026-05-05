module Main

import Data.String

%default total

-- New idea: many Idris functions return `Maybe a` (= `Just a | Nothing`)
-- instead of throwing. `parseInteger` returns `Maybe Integer`: `Just n`
-- on success, `Nothing` on garbage. There is NO exception to forget to
-- catch -- the type forces you to handle both cases via a `case`.
--
-- This file already has the right shape: `parse` returns `Maybe Integer`,
-- and `main` matches on `Just`/`Nothing`. The bug is that the `Just` arm
-- ignores the parsed number `n` and prints `"FIXME"` instead. Run the
-- program with input `"42"` -- it should print `42`, but it prints
-- `FIXME`. The fix is one line.
--
-- TODO: change the `Just n  => putStrLn "FIXME"` arm to `printLn n`,
-- so the program prints `42`.

parse : String -> Maybe Integer
parse s = parseInteger s

main : IO ()
main = case parse "42" of
         Just n  => putStrLn "FIXME"
         Nothing => putStrLn "not a number"
