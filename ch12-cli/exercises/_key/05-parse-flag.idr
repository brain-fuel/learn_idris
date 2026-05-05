module Main

%default total

record Opts where
  constructor MkOpts
  input  : String
  output : String
  invert : Bool

defaultOpts : Opts
defaultOpts = MkOpts "in.txt" "out.txt" False

parseFlags : List String -> Opts -> Opts
parseFlags []                   o = o
parseFlags ("--invert" :: rest) o = parseFlags rest ({ invert := True } o)
parseFlags (_          :: rest) o = parseFlags rest o

main : IO ()
main = do
  let result = parseFlags ["--invert"] defaultOpts
  printLn result.invert
