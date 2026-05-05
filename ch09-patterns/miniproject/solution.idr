module Main

import Data.String

%default total

-- Phone-number scraper starter file.
--
-- Behavior: read ALL of stdin (free-form text). Find every substring
-- that matches the US phone format `\d{3}-\d{3}-\d{4}`. Print each
-- match on its own line, in the order they appear in the input.
--
-- Sample (input on stdin):
--     Call me at 555-123-4567 anytime, or my office number is 800-555-0199.
--     For sales reach out to 415-867-5309. ignore 12-3 or 5551234567.
--
-- Expected output:
--     555-123-4567
--     800-555-0199
--     415-867-5309
--
-- TODO 1: copy in your `Parser` record + `pchar`, `pdigit`, `pseq`,
--         `pcount` (and a `digitsToStr` helper) from the exercises.
--         You may want to look at `_key/solution.idr` if you get stuck.
--
-- TODO 2: build `phone : Parser String` -- a parser that recognises
--         `\d{3}-\d{3}-\d{4}` and returns the matched 12-character
--         string. Chain four `runParser` calls (pcount 3, pchar '-',
--         pcount 3, pchar '-', pcount 4) the way `threeDashFour` did
--         in exercise 10.
--
-- TODO 3: write `findAll : List Char -> List String` that slides
--         over the input one character at a time, trying `phone` at
--         each position. On a hit, emit the match and skip past it;
--         otherwise advance by one. Mark it `partial` -- structural
--         recursion on `List Char` makes this fine, but the totality
--         checker may complain about the `drop (length …)` step.
--
-- TODO 4: in `main`, slurp all of stdin (a loop over `getLine` until
--         `fEOF stdin` is true -- import `System.File.Virtual`),
--         then run `findAll` on the unpacked contents and print each
--         match with `putStrLn`.

main : IO ()
main = do
  _ <- getLine -- swallow input so the test driver doesn't hang
  _ <- getLine
  putStrLn "FIXME"
  putStrLn "FIXME"
  putStrLn "FIXME"
