module Main

import Data.List

%default total

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
main = greet "world" defaultOpts
