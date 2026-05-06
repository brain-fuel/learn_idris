module Main

import Data.String
import Data.List
import Data.List1

%default total

-- New idea: a line like `"TOTAL: $42.99"` carries the amount after a
-- `$`. Splitting on `$` and taking the LAST segment leaves us with
-- `"42.99"`, which `cast` can turn into a `Double`.
--
-- `Data.String.split` returns `Data.List1.List1`; we `forget` it back
-- to `List` so we can pattern-match / `last'` over it.
--
-- TODO: split on `'$'`, take the last segment, and `cast` it. Replace
-- `Nothing` with that pipeline. Hint: `last'` from `Data.List` returns
-- `Maybe a`, which composes nicely with `parseDouble`.

extractAmount : String -> Maybe Double
extractAmount line = Nothing

main : IO ()
main = do
  case extractAmount "TOTAL: $42.99" of
    Just d  => putStrLn ("amount: " ++ show d)
    Nothing => putStrLn "no amount"
