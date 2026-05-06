module Main

import System
import System.File
import Data.String
import Data.List1

%default total

covering
mouseMove : Int -> Int -> IO Int
mouseMove x y =
  System.system ("xdotool mousemove " ++ show x ++ " " ++ show y)

covering
readXdotool : String -> IO String
readXdotool cmd = do
  _ <- System.system (cmd ++ " > /tmp/learn_idris_ch23_tmp.txt")
  Right s <- readFile "/tmp/learn_idris_ch23_tmp.txt"
    | Left _ => pure ""
  pure s

parseMouseLine : String -> Maybe (Int, Int)
parseMouseLine s =
  let toks = forget (split (== ' ') s) in
  case toks of
    (xtok :: ytok :: _) =>
      let xparts = forget (split (== ':') xtok)
          yparts = forget (split (== ':') ytok)
      in case (xparts, yparts) of
           (_ :: xv :: _, _ :: yv :: _) =>
             Just (cast xv, cast yv)
           _ => Nothing
    _ => Nothing

covering
whereAmI : IO (Maybe (Int, Int))
whereAmI = do
  raw <- readXdotool "xdotool getmouselocation"
  pure (parseMouseLine (trim raw))

covering
moveAndConfirm : Int -> Int -> IO ()
moveAndConfirm x y = do
  _ <- mouseMove x y
  putStrLn ("moved to " ++ show x ++ " " ++ show y)
  m <- whereAmI
  case m of
    Just (x', y') => putStrLn ("now at x:" ++ show x' ++ " y:" ++ show y')
    Nothing       => putStrLn "now at unknown"

partial
loop : IO ()
loop = do
  line <- getLine
  if line == ""
    then putStrLn "quit"
    else case words line of
           (xs :: ys :: _) => do
             moveAndConfirm (cast xs) (cast ys)
             loop
           _ => loop

partial
main : IO ()
main = loop
