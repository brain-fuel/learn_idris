module Main

%default total

-- New idea: a hand-rolled flag parser is tiny. It walks the argument
-- list. Each time it sees a flag it recognizes, it returns a NEW
-- record with the right field updated. Idris record-update syntax is
--
--     { field := newValue } record
--
-- (Yes, Idris uses `:=` for record updates, not `=`.) That builds a
-- fresh `Opts` with `field` overwritten.
--
-- Python:    `if "--invert" in argv: opts.invert = True`
-- Idris:     `parseFlags ("--invert" :: rest) o = parseFlags rest ({ invert := True } o)`
--
-- TODO: complete `parseFlags` so each `"--invert"` token in the input
-- list flips `invert` to `True`. Other tokens are ignored. The
-- recursion ends when the list is empty.

record Opts where
  constructor MkOpts
  input  : String
  output : String
  invert : Bool

defaultOpts : Opts
defaultOpts = MkOpts "in.txt" "out.txt" False

parseFlags : List String -> Opts -> Opts
parseFlags _ o = o

main : IO ()
main = do
  let result = parseFlags ["--invert"] defaultOpts
  printLn result.invert
