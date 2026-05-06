module Main

import Data.String
import Data.List1

%default total

-- New idea: `xdotool getmouselocation` prints a single line like
--           x:100 y:200 screen:0 window:1234
-- Parse it into `(100, 200)`. Strategy:
--   1. Split on space  -> ["x:100", "y:200", "screen:0", "window:1234"]
--   2. Take the first two tokens; split each on ':'.
--   3. `cast` the right-hand sides to Int.
-- `Data.String.split` returns `List1`, not `List`; `forget` converts.
--
-- TODO: complete `parseMouseLine`:
--          let toks = forget (split (== ' ') s)
--          case toks of
--            (xtok :: ytok :: _) =>
--              let xparts = forget (split (== ':') xtok)
--                  yparts = forget (split (== ':') ytok)
--              in case (xparts, yparts) of
--                   (_ :: xv :: _, _ :: yv :: _) =>
--                     Just (cast xv, cast yv)
--                   _ => Nothing
--            _ => Nothing

parseMouseLine : String -> Maybe (Int, Int)
parseMouseLine s = Nothing

main : IO ()
main = case parseMouseLine "x:100 y:200 screen:0 window:1234" of
  Just (x, y) => putStrLn ("FIXME got " ++ show x ++ " " ++ show y)
  Nothing     => putStrLn "FIXME parseMouseLine Nothing"
