module Main

%default total

fmt2 : Double -> String
fmt2 d =
  let cents : Integer = cast (d * 100.0 + 0.5)
      whole = cents `div` 100
      frac  = cents `mod` 100
      fracStr = if frac < 10 then "0" ++ show frac else show frac
  in show whole ++ "." ++ fracStr

fmtResult : Maybe Double -> String
fmtResult Nothing  = "no total found"
fmtResult (Just d) = "total: $" ++ fmt2 d

main : IO ()
main = do
  putStrLn (fmtResult (Just 42.99))
  putStrLn (fmtResult Nothing)
