module Main

import Data.String

%default total

pad2 : Int -> String
pad2 n =
  let s = show n in
  if length s < 2 then "0" ++ s else s

fmtTime : Int -> String
fmtTime t =
  let h = t `div` 3600
      m = (t `mod` 3600) `div` 60
      s = t `mod` 60
  in pad2 h ++ ":" ++ pad2 m ++ ":" ++ pad2 s

main : IO ()
main = putStrLn (fmtTime 3725)
