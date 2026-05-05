module Main

import Data.String

%default total

record Opts where
  constructor MkOpts
  input  : String
  output : String
  invert : Bool

defaultOpts : Opts
defaultOpts = MkOpts "" "" False

parseFlags : List String -> Opts -> Opts
parseFlags []                          o = o
parseFlags ("--invert"      :: rest)   o = parseFlags rest ({ invert := True } o)
parseFlags ("--in"  :: v :: rest)      o = parseFlags rest ({ input  := v    } o)
parseFlags ("--out" :: v :: rest)      o = parseFlags rest ({ output := v    } o)
parseFlags (_                :: rest)  o = parseFlags rest o

validate : Opts -> Either String Opts
validate o =
  if o.input == ""       then Left "missing --in"
  else if o.output == "" then Left "missing --out"
  else                        Right o

main : IO ()
main = do
  line <- getLine
  let opts = parseFlags (words line) defaultOpts
  case validate opts of
    Left msg => putStrLn ("error: " ++ msg)
    Right o  => putStrLn ("in=" ++ o.input
                       ++ " out=" ++ o.output
                       ++ " invert=" ++ show o.invert)
