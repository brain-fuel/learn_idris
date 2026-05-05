module Main

import Data.String

%default total

-- Recap: stitch together what you built.
--
-- * `parseFlags` turns a `List String` into an `Opts`.
-- * `validate` decides whether the resulting `Opts` is good.
-- * Read one line of stdin (your "argv"), split with `words`, parse,
--   validate, and act.
--
-- TODO: read one line of stdin. Run `parseFlags`, then `validate`.
-- On `Right o`, print
--     in=<input> out=<output> invert=<invert>
-- (use `show` for the bool). On `Left msg`, print
--     error: <msg>
--
-- For the input `--in a.ppm --out a.txt`, the expected output is
--     in=a.ppm out=a.txt invert=False

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
  _ <- getLine
  putStrLn "error: not implemented"
