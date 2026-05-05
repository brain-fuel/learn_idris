module Main

%default total

main : IO ()
main = do
  let n = 5
  putStrLn (if n > 3 then "big" else "small")
