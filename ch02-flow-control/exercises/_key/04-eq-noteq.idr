module Main

%default total

main : IO ()
main = do
  let x = 3
  let y = 4
  putStrLn (if x /= y then "different" else "same")
