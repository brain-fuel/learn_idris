module Main

%default total

-- New idea: `compare x y` returns an `Ordering`, which is one of three
-- constructors -- `LT`, `EQ`, or `GT`. You pattern-match on those with
-- `case`:
--
--       case compare a b of
--         LT => ...
--         EQ => ...
--         GT => ...
--
-- TODO: replace each `putStrLn "FIXME"` with the right message so the
--       program prints `smaller` when a < b, `equal` when a == b, and
--       `bigger` when a > b.

main : IO ()
main = do
  let a = 5
  let b = 8
  case compare a b of
    LT => putStrLn "FIXME"
    EQ => putStrLn "FIXME"
    GT => putStrLn "FIXME"
