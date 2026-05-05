module Main

import Data.String

%default total

apply : String -> Integer -> Integer -> Maybe Integer
apply "+" a b = Just (a + b)
apply "-" a b = Just (a - b)
apply "*" a b = Just (a * b)
apply "/" a b = if b == 0 then Nothing else Just (a `div` b)
apply _   _ _ = Nothing

main : IO ()
main = do
  line <- getLine
  case words line of
    [aStr, op, bStr] =>
      case (parseInteger aStr, parseInteger bStr) of
        (Just a, Just b) =>
          case apply op a b of
            Just r  => printLn r
            Nothing => putStrLn "error"
        _ => putStrLn "error"
    _ => putStrLn "error"
