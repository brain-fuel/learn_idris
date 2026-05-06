module Main

import Data.String

%default total

-- New idea: a 2D pixel grid is a list of rows. The PPM body joins
-- rows with newline characters.
--
-- TODO: implement `showGrid` so a list of rows turns into a single
--       String with rows separated by "\n". The stub returns "FIXME".

showPixel : (Int, Int, Int) -> String
showPixel (r, g, b) = show r ++ " " ++ show g ++ " " ++ show b

showRow : List (Int, Int, Int) -> String
showRow row = joinBy "  " (map showPixel row)

showGrid : List (List (Int, Int, Int)) -> String
showGrid _ = "FIXME"

main : IO ()
main = putStrLn (showGrid [[(0,0,0),(255,255,255)], [(255,255,255),(0,0,0)]])
