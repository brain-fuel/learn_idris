# Progress

Tick a chapter when **all four** are true:

1. Every `exercises/*.idr` you wrote typechecks and runs without errors.
2. `miniproject/solution.idr` runs and prints the right thing.
3. `make verify-chNN` is green.
4. You can explain in your own words what you learned.

## Chapters

- [ ] **ch00 — Hello**: open a terminal, edit a file, run an Idris program.
- [ ] **ch01 — Basics**: `putStrLn`, numbers, strings, `let` bindings, `getLine`.
- [ ] **ch02 — Flow control**: `if/then/else` (expression), `case ... of`, guards via Bool tuples.
- [ ] **ch03 — Loops**: `for_`, `traverse_`, ranges, structural recursion, `foldl`.
- [ ] **ch04 — Functions**: type signatures, currying, records as default args, custom data types.
- [ ] **ch05 — Debugging**: `?holes`, type-driven dev, REPL, `printLn`-as-trace.
- [ ] **ch06 — Lists**: `List a` vs `Vect n a`, `head'` returning `Maybe`, immutability.
- [ ] **ch07 — Dictionaries**: `SortedMap`, records, REPL-style state via `partial`.
- [ ] **ch08 — Strings**: `Data.String`, `pack`/`unpack`, `split` returning `List1`.
- [ ] **ch09 — Pattern matching**: parser combinators built from `Parser a = String -> Maybe (a, String)`; `pchar`/`pany`/`pseq`/`palt`/`pcount`/`many`.
- [ ] **ch10 — Reading & writing files**: `System.File`, `Either FileError` with the `Right/Left` with-pattern, `clockTime UTC`.
- [ ] **ch11 — Organizing files**: `System.Directory` (no `isDirectory`), classification by extension, shell-out via `System.system`.
- [ ] **ch12 — Designing CLI programs**: `getArgs`, `exitWith`, hand-rolled flag parser, stdin-flag workaround for `--exec` mode.
- [ ] **ch13 — Web scraping**: parser combinators applied to HTML; `Network.HTTP.Client` from pack `http`; deterministic test via local fixture.
- [ ] **ch14 — Spreadsheets**: hand-rolled TSV parser, `SortedMap` aggregation, two-decimal formatting.
- [ ] **ch15 — Google Sheets**: dry-run Sheets v4 PUT body via contrib `Language.JSON` + pack `http` types.
- [ ] **ch16 — SQLite**: shell out to `sqlite3 -separator $'\t'`, parse TSV result, REPL with `partial`.
- [ ] **ch17 — PDF / Word**: generate Markdown from a TSV, shell out to `pandoc`, check the artifact.
- [ ] **ch18 — CSV / JSON / XML**: hand-rolled CSV + XML, contrib `Language.JSON` for serialization.
- [ ] **ch19 — Time & scheduling**: `System.Clock`, `sleep`, journal-of-timestamps `clockReport`.
- [ ] **ch20 — Email**: dry-run Mailgun POST body, URL-encoding, pack `http` import.
- [ ] ch21 — Graphs & images *(write PPM by hand; pure Idris)*
- [ ] ch22 — OCR *(shell out to `tesseract`)*
- [ ] ch23 — Keyboard / mouse *(shell out to `xdotool`, Linux/WSL2 only)*
- [ ] ch24 — TTS *(shell out to `espeak-ng`)*
