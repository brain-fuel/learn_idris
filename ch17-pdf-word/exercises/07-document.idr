module Main

import Data.String

%default total

-- New idea: a Markdown DOCUMENT is just sections concatenated with a
-- BLANK LINE between them — i.e. `\n\n`. Headings, paragraphs, lists,
-- and tables are all just strings; gluing them this way is the whole
-- "document model".
--
-- TODO: complete `document` so that
--           document ["# Title", "Hello.", "- one", "- two"]
--             == "# Title\n\nHello.\n\n- one\n- two"
--       Hint: `joinBy "\n\n" sections` does it in one line. `joinBy`
--       lives in `Data.String`.

document : List String -> String
document _ = ""

main : IO ()
main = putStrLn (document ["# Title", "Hello.", "- one", "- two"])
