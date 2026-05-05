module Main

%default total

record Opts where
  constructor MkOpts
  input  : String
  output : String
  invert : Bool

defaultOpts : Opts
defaultOpts = MkOpts "in.txt" "out.txt" False

main : IO ()
main = do
  putStrLn defaultOpts.input
  putStrLn defaultOpts.output
  printLn defaultOpts.invert
