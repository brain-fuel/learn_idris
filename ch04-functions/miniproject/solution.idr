module Main

import Data.String
import Data.Maybe

%default total

-- One-Line Calculator starter file.
--
-- Read ONE line of input shaped like `12 + 7` -- exactly three tokens
-- separated by spaces: integer, operator, integer. Operator is one of
-- `+ - * /`. Print the result. Print `error` if anything goes wrong
-- (bad operator, non-integer token, divide-by-zero, wrong token count).
--
-- TODO 1: replace the three FIXME clauses of `apply` with the right
--         arithmetic. Mind divide-by-zero in the `/` clause: return
--         `Nothing` if `b == 0`, else `Just (a `div` b)`.
-- TODO 2: replace the FIXMEs in `main` so:
--           - parsing both numbers AND applying the op succeeds   -> printLn r
--           - any of those steps fails                            -> putStrLn "error"
--
-- Sample run:
--   $ echo '12 + 7' | idris2 --no-banner --exec main solution.idr
--   19

apply : String -> Integer -> Integer -> Maybe Integer
apply "+" a b = Just (a + b)
apply "-" a b = Just 0
apply "*" a b = Just 0
apply "/" a b = Just 0
apply _   _ _ = Nothing

main : IO ()
main = do
  line <- getLine
  case words line of
    [aStr, op, bStr] =>
      case (parseInteger aStr, parseInteger bStr) of
        (Just a, Just b) =>
          case apply op a b of
            Just r  => putStrLn "FIXME"
            Nothing => putStrLn "FIXME"
        _ => putStrLn "error"
    _ => putStrLn "error"
