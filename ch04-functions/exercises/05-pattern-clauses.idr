module Main

%default total

-- New idea: a function can have MORE THAN ONE equation -- one per shape of
-- input. Idris reads them top-to-bottom and the first matching pattern
-- wins. With `%default total` on, you must cover EVERY shape, or check
-- fails with a coverage error.
--
-- `Nat` (natural number) has two shapes: `Z` (zero) and `S k` (one more
-- than some k). So a total `Nat -> ...` function needs both clauses.
--
-- TODO: add the missing `Z` clause so `describe 0` returns "zero".

describe : Nat -> String
describe (S k) = "non-zero"
describe Z     = "PLACEHOLDER"
-- FIXME: replace "PLACEHOLDER" above with "zero" so the program prints "zero".

main : IO ()
main = putStrLn (describe 0)
