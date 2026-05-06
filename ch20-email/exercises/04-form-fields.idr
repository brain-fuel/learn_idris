module Main

import Data.String
import Data.List

%default total

-- Exercise 04: the body of a form-encoded POST is `k1=v1&k2=v2&...`.
-- You already know how to make one `k=v` (ex 01). Now do the list version:
-- map each pair to `k=v`, then `joinBy "&"`.
--
-- TODO: replace `formFields` so it returns the joined body. The stub
-- returns the empty string, which prints as a blank line.

formField : (String, String) -> String
formField (k, v) = k ++ "=" ++ v

formFields : List (String, String) -> String
formFields ps = ""

main : IO ()
main = putStrLn (formFields [("from", "Ada"), ("to", "Bob"), ("subject", "hi")])
