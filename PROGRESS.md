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
- [ ] ch09 — Pattern matching *(substitute for regex: parser combinators)*
- [ ] ch10 — Reading & writing files *(`System.File`)*
- [ ] ch11 — Organizing files *(`System.Directory`, shell out for mv/cp)*
- [ ] ch12 — Designing CLI programs *(`System.getArgs`, exit codes)*
- [ ] ch13 — Web scraping *(pack `http` + parser-combinator HTML matcher)*
- [ ] ch14 — Spreadsheets *(substitute: TSV via pack `parser-tsv`)*
- [ ] ch15 — Google Sheets *(REST via pack `http` + `json`)*
- [ ] ch16 — SQLite *(shell out to `sqlite3` binary)*
- [ ] ch17 — PDF / Word *(generate Markdown + shell out to `pandoc`)*
- [ ] ch18 — CSV / JSON / XML *(pack `parser-tsv`, `json`, hand-written XML)*
- [ ] ch19 — Time / scheduling *(`System.Clock`, `System.Run`)*
- [ ] ch20 — Email / notifications *(REST POST via pack `http`)*
- [ ] ch21 — Graphs & images *(write PPM by hand; pure Idris)*
- [ ] ch22 — OCR *(shell out to `tesseract`)*
- [ ] ch23 — Keyboard / mouse *(shell out to `xdotool`, Linux/WSL2 only)*
- [ ] ch24 — TTS *(shell out to `espeak-ng`)*
