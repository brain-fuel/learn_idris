module Main

import System
import System.File
import Data.String
import Data.List1

%default total

-- New idea: chain the move (ex 03) with the where-am-I (ex 08) so we
-- can see we actually got there. Print:
--           moved to <x> <y>
--           now at x:<x> y:<y>
--
-- TODO: complete `moveAndConfirm`:
--          _ <- mouseMove x y
--          putStrLn ("moved to " ++ show x ++ " " ++ show y)
--          m <- whereAmI
--          case m of
--            Just (x', y') => putStrLn ("now at x:" ++ show x' ++ " y:" ++ show y')
--            Nothing       => putStrLn "now at unknown"

covering
mouseMove : Int -> Int -> IO Int
mouseMove _ _ = pure 0

covering
readXdotool : String -> IO String
readXdotool _ = pure ""

parseMouseLine : String -> Maybe (Int, Int)
parseMouseLine _ = Nothing

covering
whereAmI : IO (Maybe (Int, Int))
whereAmI = pure Nothing

covering
moveAndConfirm : Int -> Int -> IO ()
moveAndConfirm _ _ = putStrLn "FIXME moveAndConfirm"

main : IO ()
main = moveAndConfirm 100 200
