module Main

%default total

-- New idea: shelling out to `tesseract` starts with building the
-- command string. The shape we want is:
--
--   tesseract <img> <out> -l eng 2>/dev/null
--
-- where <img> is the input image path, <out> is the output stem
-- (tesseract appends `.txt` itself), `-l eng` picks the English
-- language model, and `2>/dev/null` silences progress noise on stderr
-- so our test output stays clean.
--
-- TODO: replace the FIXME body with a `String` concatenation that
-- builds exactly that command. Idris's string `++` is your friend.

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out = "FIXME"

main : IO ()
main = putStrLn (mkCmd "receipt.png" "/tmp/out")
