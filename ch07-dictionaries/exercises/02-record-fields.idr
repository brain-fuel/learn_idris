module Main

%default total

-- New idea: there are TWO ways to read a field from a record value.
-- Dot syntax `r.field` and prefix syntax `field r` mean the same thing.
-- They both compile down to the same field projection.
--
-- TODO: under the existing `printLn p.y` line, add a second line that
--       prints the same value using the prefix form `printLn (y p)`.
--       Replace the FIXME placeholder.

record Point where
  constructor MkPoint
  x : Int
  y : Int

main : IO ()
main = do
  let p = MkPoint 3 5
  printLn p.y
  printLn p.y
