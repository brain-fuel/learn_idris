module Main

%default total

-- New idea: `printLn` and `putStrLn` look similar but mean different
-- things.
--   * `putStrLn : String -> IO ()`  -- print exactly that string.
--   * `printLn  : Show a => a -> IO ()` -- call `show` first, THEN print.
--     `show "Hello"` is the literal `"\"Hello\""` -- seven characters,
--     including the surrounding quotes. So `printLn "Hello"` prints
--     `"Hello"` WITH quotes, which is rarely what you want.
--
-- Run this file as-is. It typechecks and runs, but the output has
-- quotes around `Hello` -- a tell-tale sign you reached for `printLn`
-- when you meant `putStrLn`.
--
-- TODO: change `printLn` to `putStrLn` so the output is just `Hello`,
-- with no surrounding quotes.

main : IO ()
main = printLn "Hello"
