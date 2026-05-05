module Main

%default total

describe : String -> String
describe c = case c of
  "red"    => "stop"
  "green"  => "go"
  "yellow" => "slow"
  _        => "unknown"

main : IO ()
main = putStrLn (describe "yellow")
