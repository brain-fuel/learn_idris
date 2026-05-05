module Main

import Data.String

%default total

-- New idea: `length` works on a `String` and returns a `Nat` (a natural
-- number, 0, 1, 2, ...). It counts how many characters are in the string.
--
-- Note: a `String` in Idris is opaque -- you cannot say `s[2]` like in
-- Python. The high-level helpers in `Data.String` are what you reach for.
--
-- Heads up: `length` is also defined for `List` and `SnocList`, so we
-- write `String.length` to disambiguate.
--
-- TODO: replace `FIXME` with `"hello world"` so the program prints `11`.

main : IO ()
main = printLn (String.length "x")
