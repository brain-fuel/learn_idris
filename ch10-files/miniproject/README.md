# Mini-project: Daily Journal Helper

You'll build a tiny file-backed journal: append timestamped entries from a REPL, list them back, or wipe the file clean.

## What it should do

The program reads commands from stdin, one line at a time, and loops until it sees `quit` or end-of-input. Entries are stored in a plain text file at `/tmp/learn_idris_ch10_journal.txt`.

- `add SOMETHING` → append `<unix-timestamp> SOMETHING\n` to the file, print `entry added: SOMETHING` to stdout.
- `show` → read the file and print its contents (or `(journal empty or missing)` if the file isn't there).
- `clear` → truncate the file, print `journal cleared`.
- `quit` (or empty line) → exit.
- Anything else → `?`.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
journal cleared
entry added: wrote chapter 9
entry added: fixed bug in parser
1715000000 wrote chapter 9
1715000005 fixed bug in parser
```

(Timestamps will differ on your machine — the test only checks for the entry text, not the exact integer.)

## Where to write your code

Open `solution.idr`. The REPL `loop` and `journalPath` are already in place. Three `-- TODO` blocks:

1. **`addEntry text`.** Get the time with `seconds <$> clockTime UTC` (you saw this in exercise 09 — `import System.Clock`). Build the line `show t ++ " " ++ text ++ "\n"`. Append it via `appendFile journalPath line`. Print `"entry added: " ++ text`.
2. **`showJournal`.** `readFile journalPath` and `putStr` the contents. On `Left`, print `(journal empty or missing)`.
3. **`clearJournal`.** `writeFile journalPath ""` and print `journal cleared`.

You'll use:

- `appendFile`, `readFile`, `writeFile` from `System.File`.
- `clockTime UTC` and `seconds` from `System.Clock`.
- The `Right …` / `| Left e => …` pattern for IO error handling.

The `partial` keyword on `loop` and `main` is correct — `loop` recurses on user input, so Idris can't prove totality.

## How to test

Run it manually:

```bash
idris2 --no-banner --exec main solution.idr
# type: clear, add hello, add world, show, quit
```

Then run the automatic test from the repo root:

```bash
make verify-ch10
```

The test deletes the journal file first, then pipes the fixture (`clear / add wrote chapter 9 / add fixed bug in parser / show / quit`) and checks the output contains `entry added: wrote chapter 9`, `entry added: fixed bug in parser`, the entry text echoed by `show`, and `journal cleared`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is remembering that `addEntry` writes to **both** the file (the timestamped line) and stdout (the `entry added:` confirmation) — the test checks both.
