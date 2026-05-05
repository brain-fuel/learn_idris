module Main

import Data.String

%default total

-- New idea: `pdigit` matches a single character `'0'`..`'9'` and
-- returns its NUMERIC value as an `Integer`. So `'7'` becomes `7`.
--
--     runParser pdigit "42x"  ==>  Just (4, "2x")
--
-- The conversion trick: `ord c - ord '0'` gives the digit's value as
-- an `Int`; `cast` lifts that to `Integer`. Both `isDigit` and `ord`
-- are in `Data.String` (already imported).
--
-- TODO: replace the body of `pdigit` so it:
--         * looks at the head of `unpack input`
--         * if there's no head, returns Nothing
--         * if the head `c` is a digit, returns
--             `Just (cast (ord c - ord '0'), pack xs)`
--         * otherwise returns Nothing

record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

pdigit : Parser Integer
pdigit = MkParser (\_ => Nothing)

main : IO ()
main = printLn (runParser pdigit "42x")
