module Main

%default total

describe : Nat -> String
describe Z     = "zero"
describe (S k) = "non-zero"

main : IO ()
main = putStrLn (describe 0)
