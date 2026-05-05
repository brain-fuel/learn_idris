module Main

%default total

-- New idea: `lines` splits a `String` on newline characters and gives
-- back a `List String`. Like `words`, it is forgiving.
--
-- Heads up: `lines` lives in `Data.String`. The import is missing below,
-- so the program will not compile until you add it.
--
-- TODO: add `import Data.String` ABOVE `%default total`, then replace
--       `FIXME` with `lines` so the program prints `["a", "b", "c"]`.

main : IO ()
main = printLn ((\_ => the (List String) []) "a\nb\nc")
