module Main

import Data.String

%default total

-- New idea: scan a list of OCR'd lines for the first one that contains
-- the substring `"TOTAL"`. `Data.String.isInfixOf` answers "is needle
-- inside haystack?" — we wrap it in `find` from `Prelude`.
--
-- TODO: replace `Nothing` with a `find` call that returns the first
-- line where `isInfixOf "TOTAL" line` is `True`.

findTotal : List String -> Maybe String
findTotal xs = Nothing

main : IO ()
main = do
  let sample = ["Coffee Shop", "Latte 3.50", "TOTAL: $42.99"]
  case findTotal sample of
    Just l  => putStrLn ("found: " ++ l)
    Nothing => putStrLn "no total"
