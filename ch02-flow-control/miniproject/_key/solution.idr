module Main

import Data.String
import Data.Maybe

%default total

main : IO ()
main = do
  putStrLn "I'm thinking of a number between 1 and 10."
  putStr "Your guess: "
  raw <- getLine
  let secret = the Nat 7
  case parsePositive {a = Nat} raw of
    Nothing => putStrLn "That's not a number."
    Just g  => case compare g secret of
                 LT => putStrLn "Too low."
                 GT => putStrLn "Too high."
                 EQ => putStrLn "Correct!"
