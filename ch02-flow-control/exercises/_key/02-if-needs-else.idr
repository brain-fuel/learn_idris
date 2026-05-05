module Main

%default total

main : IO ()
main = do
  let temp = 70
  putStrLn (if temp > 80 then "hot" else "not hot")
