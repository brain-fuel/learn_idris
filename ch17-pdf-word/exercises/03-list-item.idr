module Main

%default total

-- New idea: a Markdown bullet item is `- ` followed by the text. Each
-- item lives on its own line; the LIST itself is just newline-joined
-- items (we'll do that in exercise 04).
--
-- TODO: complete `mkItem` so that
--           mkItem "milk" == "- milk"

mkItem : String -> String
mkItem s = s

main : IO ()
main = putStrLn (mkItem "milk")
