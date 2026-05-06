module Main

import Data.String

%default total

-- Escape `'` to `''` so SQL string literals stay well-formed.

quoteChar : Char -> String
quoteChar '\'' = "''"
quoteChar c    = singleton c

quoteSql : String -> String
quoteSql s = concatMap quoteChar (unpack s)

main : IO ()
main = do
  putStrLn (quoteSql "O'Reilly")
  putStrLn (quoteSql "no quotes here")
