module Main

import System

%default total

-- New idea: pandoc is the lingua-franca document converter. Given a
-- Markdown file, it can emit PDF, DOCX, HTML, EPUB, ... We invoke it
-- via `System.system`, which returns the exit code.
--
-- NOTE the qualified name `System.system "..."` — bare `system "..."`
-- is ambiguous with `System.Escaped.system : List String -> IO Int`,
-- which takes a list, not a String.
--
-- TODO: replace `pure 0` so this exercise actually shells out to
--           pandoc /tmp/learn_idris_ch17_ex09.md -o /tmp/learn_idris_ch17_ex09.pdf
--       and then `printLn` the exit code. (Make sure
--       `/tmp/learn_idris_ch17_ex09.md` exists first — exercise 08
--       wrote a file to a similar path you can adapt, or just
--       `writeFile` a one-liner here in `main`.)

main : IO ()
main = do
  code <- (the (IO Int) (pure 0))
  printLn code
