module Main

%default total

describe : Bool -> String
describe True  = "yes"
describe False = "no"

main : IO ()
main = putStrLn (describe False)
