module Main

%default total

-- New idea: a "string" is text inside double quotes "...". Idris treats it as
-- one piece. (Single quotes '...' are for ONE character, not a string.)
--
-- TODO: change the sentence to anything you want. Keep the double quotes.

main : IO ()
main = putStrLn "I am learning Idris."
