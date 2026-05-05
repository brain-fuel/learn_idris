module Main

import System.File
import Data.String

%default covering

-- New idea: combine file IO with `lines : String -> List String` (which
-- you met in ch08). Together they let you process a file line-by-line.
--
-- The stub below reads the file and prints the raw contents unchanged.
--
-- TODO: split the contents with `lines`, then print each line prefixed
--       with its 1-based index, like:
--           1: apple
--           2: banana
--           3: cherry
--       Hint: `for_ (zip [the Nat 1..length ls] ls) $ \(i, l) =>
--               putStrLn (show i ++ ": " ++ l)`.

main : IO ()
main = do
  Right s <- readFile "ch10-files/exercises/fixtures/three-lines.txt"
    | Left _ => putStrLn "could not open file"
  putStr s
