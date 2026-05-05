module Main

%default total

-- New idea: a `record` is a named bundle of fields. You give it a type
-- name, a constructor, and a list of `field : Type` lines. Build a value
-- by applying the constructor to one argument per field, in order.
--
-- TODO: replace `FIXME` with an `Int` for `x`. The program prints `p.x`
--       and `p.y`. (We can't `printLn p` itself -- records don't get a
--       `Show` instance for free.)

record Point where
  constructor MkPoint
  x : Int
  y : Int

main : IO ()
main = do
  let p = MkPoint 0 5
  printLn p.x
  printLn p.y
