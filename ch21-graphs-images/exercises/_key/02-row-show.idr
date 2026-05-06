module Main

import Data.String

%default total

showPixel : (Int, Int, Int) -> String
showPixel (r, g, b) = show r ++ " " ++ show g ++ " " ++ show b

showRow : List (Int, Int, Int) -> String
showRow row = joinBy "  " (map showPixel row)

main : IO ()
main = putStrLn (showRow [(255,0,0), (0,255,0), (0,0,255)])
