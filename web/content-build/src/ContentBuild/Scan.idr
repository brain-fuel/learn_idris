module ContentBuild.Scan

import Data.List
import Data.Maybe
import Data.String
import System.Directory
import System.File

%default total

------------------------------------------------------------------------
-- A single discovered chapter.
------------------------------------------------------------------------

public export
record Chapter where
  constructor MkChapter
  chapterNum : Nat
  slug       : String         -- kebab, e.g. "ch00-hello"
  title      : String         -- first '# ' line of README, prefix stripped
  readmePath : String         -- absolute path to README.md

------------------------------------------------------------------------
-- Slug parsing: "ch00-hello" -> Just (0, "ch00-hello")
-- Strict: dirname must match `ch[0-9]+-.+`.
------------------------------------------------------------------------

parseDigits : List Char -> Maybe (Nat, List Char)
parseDigits cs =
  let (ds, rest) = span isDigit cs
   in case ds of
        [] => Nothing
        _  => case parseInteger {a = Integer} (pack ds) of
                Nothing => Nothing
                Just n  => Just (cast n, rest)

isChapterDir : String -> Maybe Nat
isChapterDir name =
  case unpack name of
    'c' :: 'h' :: rest =>
      case parseDigits rest of
        Just (n, '-' :: _) => Just n
        _                  => Nothing
    _ => Nothing

------------------------------------------------------------------------
-- Title extraction: first non-empty line beginning with "# ".
------------------------------------------------------------------------

stripH1 : String -> Maybe String
stripH1 line =
  let trimmed = trim line
   in if isPrefixOf "# " trimmed
        then Just (trim (substr 2 (length trimmed) trimmed))
        else Nothing

extractTitle : String -> Maybe String
extractTitle body =
  head' $ mapMaybe stripH1 (lines body)

------------------------------------------------------------------------
-- Walk one chapter dir under `root`. Returns Nothing if the dir is
-- malformed (no README, no h1).
------------------------------------------------------------------------

covering
readChapter : (root : String) -> (dirName : String) -> IO (Maybe Chapter)
readChapter root dirName =
  case isChapterDir dirName of
    Nothing => pure Nothing
    Just n  => do
      let path = root ++ "/" ++ dirName ++ "/README.md"
      Right body <- readFile path
        | Left _ => pure Nothing
      case extractTitle body of
        Nothing    => pure Nothing
        Just title => pure (Just (MkChapter n dirName title path))

------------------------------------------------------------------------
-- Walk the whole repo root. Skips entries that aren't valid chapters.
-- Sorted by chapter number.
------------------------------------------------------------------------

export covering
scanChapters : (root : String) -> IO (List Chapter)
scanChapters root = do
  Right entries <- listDir root
    | Left _ => pure []
  chs <- traverse (readChapter root) entries
  let valid = mapMaybe id chs
  pure (sortBy (\a, b => compare a.chapterNum b.chapterNum) valid)
