module Main

%default total

-- New idea: PPM-P3 is plain ASCII. Each pixel is three integers
-- (red, green, blue), each 0..255, separated by spaces.
--
-- TODO: implement `showPixel` so it returns the three components
--       separated by single spaces, e.g. `showPixel (255, 0, 64)`
--       should produce the String `"255 0 64"`. The stub returns
--       `"FIXME"` for every pixel.

showPixel : (Int, Int, Int) -> String
showPixel _ = "FIXME"

main : IO ()
main = putStrLn (showPixel (255, 0, 64))
