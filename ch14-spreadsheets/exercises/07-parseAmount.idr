module Main

%default total

-- Exercise 07: parse a string like "42.00" into a Double.
--
-- Idris's `cast` instance for `Double` handles strings with digits and
-- a decimal point. Garbage input returns 0.0 — we accept that for now.
--
-- TODO: replace the body with `cast s` (Idris will infer `Double`
-- from the return type).

parseAmount : String -> Double
parseAmount s = 0.0

main : IO ()
main = do
  putStrLn (show (parseAmount "42.00"))
  putStrLn (show (parseAmount "150.50"))
