module Main

import System.File
import Data.String
import Data.List
import Data.List1

%default total

journalPath : String
journalPath = "ch19-time-scheduling/miniproject/fixtures/journal.txt"

pad2 : Int -> String
pad2 n =
  let s = show n in
  if length s < 2 then "0" ++ s else s

fmtMinutes : Int -> String
fmtMinutes t =
  let h = t `div` 60
      m = t `mod` 60
  in pad2 h ++ ":" ++ pad2 m

parseLine : String -> (Int, String)
parseLine line =
  case words line of
    [] => (0, "")
    (hhmm :: rest) =>
      let parts = forget (split (== ':') hhmm) in
      case parts of
        (h :: m :: _) =>
          let mins = (cast h) * 60 + cast m in
          (mins, unwords rest)
        _ => (0, unwords rest)

reportLine : (Int, String) -> (Int, String) -> String
reportLine (m1, e1) (m2, _) =
  let dt = m2 - m1 in
  fmtMinutes m1 ++ " -> " ++ fmtMinutes m2 ++
  " (" ++ show dt ++ " min) elapsed " ++ e1

renderPairs : List (Int, String) -> List String
renderPairs xs =
  map (\(a, b) => reportLine a b) (zip xs (drop 1 xs))

totalMinutes : List (Int, String) -> Int
totalMinutes xs =
  case xs of
    [] => 0
    (first :: _) =>
      case reverse xs of
        [] => 0
        (lastE :: _) => fst lastE - fst first

covering
main : IO ()
main = do
  Right text <- readFile journalPath
    | Left e => putStrLn ("error: " ++ show e)
  let ls = filter (/= "") (lines text)
  let parsed = map parseLine ls
  for_ (renderPairs parsed) putStrLn
  putStrLn ("total: " ++ show (totalMinutes parsed) ++ " min")
