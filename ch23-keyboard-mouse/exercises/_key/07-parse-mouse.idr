module Main

import Data.String
import Data.List1

%default total

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

main : IO ()
main = case parseMouseLine "x:100 y:200 screen:0 window:1234" of
  Just (x, y) => putStrLn ("got " ++ show x ++ " " ++ show y)
  Nothing     => putStrLn "parseMouseLine Nothing"
