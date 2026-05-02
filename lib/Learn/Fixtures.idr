module Learn.Fixtures

import System.File

%default total

||| Resolve a fixture path relative to a chapter directory.
||| Used by chapter tests so they can run from any cwd.
||| Example: `fixturePath "ch01-basics" "input.txt"` ->
|||   "ch01-basics/miniproject/fixtures/input.txt".
export
fixturePath : (chapterDir : String) -> (fileName : String) -> String
fixturePath chapterDir fileName =
  chapterDir ++ "/miniproject/fixtures/" ++ fileName

||| Read a fixture file. Marked `partial` because `readFile` reads until EOF
||| and the type system can't prove EOF will arrive.
export partial
readFixture : (path : String) -> IO (Either String String)
readFixture path = do
  result <- readFile path
  case result of
    Right contents => pure (Right contents)
    Left  err      => pure (Left ("could not read " ++ path ++ ": " ++ show err))
