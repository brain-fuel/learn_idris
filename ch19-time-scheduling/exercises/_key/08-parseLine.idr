module Main

import Data.String
import Data.List1

%default total

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

main : IO ()
main = do
  let (m, e) = parseLine "09:25 break"
  putStrLn (show m ++ " " ++ e)
