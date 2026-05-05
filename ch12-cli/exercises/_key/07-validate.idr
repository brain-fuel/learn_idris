module Main

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

emptyOpts : Opts
emptyOpts = MkOpts "" "" False

validate : Opts -> Either String Opts
validate o =
  if o.input == ""
    then Left "missing --in"
    else Right o

main : IO ()
main = do
  printLn (validate emptyOpts)
  printLn (validate (MkOpts "x.ppm" "" False))
