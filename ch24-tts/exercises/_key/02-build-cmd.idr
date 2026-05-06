module Main

%default total

shellQuote : String -> String
shellQuote s = "'" ++ s ++ "'"

mkSpeakCmd : (text : String) -> (out : String) -> String
mkSpeakCmd text out =
  "espeak-ng -v en -w " ++ out ++ " " ++ shellQuote text

main : IO ()
main = putStrLn (mkSpeakCmd "hello" "/tmp/x.wav")
