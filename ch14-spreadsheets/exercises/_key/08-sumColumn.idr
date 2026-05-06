module Main

%default total

-- Exercise 08 KEY: sum a "column" of strings parsed as Doubles.

parseAmount : String -> Double
parseAmount s = cast s

sumColumn : List String -> Double
sumColumn cells = foldl (\acc, s => acc + parseAmount s) 0.0 cells

main : IO ()
main = do
  putStrLn (show (sumColumn ["42.00", "60.00", "48.50"]))
