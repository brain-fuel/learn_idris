module Main

import Data.String
import Data.Maybe

%default total

main : IO ()
main = do
  putStr "first number: "
  s1 <- getLine
  putStr "second number: "
  s2 <- getLine
  let a = fromMaybe 0 (parsePositive {a = Nat} s1)
  let b = fromMaybe 0 (parsePositive {a = Nat} s2)
  case compare a b of
    LT => putStrLn "second wins"
    EQ => putStrLn "tie"
    GT => putStrLn "first wins"
