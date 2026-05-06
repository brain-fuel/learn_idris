module Main

%default total

-- New idea: every PPM-P3 file begins with a three-line header:
--
--     P3
--     <width> <height>
--     255
--
-- (255 is the maximum component value.) The header sits at the top of
-- the file and the pixel grid follows.
--
-- TODO: implement `header` so it returns exactly that three-line
--       String, terminated with a final newline so the pixel grid
--       can be appended on the next line. The stub returns "FIXME".

header : (w : Nat) -> (h : Nat) -> String
header _ _ = "FIXME"

main : IO ()
main = putStr (header 4 3)
