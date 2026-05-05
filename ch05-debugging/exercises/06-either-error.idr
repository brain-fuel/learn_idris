module Main

%default total

-- New idea: in Python you'd raise `ZeroDivisionError` and catch it
-- somewhere upstream. In Idris errors travel as VALUES. The standard
-- shape is `Either err val`: a result is either a `Left err` carrying
-- a description of what went wrong, or a `Right val` carrying success.
--
-- The compiler then forces you to handle BOTH cases at every consumer.
-- A missing arm in a `case` on an `Either` is a coverage error -- the
-- typechecker refuses to compile until you address it.
--
-- This file DOES handle both arms (so it typechecks), but the `Left`
-- arm is wrong: it prints the literal string `"FIXME"` instead of the
-- actual error message carried by `e`. Run it -- you'll see `FIXME` --
-- and that should jump out as a placeholder we forgot to replace.
--
-- TODO: change the `Left` arm to print `e` (the actual error message),
-- so dividing 10 by 0 prints `divide by zero`.

safeDiv : Int -> Int -> Either String Int
safeDiv x 0 = Left "divide by zero"
safeDiv x y = Right (x `div` y)

main : IO ()
main = case safeDiv 10 0 of
         Right r => printLn r
         Left e  => putStrLn "FIXME"
