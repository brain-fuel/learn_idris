module Main

import Data.String

%default total

countNonSpace : String -> Nat
countNonSpace s = length (filter (/= ' ') (unpack s))

main : IO ()
main = do
  line <- getLine
  putStrLn ("length: " ++ show (length line))
  putStrLn ("lower: " ++ toLower line)
  putStrLn ("words: " ++ show (words line))
  putStrLn ("non-space chars: " ++ show (countNonSpace line))
