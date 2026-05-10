# Mini-project: Tiny Task Tracker (SQLite)

You'll build a tiny todo CLI backed by a real SQLite database — by **shelling out to the `sqlite3` binary**, since Idris doesn't ship a native SQLite binding.

## Prerequisites

You need the `sqlite3` CLI on your `$PATH`. Most Linux distros ship it; on macOS it's preinstalled. The test driver pre-creates the table for you.

## What it should do

The program is a REPL that reads commands from stdin, one line at a time, until it sees `quit` or end-of-input. State lives in a SQLite file at `/tmp/learn_idris_ch16_tasks.db`.

- `add <title>` → `INSERT INTO tasks(title, done) VALUES('<title>', 0);` and print `added: <title>`.
- `list` → `SELECT id, title, done FROM tasks ORDER BY id;`, parse the TSV output, print one line per row as `id=<n> title=<t> done=<d>`.
- `done <id>` → `UPDATE tasks SET done = 1 WHERE id = <id>;` and print `marked done: <id>`.
- `quit` → print `quit` and exit. Empty line also exits.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
added: laundry
added: dishes
id=1 title=laundry done=0
id=2 title=dishes done=0
quit
```

## Where to write your code

Open `solution.idr`. The REPL `loop` and the `dbPath` / `tmpPath` constants are already wired. Three `-- TODO` blocks:

1. **`addTask title`** — build an `INSERT` SQL string, shell `sqlite3 <dbPath> "<sql>"`, print the `added:` line. Quote single-quotes in the title (`'` → `''`) to prevent SQL-injection-style breakage.
2. **`listTasks`** — shell a `SELECT` redirected to `tmpPath` (use `sqlite3 -separator '\t' …`), `readFile` the TSV back, split on `\n` then `\t`, and print one row at a time with `printRow`.
3. **`markDone idStr`** — build an `UPDATE` SQL string, shell `sqlite3`, print `marked done: <idStr>`.

You'll use:

- `System.system` to shell out (returns an exit code you can ignore for the basic flow).
- `readFile` from `System.File`.
- `Data.String.split` (call `forget` for a plain `List`).
- The `partial` keyword on `loop` and `main` (REPL recursion isn't structurally smaller).

The `quoteSql` helper in the `_key` doubles single-quotes; you'll want the same idea or a stricter one if you accept untrusted input. The fixture inputs are clean, so the basic version is enough to pass the test.

## How to test

Set up the DB once (the test driver does this for you, but you can do it manually):

```bash
rm -f /tmp/learn_idris_ch16_tasks.db
sqlite3 /tmp/learn_idris_ch16_tasks.db \
  'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, done INT);'
```

Then run it interactively:

```bash
idris2 --no-banner --exec main solution.idr
# type: add laundry, list, done 1, list, quit
```

Then run the automatic test from the repo root:

```bash
make verify-ch16
```

The test pipes the fixture (`add laundry / add dishes / list / quit`) and checks the output contains `laundry`, `dishes`, `id=`, and `quit`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is `listTasks`: shelling SQL output back through a temp file is awkward but keeps the code simple — `sqlite3 -separator '\t' … > tmp.tsv` writes the rows, then `readFile` + split-by-`\n`/`\t` parses them.
