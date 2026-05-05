module Main

import System.File
import Data.String

%default total

-- New idea: a P3 PPM file is just plain text. Its header is
--     P3
--     <width> <height>
--     <maxval>
-- and then `width * height * 3` integers (R, G, B per pixel) follow,
-- separated by whitespace. (Real PPMs may also contain `# comment`
-- lines, but our fixture has none.)
--
-- A throwaway parse: tokenize the entire file with `words`, then the
-- first four tokens are the magic number, width, height, and
-- maxval.
--
-- TODO: read `ch12-cli/exercises/fixtures/tiny.ppm` with `readFile`,
-- tokenize with `words`, and print the width, height, and maxval
-- separated by spaces. The fixture's correct answer is `3 2 255`.
--
-- (Hint: case-match on `readFile`'s `Either FileError String` result;
-- on success, pattern-match the first four tokens like
-- `("P3" :: w :: h :: m :: _)`.)

main : IO ()
main = putStrLn "0 0 0"
