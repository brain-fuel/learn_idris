module Main

import Data.List

%default total

-- New idea: to change ONE field of a record without retyping the rest,
-- use record-update syntax:
--
--     { field := newValue } record
--
-- It returns a COPY of `record` with `field` overwritten. Records (like
-- everything else in Idris) are immutable -- the original is untouched.
--
-- TODO: change `FIXME` into `{ times := 5 } defaultOpts` so the program
--       greets "world" five times instead of three.

record GreetOpts where
  constructor MkGreetOpts
  greeting : String
  times    : Nat

defaultOpts : GreetOpts
defaultOpts = MkGreetOpts "Hello" 3

greet : String -> GreetOpts -> IO ()
greet name opts = for_ [1 .. opts.times] $ \_ =>
  putStrLn (opts.greeting ++ ", " ++ name ++ "!")

main : IO ()
main = do
  let opts = defaultOpts
  greet "world" opts
