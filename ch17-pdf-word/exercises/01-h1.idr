module Main

%default total

-- New idea: Markdown headings start with `# ` (one hash + a space) for
-- H1, `## ` for H2, and so on. There is no Idris ecosystem `python-docx`
-- — the substitute is to GENERATE Markdown text, then shell out to
-- `pandoc` later to convert it to PDF/DOCX/HTML.
--
-- TODO: complete `mkH1` so that
--           mkH1 "Hello"  ==  "# Hello"
--       (just a string concat — no IO yet).

mkH1 : String -> String
mkH1 s = s

main : IO ()
main = putStrLn (mkH1 "Hello")
