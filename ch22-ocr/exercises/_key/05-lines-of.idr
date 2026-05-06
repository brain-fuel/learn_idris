module Main

import Data.String

%default total

linesOf : String -> List String
linesOf s = lines s

main : IO ()
main = do
  let sample = "alpha\nbeta\ngamma"
  let xs = linesOf sample
  putStrLn ("got " ++ show (length xs) ++ " lines")
