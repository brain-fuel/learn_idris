module Main

import System
import System.File
import Data.String
import Data.List1

%default total

-- New idea: now combine the popen-readback (ex 06) with the parser
-- (ex 07). `whereAmI` should ask xdotool for the cursor position and
-- return `Just (x, y)` if the line parses, `Nothing` otherwise.
--
-- TODO: complete `whereAmI`. The body should:
--          raw <- readXdotool "xdotool getmouselocation"
--          -- raw may have a trailing '\n' — strip with `trim`
--          pure (parseMouseLine (trim raw))
--       Re-implement the helpers `readXdotool` and `parseMouseLine`
--       inline (we don't have a project module system in this
--       chapter — every exercise is its own `Main`).

covering
readXdotool : String -> IO String
readXdotool _ = pure ""

parseMouseLine : String -> Maybe (Int, Int)
parseMouseLine _ = Nothing

covering
whereAmI : IO (Maybe (Int, Int))
whereAmI = pure Nothing

main : IO ()
main = do
  m <- whereAmI
  case m of
    Just (x, y) => putStrLn ("FIXME at " ++ show x ++ " " ++ show y)
    Nothing     => putStrLn "FIXME whereAmI Nothing"
