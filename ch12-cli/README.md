# Chapter 12 — Designing CLI Programs

**You'll learn:** how to read command-line arguments with `getArgs`, design a tiny argument record, parse it, and exit with the right code. Idris's stdlib doesn't ship a `argparse`-like helper — you write the parser yourself, which is short and explicit.

## Idris realization

| Python concept                  | Idris form                                                  |
|---------------------------------|-------------------------------------------------------------|
| `import sys; sys.argv`          | `getArgs : IO (List String)` (first element is program name) |
| `argparse.ArgumentParser()`     | hand-roll: a record, then a parsing function                |
| `sys.exit(1)`                   | `exitWith (ExitFailure 1)`                                  |
| `sys.stdin.read()`              | `getContents` or `getLine` in a loop                        |
| `print(..., file=sys.stderr)`   | `ignore $ fPutStrLn stderr "..."` (from `System.File.Virtual`) |

> **`getArgs` caveat:** when running via `idris2 --exec main file.idr`, `getArgs` returns idris2's own argv, not your program's args. The miniproject sidesteps this by reading flags from stdin as a single line; the exercises still teach `getArgs` so you see the real signature.

Headline shift: write your own arg parser. It's 30 lines and matches your problem exactly.

## Pack dependencies

None.

## Miniproject (when authored)

Build a `ic` (image-converter) tool: `ic --in foo.ppm --out foo.txt --invert` reads a PPM, optionally inverts pixel intensities, writes ASCII art. Practices arg parsing, file I/O, exit codes.
