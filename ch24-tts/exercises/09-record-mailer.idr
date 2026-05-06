module Main

%default total

-- New idea: when a function takes a small bag of related values, a
-- record makes the call sites readable. Here our "speak request" has
-- two fields:
--
--   record SpeakReq where
--     constructor MkSpeakReq
--     text    : String
--     outFile : String
--
-- TODO: build a `SpeakReq` whose `text` is `"hello world"` and whose
--       `outFile` is `"/tmp/learn_idris_ch24_speech.wav"`. Replace the
--       `MkSpeakReq "" ""` placeholder.

record SpeakReq where
  constructor MkSpeakReq
  text    : String
  outFile : String

defaultReq : SpeakReq
defaultReq = MkSpeakReq "" ""

main : IO ()
main = do
  let r = defaultReq
  putStrLn ("text:    " ++ r.text)
  putStrLn ("outFile: " ++ r.outFile)
