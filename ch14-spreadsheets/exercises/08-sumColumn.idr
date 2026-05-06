module Main

%default total

-- Exercise 08: sum a "column" of strings parsed as Doubles.
--
-- Given a list of cell strings like ["42.00", "60.00", "48.50"], sum
-- the parsed values.
--
-- TODO: replace the body so it folds parseAmount over the list.
-- Hint: `foldl (\acc, s => acc + parseAmount s) 0.0 cells`.

parseAmount : String -> Double
parseAmount s = cast s

sumColumn : List String -> Double
sumColumn cells = 0.0

main : IO ()
main = do
  putStrLn (show (sumColumn ["42.00", "60.00", "48.50"]))
