module Main

import System

%default total

-- New idea: a program reads its command-line arguments via
-- `getArgs : IO (List String)`. The first element of the list is the
-- program name (just like `sys.argv[0]` in Python). The rest are the
-- arguments the user typed.
--
-- Python:    `import sys; print(sys.argv)`
-- Idris:     `args <- getArgs; printLn args`
--
-- Note: when you run `idris2 --exec main file.idr`, `getArgs` returns
-- idris2's own argv, NOT the args you might want to pass to your
-- program. Real CLIs are compiled with `idris2 -o foo file.idr` and
-- then invoked as `./build/exec/foo arg1 arg2`. We're learning the
-- shape of the function here; the full miniproject reads its config
-- from stdin to sidestep that quirk.
--
-- TODO: replace the stub below so the program prints whatever
-- `getArgs` returns. (Your output will look like
-- `["...idris2", "...", ...]` — that's fine.)

main : IO ()
main = printLn (the (List String) [])
