module Main

%default total

-- New idea: instead of bolting a giant `argparse` framework onto your
-- program, you describe your options as a small `record`. One field
-- per option. The whole "config of the run" lives in one value.
--
-- Python:    `args = parser.parse_args()`
-- Idris:     `opts <- parseFlags <$> getArgs <*> pure defaultOpts`
--            (we'll build the parser in later exercises)
--
-- It also helps to define a `defaultOpts` value so you can override
-- only the fields the user actually specified.
--
-- TODO 1: complete `defaultOpts` so the input field is `"in.txt"`,
--         the output field is `"out.txt"`, and `invert` is `False`.
-- (The record itself is already declared for you.)

record Opts where
  constructor MkOpts
  input  : String
  output : String
  invert : Bool

defaultOpts : Opts
defaultOpts = MkOpts "FIXME" "FIXME" False

main : IO ()
main = do
  putStrLn defaultOpts.input
  putStrLn defaultOpts.output
  printLn defaultOpts.invert
