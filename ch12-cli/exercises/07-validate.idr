module Main

%default total

-- New idea: parsing flags is only half the battle. AFTER parsing you
-- often need to check that required fields were actually filled in.
-- A `validate` step is the natural place: it returns
-- `Either String Opts` — `Left "explanation"` if something is wrong,
-- `Right opts` if all is well.
--
-- Python:    `if not args.in: parser.error("missing --in")`
-- Idris:     `validate o = if o.input == "" then Left "..." else Right o`
--
-- TODO: complete `validate` so that it returns
-- `Left "missing --in"` when `o.input` is the empty string `""`,
-- and `Right o` otherwise. (We treat the empty string as "the user
-- never set it"; in the next exercise we'll see why an empty default
-- is convenient.)

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
validate o = Right o

main : IO ()
main = do
  printLn (validate emptyOpts)
  printLn (validate (MkOpts "x.ppm" "" False))
