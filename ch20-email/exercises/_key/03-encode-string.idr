module Main

import Data.String

%default total

-- Exercise 03 key: unpack -> map encodeChar -> concat.

encodeChar : Char -> String
encodeChar ' ' = "%20"
encodeChar '<' = "%3C"
encodeChar c   = pack [c]

encodeString : String -> String
encodeString s = concat (map encodeChar (unpack s))

main : IO ()
main = putStrLn (encodeString "Ada <ada@example.com>")
