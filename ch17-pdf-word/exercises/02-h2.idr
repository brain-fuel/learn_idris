module Main

%default total

-- New idea: same trick as H1, but two hashes. Building Markdown is just
-- string composition — there's nothing to "open" or "close".
--
-- TODO: complete `mkH2` so that
--           mkH2 "Section" == "## Section"

mkH2 : String -> String
mkH2 _ = ""

main : IO ()
main = putStrLn (mkH2 "Section")
