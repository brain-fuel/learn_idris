module Main

import Data.String
import Data.Maybe

%default total

-- Guess-The-Number starter file. The secret is hardcoded to 7.
--
-- TODO 1: replace the FIXME prompt with a real one that mentions the
--         range, e.g. "I'm thinking of a number between 1 and 10.".
-- TODO 2: replace the single FIXME branch under `case compare g secret of`
--         with three branches: `LT => putStrLn "Too low."`,
--         `GT => putStrLn "Too high."`, `EQ => putStrLn "Correct!"`.

main : IO ()
main = do
  putStrLn "FIXME-prompt"
  putStr "Your guess: "
  raw <- getLine
  let secret = the Nat 7
  case parsePositive {a = Nat} raw of
    Nothing => putStrLn "That's not a number."
    Just g  => case compare g secret of
                 _ => putStrLn "FIXME"
