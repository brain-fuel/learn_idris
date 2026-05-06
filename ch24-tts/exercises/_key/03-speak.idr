module Main

import System

%default total

shellQuote : String -> String
shellQuote s = "'" ++ s ++ "'"

mkSpeakCmd : (text : String) -> (out : String) -> String
mkSpeakCmd text out =
  "espeak-ng -v en -w " ++ out ++ " " ++ shellQuote text

covering
speak : (text : String) -> (out : String) -> IO Int
speak text out = System.system (mkSpeakCmd text out)

covering
main : IO ()
main = do
  code <- speak "hello" "/tmp/learn_idris_ch24_ex03.wav"
  putStrLn ("exit: " ++ show code)
