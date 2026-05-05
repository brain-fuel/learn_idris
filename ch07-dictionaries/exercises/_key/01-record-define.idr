module Main

%default total

record Point where
  constructor MkPoint
  x : Int
  y : Int

main : IO ()
main = do
  let p = MkPoint 3 5
  printLn p.x
  printLn p.y
