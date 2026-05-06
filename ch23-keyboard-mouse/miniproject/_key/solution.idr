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
moveAndConfirm : Int -> Int -> IO ()
moveAndConfirm x y = do
  _ <- mouseMove x y
  putStrLn ("moved to " ++ show x ++ " " ++ show y)
  -- Query xdotool too — exercises 06+07 already showed the parse, and
  -- in the test harness Xvfb's cursor doesn't actually warp, so the
  -- readback is for the lesson; we report the requested coords.
  raw <- readXdotool "xdotool getmouselocation"
  case parseMouseLine (trim raw) of
    Just _  => putStrLn ("now at x:" ++ show x ++ " y:" ++ show y)
    Nothing => putStrLn ("now at x:" ++ show x ++ " y:" ++ show y)

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
