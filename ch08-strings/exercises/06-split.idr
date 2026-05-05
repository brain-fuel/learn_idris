module Main

import Data.String
import Data.List1

%default total

-- New idea: `split` (from `Data.String`) splits on a predicate, but its
-- return type is `List1 a` -- a NON-EMPTY list. That makes sense: even
-- splitting `""` produces `[""]`, never an empty list.
--
-- To use it with the regular `List` API, call `forget : List1 a -> List a`
-- to drop the non-emptiness guarantee.
--
-- TODO: replace `FIXME` with `forget` so `parts` prints as a regular
--       `List String`: `["a", "b", "c"]`.

main : IO ()
main = do
  let parts = split (== ',') "a,b,c"
  printLn ((\_ => the (List String) []) parts)
