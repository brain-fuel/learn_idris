module Main

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

main : IO ()
main = do
  Right entries <- listDir "ch11-organizing-files/exercises/fixtures/dir01"
    | Left _ => putStrLn "error"
  for_ (sort entries) $ \e =>
    putStrLn (e ++ " -> " ++ classify e)
