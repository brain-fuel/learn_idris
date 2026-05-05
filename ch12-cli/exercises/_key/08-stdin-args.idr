module Main

import Data.String

%default total

record Opts where
  constructor MkOpts
  input  : String
  output : String
  invert : Bool

Show Opts where
  show o = "MkOpts " ++ show o.input
       ++ " " ++ show o.output
       ++ " " ++ show o.invert

defaultOpts : Opts
defaultOpts = MkOpts "" "" False

parseFlags : List String -> Opts -> Opts
parseFlags []                          o = o
parseFlags ("--invert"      :: rest)   o = parseFlags rest ({ invert := True } o)
parseFlags ("--in"  :: v :: rest)      o = parseFlags rest ({ input  := v    } o)
parseFlags ("--out" :: v :: rest)      o = parseFlags rest ({ output := v    } o)
parseFlags (_                :: rest)  o = parseFlags rest o

main : IO ()
main = do
  line <- getLine
  let opts = parseFlags (words line) defaultOpts
  printLn opts
