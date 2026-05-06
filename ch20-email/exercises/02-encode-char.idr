module Main

import Data.String

%default total

-- Exercise 02: a form-encoded body cannot contain spaces or `<` raw — those
-- have to be percent-escaped. Build a tiny char-to-string mapper that
-- handles the two cases we need for email-style input:
--   ' '  -> "%20"
--   '<'  -> "%3C"
--   any other char `c` -> `pack [c]` (the single-char string)
--
-- TODO: replace `encodeChar` so it returns the right string for each case.
-- The stub always returns the single-char string, leaving spaces unescaped.

encodeChar : Char -> String
encodeChar c = pack [c]

main : IO ()
main = do
  putStrLn (encodeChar ' ')
  putStrLn (encodeChar '<')
  putStrLn (encodeChar 'a')
