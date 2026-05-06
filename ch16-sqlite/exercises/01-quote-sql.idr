module Main

import Data.String

%default total

-- New idea: SQL string literals are wrapped in single quotes, so an
-- embedded `'` must be doubled (`''`). Anything else and the database
-- treats your data as syntax — which is the classic injection bug.
--
-- Example:  O'Reilly  -->  O''Reilly
--
-- TODO: replace each `'` in the input with `''` and return the result.
--       Hint: `unpack`, `concatMap`, `pack`. Each `'` becomes the
--       two-char string `"''"`.

quoteSql : String -> String
quoteSql s = s

main : IO ()
main = do
  putStrLn (quoteSql "O'Reilly")
  putStrLn (quoteSql "no quotes here")
