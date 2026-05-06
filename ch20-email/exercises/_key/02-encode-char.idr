module Main

import Data.String

%default total

-- Exercise 02 key: percent-encode space and `<`, leave other chars alone.

encodeChar : Char -> String
encodeChar ' ' = "%20"
encodeChar '<' = "%3C"
encodeChar c   = pack [c]

main : IO ()
main = do
  putStrLn (encodeChar ' ')
  putStrLn (encodeChar '<')
  putStrLn (encodeChar 'a')
