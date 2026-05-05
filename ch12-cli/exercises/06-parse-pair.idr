module Main

%default total

-- New idea: some flags take an argument, like `--in foo.txt`. In our
-- list of tokens that's two consecutive elements: `"--in"` followed
-- by `"foo.txt"`. So the parser pattern is
--
--     parseFlags ("--in" :: v :: rest) o = parseFlags rest ({ input := v } o)
--
-- The `v` binds the value that came right after `--in`, and we
-- recurse on `rest`. Same shape for `--out`. `--invert` still takes
-- no value.
--
-- TODO: extend `parseFlags` to also recognize `--in <value>`
-- (sets the `input` field) and `--out <value>` (sets the `output`
-- field). Keep the `--invert` case from the previous exercise.

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
defaultOpts = MkOpts "in.txt" "out.txt" False

parseFlags : List String -> Opts -> Opts
parseFlags []                   o = o
parseFlags ("--invert" :: rest) o = parseFlags rest ({ invert := True } o)
parseFlags (_          :: rest) o = parseFlags rest o

main : IO ()
main = printLn (parseFlags ["--in", "x.ppm", "--invert"] defaultOpts)
