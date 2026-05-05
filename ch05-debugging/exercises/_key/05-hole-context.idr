module Main

%default total

compute : Int -> Int -> Int
compute x y =
  let bigger = if x > y then x else y in
  bigger

main : IO ()
main = printLn (compute 3 5)
