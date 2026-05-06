module Main

import System
import System.File
import Data.String
import Data.List1

%default total

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
main : IO ()
main = do
  m <- whereAmI
  case m of
    Just (x, y) => putStrLn ("at " ++ show x ++ " " ++ show y)
    Nothing     => putStrLn "whereAmI Nothing"
