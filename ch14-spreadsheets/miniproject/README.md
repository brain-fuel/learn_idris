# Mini-project: Expense Reporter

You'll build a tiny TSV summariser: read a transaction log, group by category, print per-category subtotals plus a grand total formatted to two decimal places.

## What it should do

Read the TSV at `ch14-spreadsheets/miniproject/fixtures/expenses.tsv`. Each row is `<date><TAB><category><TAB><amount>` (no header). Group rows by category, sum the amounts, then print:

- One line per category: `<category>\t<sum-with-2-decimals>`.
- A final `TOTAL\t<grand-total>` line.

Output is tab-separated; categories are emitted in alphabetical order (the underlying `SortedMap` keeps them sorted).

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
entertainment	30.00
food	150.50
transport	87.25
TOTAL	267.75
```

(Fixture has 6 rows: three food entries summing to `150.50`, two transport entries summing to `87.25`, one entertainment row at `30.00`. `fixtures/input.txt` is a `go` trigger so the program's `getLine` doesn't block.)

## Where to write your code

Open `solution.idr`. The plumbing — `splitOnTab`, `parseAmount`, the `main` pipeline — is already wired. One large `-- TODO` block covering four helpers:

1. **`rowsFromText`** — split the file by newline, then each line by tab. Drop empty rows.
2. **`catAndAmount`** — pattern-match a 3-element row `[date, cat, amt]` to `Just (cat, parseAmount amt)`.
3. **`groupByCategory`** — `foldl` a `bump` step that adds the amount into a `SortedMap String Double`.
4. **`renderReport`** — `Data.SortedMap.toList` the totals, format each pair with a custom 2-decimal formatter (`fmt2`), then append the `TOTAL` line.

You'll use:

- `Data.String.split` (returns `List1`; call `forget` to get a plain `List`).
- `Data.SortedMap` (`empty`, `insert`, `lookup`, `Data.SortedMap.toList`).
- `cast : String -> Double` for the amount parser.
- A small custom formatter that multiplies by 100, rounds to integer cents, then re-glues the dollars and cents (Idris's stock `show` for `Double` prints e.g. `150.5`, not `150.50`).

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch14
```

The test runs your program and checks the output contains `food`, `transport`, `entertainment`, `TOTAL`, and `267.75`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is `fmt2`: `show 150.5` gives `"150.5"`, which the test won't accept; you have to render the cents manually so `0.50` shows as `0.50`, not `0.5`.
