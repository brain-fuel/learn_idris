module Main

%default total

-- New idea: records are immutable, so "update" actually means "build a
-- copy with one field changed." The syntax is `{ field := newValue } r`,
-- which produces a NEW record. The original `r` is untouched.
--
-- TODO: replace `FIXME` with a record-update expression that copies `p`
--       but sets `x` to `100`. Use the syntax `{ x := 100 } p`.

record Point where
  constructor MkPoint
  x : Int
  y : Int

main : IO ()
main = do
  let p  = MkPoint 3 5
  let p2 = p
  printLn p2.x
  printLn p2.y
