module Main

import Data.String

%default total

-- New idea: when learning, we run programs as
--     idris2 --no-banner --exec main file.idr
-- and `getArgs` returns idris2's argv, not yours. A neat workaround
-- for testing CLI shapes: read ONE line of stdin and pretend it's
-- argv. Split on whitespace with `words`, then feed the resulting
-- list to your `parseFlags`.
--
-- That's exactly what the chapter miniproject does. It keeps the
-- testing harness uniform with every other chapter.
--
-- TODO: read a single line from stdin with `getLine`, split it on
-- whitespace with `words`, run `parseFlags` against it, and print
-- the resulting `Opts`.

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
  _ <- getLine
  printLn defaultOpts
