# Mini-project: Score Statistics

You'll build a tiny grade-book summariser. The program reads five test scores and prints some statistics about them.

## What it should do

When the user runs it, the program should:

1. Read **five integer scores**, one per line, from standard input.
2. Print **five lines** of statistics:
   - `count: 5`
   - `average: <integer average>` — the sum divided by 5 (integer division, so 72 not 72.4).
   - `min: <smallest score>`
   - `max: <largest score>`
   - `passing: <how many scores are >= 60>`

Example run (using the fixture in `fixtures/input.txt`):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
count: 5
average: 72
min: 55
max: 92
passing: 4
```

The fixture inputs are `80 75 92 60 55`. Their sum is 362, so `362 \`div\` 5 = 72`. The smallest is 55, the largest is 92, and four of them (80, 75, 92, 60) are at least 60.

## Where to write your code

Open `solution.idr` in this folder. There's a starter file with three `-- TODO` blocks:

1. Build a `Vect 5 Integer` from the five values you read in (`s1`..`s5`).
2. Compute `tot`, `avg`, `lo`, `hi`, and `passing` using `sum`, integer `\`div\``, `foldr1 min`, `foldr1 max`, and `filter (>= 60) . toList`.
3. Replace the `putStrLn` lines so each one prints a real statistic.

The reading helper (`readScore`) is already done for you — it reads a line and parses an `Integer` (defaulting to `0` if the input isn't a number).

## How to test

When you think it's working, run it against the fixture from the repo root:

```bash
cat ch06-lists/miniproject/fixtures/input.txt \
  | idris2 --no-banner --exec main ch06-lists/miniproject/solution.idr
```

You should see the five lines shown in the example above.

Then run the automatic test from the repo root:

```bash
make verify-ch06
```

That typechecks your `solution.idr` (and the `_key` version) so the build stays clean.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The hardest part is usually remembering that `Vect 5 Integer` is non-empty, so `foldr1 min` and `foldr1 max` are safe.
