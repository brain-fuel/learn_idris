module Main

import System

%default total

covering
getMouse : IO Int
getMouse = System.system "xdotool getmouselocation"

main : IO ()
main = do
  code <- getMouse
  putStrLn ("getMouse exit=" ++ show code)
