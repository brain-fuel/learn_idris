module Main

%default total

-- New idea: building shell commands is just String concatenation. We
-- compose the espeak-ng invocation as
--
--     espeak-ng -v en -w <out>  '<text>'
--
-- where `-v en` selects English, `-w <out>` writes a WAV file (instead
-- of the speakers), and the quoted text is what to speak.
--
-- TODO: implement `mkSpeakCmd` so it returns the full command string.
--       Reuse `shellQuote` to wrap the text. Replace the `""` placeholder.

shellQuote : String -> String
shellQuote s = "'" ++ s ++ "'"

mkSpeakCmd : (text : String) -> (out : String) -> String
mkSpeakCmd text out = ""

main : IO ()
main = putStrLn (mkSpeakCmd "hello" "/tmp/x.wav")
