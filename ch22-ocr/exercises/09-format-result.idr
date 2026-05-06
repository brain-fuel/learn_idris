module Main

%default total

-- New idea: pretty-print the parsed total. We want exactly two decimal
-- places: `42.99` -> `"42.99"`, but `42.9` should become `"42.90"` and
-- `42` should become `"42.00"`.
--
-- Trick: multiply by 100, cast to Int (gives cents), then split into
-- whole-dollar and pad-to-two-digit cents.
--
-- TODO: replace `""` with a `case` on the input. On `Just d`, format as
-- `"total: $XX.YY"`; on `Nothing`, return `"no total found"`.

fmt2 : Double -> String
fmt2 d =
  let cents : Integer = cast (d * 100.0 + 0.5)
      whole = cents `div` 100
      frac  = cents `mod` 100
      fracStr = if frac < 10 then "0" ++ show frac else show frac
  in show whole ++ "." ++ fracStr

fmtResult : Maybe Double -> String
fmtResult mx = ""

main : IO ()
main = do
  putStrLn (fmtResult (Just 42.99))
  putStrLn (fmtResult Nothing)
