module Main

import Data.List

%default total

-- New idea: Idris functions don't have Python's `def f(x, y=2)` keyword
-- arguments. Instead, you bundle the optional/configurable bits into a
-- RECORD and pass that. A record is a labelled product type:
--
--     record GreetOpts where
--       constructor MkGreetOpts
--       greeting : String
--       times    : Nat
--
-- You build one with the constructor: `MkGreetOpts "Hi" 3`. You read
-- a field with dot syntax: `opts.greeting`.
--
-- TODO: replace `FIXME` with a small Nat (try `3`) so `defaultOpts` has
--       a sensible default for `times`. The file fails check until then
--       because `FIXME` is not a defined name.

record GreetOpts where
  constructor MkGreetOpts
  greeting : String
  times    : Nat

defaultOpts : GreetOpts
defaultOpts = MkGreetOpts "Hello" 0

greet : String -> GreetOpts -> IO ()
greet name opts = for_ [1 .. opts.times] $ \_ =>
  putStrLn (opts.greeting ++ ", " ++ name ++ "!")

main : IO ()
main = greet "world" defaultOpts
