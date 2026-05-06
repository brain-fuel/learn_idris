module Main

import Data.String
import Data.List1

%default total

-- Exercise 08: parse a journal line.
--
-- A line is `<HH:MM> <event>` (one space). Return
-- `(minutes-since-midnight, event-text)`.
--
-- Example: "09:25 break" -> (565, "break")  (9*60 + 25 = 565)
--
-- Hints:
--   * `words : String -> List String` splits on whitespace.
--   * `split (== ':') s` returns `List1 Char` (use `forget` to flatten).
--   * `cast s : Int` parses a numeric string; if it fails, returns 0.
--   * `unwords` rejoins the rest if the event has multiple words.
--
-- TODO: implement `parseLine` so it returns `(minutes, event)`.

parseLine : String -> (Int, String)
parseLine _ = (0, "")

main : IO ()
main = do
  let (m, e) = parseLine "09:25 break"
  putStrLn (show m ++ " " ++ e)
