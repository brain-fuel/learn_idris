module Main

import System

%default total

covering
mouseMove : Int -> Int -> IO Int
mouseMove x y =
  System.system ("xdotool mousemove " ++ show x ++ " " ++ show y)

main : IO ()
main = do
  code <- mouseMove 100 200
  putStrLn ("mouseMove exit=" ++ show code)
