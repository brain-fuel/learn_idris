module Main

import Data.String

%default total

-- New idea: a row of pixels in PPM-P3 is just each pixel's
-- "R G B" String, separated by TWO spaces. The double space makes
-- the boundary between pixels easy to read for humans.
--
-- TODO: implement `showRow` so a list of pixels turns into a single
--       String with each pixel rendered as "R G B" and pixels glued
--       together with "  " (two spaces). The stub returns "FIXME".
-- HINT: `Data.String.joinBy : String -> List String -> String`.

showPixel : (Int, Int, Int) -> String
showPixel (r, g, b) = show r ++ " " ++ show g ++ " " ++ show b

showRow : List (Int, Int, Int) -> String
showRow _ = "FIXME"

main : IO ()
main = putStrLn (showRow [(255,0,0), (0,255,0), (0,0,255)])
