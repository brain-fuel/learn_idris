module Main

import System.File

%default total

-- Miniproject (stub): xkcd-snap.
--
-- This stub typechecks but prints FIXME placeholders. The driver greps
-- for "title: xkcd: Sandwich", "image: //imgs.xkcd.com", and
-- "alt: A perfect sandwich", so as written the driver FAILS — that's
-- the red gradient.
--
-- TODO: read miniproject/fixtures/xkcd.html, parse out the <title>
-- text, the <img src> attribute, and the <img alt> attribute, then
-- print them in the format expected by the driver:
--   title: <text>
--   image: <url>
--   alt: <text>
--
-- See exercises 01-10 for the parser-combinator pieces; copy/redefine
-- them inline in this file.

covering
main : IO ()
main = do
  putStrLn "title: FIXME"
  putStrLn "image: FIXME"
  putStrLn "alt: FIXME"
