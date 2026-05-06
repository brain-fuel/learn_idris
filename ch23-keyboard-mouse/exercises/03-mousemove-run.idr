module Main

import System

%default total

-- New idea: now glue the pure command-builder (ex 02) to the IO call
-- (ex 01). `mouseMove x y` should build the string AND run it.
--
-- TODO: complete `mouseMove`:
--          let cmd = "xdotool mousemove " ++ show x ++ " " ++ show y
--          System.system cmd

covering
mouseMove : Int -> Int -> IO Int
mouseMove x y = pure 0

main : IO ()
main = do
  code <- mouseMove 100 200
  putStrLn ("FIXME mouseMove exit=" ++ show code)
