module Main

import System
import System.File
import System.File.Virtual

%default total

main : IO ()
main = do
  putStrLn "this is stdout"
  ignore $ fPutStrLn stderr "this is stderr"
