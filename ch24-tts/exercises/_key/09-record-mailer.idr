module Main

%default total

record SpeakReq where
  constructor MkSpeakReq
  text    : String
  outFile : String

defaultReq : SpeakReq
defaultReq = MkSpeakReq "hello world" "/tmp/learn_idris_ch24_speech.wav"

main : IO ()
main = do
  let r = defaultReq
  putStrLn ("text:    " ++ r.text)
  putStrLn ("outFile: " ++ r.outFile)
