module Main

%default total

-- New idea: `++` glues two lists together end to end. Both sides must be
-- lists of the SAME element type. (You may remember `++` from strings —
-- a `String` behaves a lot like a list of characters.)
--
-- TODO: replace `FIXME` so the program prints `[1, 2, 3, 4]`.

main : IO ()
main = printLn (the (List Int) ([] ++ [3, 4]))
