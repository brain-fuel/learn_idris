module Main

import Data.String

%default total

showPixel : (Int, Int, Int) -> String
showPixel (r, g, b) = show r ++ " " ++ show g ++ " " ++ show b

showRow : List (Int, Int, Int) -> String
showRow row = joinBy "  " (map showPixel row)

showGrid : List (List (Int, Int, Int)) -> String
showGrid rows = joinBy "\n" (map showRow rows)

header : (w : Nat) -> (h : Nat) -> String
header w h = "P3\n" ++ show w ++ " " ++ show h ++ "\n255\n"

emit : Nat -> Nat -> List (List (Int, Int, Int)) -> String
emit w h rows = header w h ++ showGrid rows ++ "\n"

main : IO ()
main = putStr (emit 2 2 [[(0,0,0),(255,255,255)], [(255,255,255),(0,0,0)]])
