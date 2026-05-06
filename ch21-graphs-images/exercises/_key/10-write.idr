module Main

import System.File

%default total

covering
writeChart : String -> String -> IO ()
writeChart path body = do
  _ <- writeFile path body
  pure ()

covering
main : IO ()
main = do
  writeChart "/tmp/learn_idris_ch21_demo.ppm" "P3\n1 1\n255\n0 0 0\n"
  putStrLn "wrote /tmp/learn_idris_ch21_demo.ppm"
