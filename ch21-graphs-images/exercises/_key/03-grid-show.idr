module Main

import Data.String

%default total

showPixel : (Int, Int, Int) -> String
showPixel (r, g, b) = show r ++ " " ++ show g ++ " " ++ show b

showRow : List (Int, Int, Int) -> String
showRow row = joinBy "  " (map showPixel row)

showGrid : List (List (Int, Int, Int)) -> String
showGrid rows = joinBy "\n" (map showRow rows)

main : IO ()
main = putStrLn (showGrid [[(0,0,0),(255,255,255)], [(255,255,255),(0,0,0)]])
