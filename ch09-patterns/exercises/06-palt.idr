module Main

import Data.String

%default total

-- New idea: `palt` is the "OR" of parsers. Try `p`; if it succeeds,
-- great. If it fails, try `q` on the SAME ORIGINAL INPUT. (This is
-- simple backtracking -- we never half-consumed because `Maybe` was
-- `Nothing`, so the leftover is still the input.)
--
--     palt (pchar 'h') (pchar 'b')   on   "bye"
--                                ==> Just ('b', "ye")
--
-- TODO: replace the body of `palt` so it:
--         * runs `p` on the input
--         * if `Just r`, returns `Just r`
--         * if `Nothing`, returns `runParser q input`
--       (Note that the second branch reuses the ORIGINAL `input`, not
--       any leftover.)

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pchar : Char -> Parser Char
pchar c = MkParser (\input =>
  case unpack input of
    (x :: xs) => if x == c then Just (c, pack xs) else Nothing
    []        => Nothing)

palt : Parser a -> Parser a -> Parser a
palt p q = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser (palt (pchar 'h') (pchar 'b')) "bye")
