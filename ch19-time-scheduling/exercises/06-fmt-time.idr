module Main

import Data.String

%default total

-- Exercise 06: format an Int seconds-since-midnight as HH:MM:SS
--
-- 3725 seconds -> "01:02:05"
--
-- Helpers:
--   pad2 : Int -> String     -- "5" becomes "05"
--   div  : Int -> Int -> Int -- integer division (`div`)
--   mod  : Int -> Int -> Int -- modulus (`mod`)
--
-- TODO: implement `fmtTime` so `main` prints `01:02:05` for `3725`.

pad2 : Int -> String
pad2 n =
  let s = show n in
  if length s < 2 then "0" ++ s else s

fmtTime : Int -> String
fmtTime _ = ""

main : IO ()
main = putStrLn (fmtTime 3725)
