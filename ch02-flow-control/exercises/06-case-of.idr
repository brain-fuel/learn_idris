module Main

%default total

-- New idea: `case x of` pattern-matches a value against several shapes.
-- Each arm uses `=>` (NOT `=`). The wildcard `_` matches anything left
-- over. Branches are tried top to bottom.
--
--       case color of
--         "red"   => "stop"
--         "green" => "go"
--         _       => "?"
--
-- TODO: add a `"yellow" => "slow"` arm above the wildcard (and note
--        that each arm uses `=>`, not `=`) so the program prints
--        `slow` instead of `unknown`.

describe : String -> String
describe c = case c of
  "red"   => "stop"
  "green" => "go"
  _       => "unknown"

main : IO ()
main = putStrLn (describe "yellow")
