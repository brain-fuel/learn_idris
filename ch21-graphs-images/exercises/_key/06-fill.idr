module Main

import Data.List
import Data.String

%default total

fill : Nat -> Nat -> (Int, Int, Int) -> List (List (Int, Int, Int))
fill w h c = replicate h (replicate w c)

main : IO ()
main = printLn (fill 3 2 (255, 255, 255))
