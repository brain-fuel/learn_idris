module Main

%default total

main : IO ()
main = do
  let a = 4
  let b = 7
  putStrLn (if a > 0 && b > 0 then "both" else "not both")
