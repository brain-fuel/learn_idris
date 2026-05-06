module Main

%default total

-- New idea: shells like bash interpret characters such as spaces, quotes,
-- and `$` specially. When we hand a string to `system`, we usually want
-- the shell to treat it as ONE argument with NO substitution.
--
-- The simplest defense is single quotes: `'hello world'` is one argument,
-- and the shell does no expansion inside. (This chapter assumes the input
-- itself contains no embedded single quotes.)
--
-- TODO: wrap the input string in single quotes. For example,
--       `shellQuote "hello world"` should return `"'hello world'"`.
--       Replace the placeholder so the test below prints `'hello world'`.

shellQuote : String -> String
shellQuote s = ""

main : IO ()
main = putStrLn (shellQuote "hello world")
