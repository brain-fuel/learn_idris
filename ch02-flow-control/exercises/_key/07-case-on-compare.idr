module Main

%default total

main : IO ()
main = do
  let a = 5
  let b = 8
  case compare a b of
    LT => putStrLn "smaller"
    EQ => putStrLn "equal"
    GT => putStrLn "bigger"
