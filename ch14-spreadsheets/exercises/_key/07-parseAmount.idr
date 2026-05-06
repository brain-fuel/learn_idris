module Main

%default total

-- Exercise 07 KEY: parse a string like "42.00" into a Double.

parseAmount : String -> Double
parseAmount s = cast s

main : IO ()
main = do
  putStrLn (show (parseAmount "42.00"))
  putStrLn (show (parseAmount "150.50"))
