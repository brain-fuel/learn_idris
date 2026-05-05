module Main

import System.File
import Data.String

%default total

partial
main : IO ()
main = do
  Right contents <- readFile "ch12-cli/exercises/fixtures/tiny.ppm"
    | Left err => putStrLn ("error: " ++ show err)
  case words contents of
    ("P3" :: w :: h :: m :: _) =>
      putStrLn (w ++ " " ++ h ++ " " ++ m)
    _ => putStrLn "error: not a P3 PPM"
