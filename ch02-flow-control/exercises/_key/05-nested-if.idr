module Main

%default total

main : IO ()
main = do
  let n = 0
  putStrLn (if n < 0 then "neg" else if n == 0 then "zero" else "pos")
