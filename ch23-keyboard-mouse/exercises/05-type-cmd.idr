module Main

%default total

-- New idea: `xdotool type "hello"` types the string verbatim into the
-- focused window. The text often contains spaces, so we wrap it in
-- double quotes to keep it as a single shell argument.
-- (Assumption: the text itself does NOT contain a literal `"`. A
-- production-grade quoter would escape; here we keep it simple.)
--
-- TODO: complete `mkTypeCmd` so that
--           mkTypeCmd "hello world" == "xdotool type \"hello world\""
--       In Idris source, `\"` is a literal double-quote inside a string.

mkTypeCmd : String -> String
mkTypeCmd s = ""

main : IO ()
main = putStrLn (mkTypeCmd "hello world")
