module Main

%default total

-- New idea: meet `?holes`. A hole is a placeholder that says "I don't
-- know what goes here yet -- compiler, please tell me." It's the most
-- powerful single tool in the Idris debugging toolbox.
--
-- The compiler ACCEPTS holes -- `idris2 --check` succeeds with only a
-- warning. So the file below typechecks, but it doesn't have a runnable
-- `main`: trying to execute it would get stuck at the hole. The program
-- is incomplete, not broken.
--
-- Workflow:
--   1. Load this file in the REPL:  idris2 04-the-hole.idr
--   2. Ask the type of `fix`:        :t fix
--   3. The REPL prints the expected type AND the local context (what
--      names are in scope, with their types). For `?fix` below, it
--      will tell you `fix` must be a `String`.
--   4. Replace `?fix` with a value of that type. Save. Reload. Done.
--
-- TODO: replace `?fix` with the string literal "Hello, " so the program
-- prints `Hello, world`.

greet : String -> String
greet name = ?fix ++ name

main : IO ()
main = putStrLn (greet "world")
