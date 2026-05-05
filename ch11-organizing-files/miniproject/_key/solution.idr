module Main

import System
import System.Directory
import Data.String
import Data.List

%default total

extension : String -> String
extension s =
  let cs = unpack s in
  case break (== '.') (reverse cs) of
    (revExt, '.' :: _) => toLower (pack ('.' :: reverse revExt))
    _ => ""

classify : String -> String
classify f =
  let e = extension f in
  if e == ".jpg" || e == ".jpeg" || e == ".png" || e == ".heic" then "images"
  else if e == ".mov" || e == ".mp4" then "video"
  else if e == ".txt" || e == ".md" then "notes"
  else "other"

isCategoryDir : String -> Bool
isCategoryDir n =
  n == "images" || n == "video" || n == "notes" || n == "other"

organizeOne : (root : String) -> (name : String) -> IO ()
organizeOne root name = do
  let cat = classify name
  let target = root ++ "/" ++ cat
  _ <- system ("mkdir -p " ++ target)
  _ <- system ("mv " ++ root ++ "/" ++ name ++ " " ++ target ++ "/" ++ name)
  putStrLn ("moved " ++ name ++ " -> " ++ cat ++ "/" ++ name)

main : IO ()
main = do
  root <- getLine
  Right entries <- listDir root
    | Left e => putStrLn ("error: " ++ show e)
  -- skip category dirs created on previous runs
  let files = filter (not . isCategoryDir) (sort entries)
  for_ files (organizeOne root)
