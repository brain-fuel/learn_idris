module Main

%default total

-- Exercise 04: drop rows that are empty or just one empty field.
--
-- After splitting on '\n', a trailing newline produces a row like [""]
-- (a single empty field). We don't want that polluting our totals.
--
-- TODO: replace the body so empty rows AND single-empty-field rows
-- ([""]) are filtered out. Hint: `filter` over `rows`.

skipEmpty : List (List String) -> List (List String)
skipEmpty rows = rows

main : IO ()
main = do
  let rs = [["a","b"], [], [""], ["c","d"]]
  putStrLn (show (skipEmpty rs))
