module Main

import System.Directory
import Data.List

%default total

-- New idea: `listDir` does not promise any particular order — the OS
-- returns entries in whatever order it likes, often based on inode
-- creation. For predictable output (and for tests), `sort` it.
-- `sort : Ord a => List a -> List a` lives in `Data.List`.
--
-- TODO: listDir `ch11-organizing-files/exercises/fixtures/dir01` and
--       print the entries sorted alphabetically. On `Left`, print
--       `error`.

main : IO ()
main = printLn (the (List String) [])
