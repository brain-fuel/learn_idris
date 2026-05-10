# Mini-project: clock-report

You'll build a tiny time-tracker report: read a journal of timestamped events, compute the gap between consecutive entries, print one line per gap and a grand total.

## What it should do

Read `ch19-time-scheduling/miniproject/fixtures/journal.txt`. Each line is `HH:MM <event-label>`. For each **consecutive pair** of lines, print:

```
<HH:MM-1> -> <HH:MM-2> (<N> min) elapsed <label-1>
```

Then a final line:

```
total: <N> min
```

The label on each report line is from the **first** timestamp of the pair. The last line in the journal acts only as the closing timestamp for the previous entry.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
09:00 -> 09:25 (25 min) elapsed start
09:25 -> 09:30 (5 min) elapsed break
09:30 -> 10:00 (30 min) elapsed resume
10:00 -> 10:45 (45 min) elapsed lunch
total: 105 min
```

(Fixture: 5 lines from `09:00 start` through `10:45 done`. Total elapsed: `10:45 - 09:00 = 105 min`.)

## Where to write your code

Open `solution.idr`. The starter prints a single FIXME line. One large `-- TODO` block — the chapter's exercises 06–10 build the helpers you need:

1. `readFile journalPath` to get the text.
2. Filter empty lines, then `parseLine` each one into `(minutes-since-midnight, event-label)`. Use `Data.String.split (== ':')` for the `HH:MM` half.
3. Walk consecutive pairs (`zip xs (drop 1 xs)`), formatting each pair with a `reportLine` helper that prints `HH:MM -> HH:MM (N min) elapsed <label>`.
4. Compute the total as `last-timestamp - first-timestamp` (in minutes).
5. Print each report line, then the `total:` line.

You'll use:

- `readFile` and `lines` from `System.File` / `Data.String`.
- `Data.String.split` (returns `List1`; call `forget`).
- `cast : String -> Int` for the digit parsing.
- A small `pad2` helper so `9:0` renders as `09:00`.

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch19
```

The test runs your program and checks the output contains `09:00`, `elapsed`, and `total: 105`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the pairing: `zip xs (drop 1 xs)` gives consecutive `(prev, next)` pairs, so you don't need explicit recursion to walk the list two-at-a-time.
