module Main

import System
import System.File
import Data.String
import Data.List1

%default total

-- New idea: turn `moveAndConfirm` into a small REPL. Read stdin one
-- line at a time; each line is `X Y`. On EOF (`getLine` returns ""),
-- print `quit` and stop. The loop is `partial` because IO recursion
-- isn't structural (same pattern as ch07's contact-book loop).
--
-- TODO: complete `loop`:
--          line <- getLine
--          if line == ""
--            then putStrLn "quit"
--            else case words line of
--                   (xs :: ys :: _) => do
--                     moveAndConfirm (cast xs) (cast ys)
--                     loop
--                   _ => loop

covering
moveAndConfirm : Int -> Int -> IO ()
moveAndConfirm _ _ = putStrLn "FIXME moveAndConfirm"

partial
loop : IO ()
loop = putStrLn "FIXME loop"

partial
main : IO ()
main = loop
