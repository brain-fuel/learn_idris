module Main

%default total

record Point where
  constructor MkPoint
  x : Int
  y : Int

main : IO ()
main = do
  let p  = MkPoint 3 5
  let p2 = { x := 100 } p
  printLn p2.x
  printLn p2.y
