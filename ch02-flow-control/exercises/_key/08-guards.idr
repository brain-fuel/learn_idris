module Main

%default total

classify : Int -> String
classify n =
  case (n < 0, n > 100) of
    (True, _)    => "neg"
    (_,    True) => "big"
    (_,    _)    => "small"

main : IO ()
main = putStrLn (classify 250)
