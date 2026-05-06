module Main

import Data.String

%default total

-- Exercise 03: lift `encodeChar` from one char to a whole String. Pattern:
-- `unpack` to get a `List Char`, `map encodeChar` to get a `List String`,
-- then `concat` to glue the pieces back into one String.
--
-- TODO: replace `encodeString` so it folds `encodeChar` over the input.
-- The stub returns the empty string regardless of input.

encodeChar : Char -> String
encodeChar ' ' = "%20"
encodeChar '<' = "%3C"
encodeChar c   = pack [c]

encodeString : String -> String
encodeString s = ""

main : IO ()
main = putStrLn (encodeString "Ada <ada@example.com>")
