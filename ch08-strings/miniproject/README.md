# Mini-project: Word-Frequency Histogram

You'll build a tiny histogram tool: read a line of text, count how often each word appears, print a sorted report.

## What it should do

Read **one line** of stdin. Lowercase it, treat the punctuation `,`, `.`, `!`, `?` as if it were a space, then split on whitespace. Count occurrences of each word. Print one word per line as `WORD: N`, sorted **descending by count**, then **ascending by word** as a tiebreaker.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
the: 3
fox: 2
brown: 1
dog: 1
lazy: 1
quick: 1
```

(Input was `the quick brown fox. the lazy dog. the fox.`)

## Where to write your code

Open `solution.idr`. The plumbing — `cleanChar`, `clean`, `countWords`, the `main` pipeline — is already wired up. Two `-- TODO` blocks remain:

1. **`bump w m`** currently returns the map unchanged. Rewrite it as `case lookup w m of` so a missing word starts at `1` and an existing word's count is incremented by `1`.
2. **`formatPairs ps`** currently returns `[]`. Replace with a `sortBy` call followed by `map (\(w, n) => w ++ ": " ++ show n)`. The lambda for `sortBy`:

   ```idris
   \(w1, n1), (w2, n2) =>
       case compare n2 n1 of
         EQ => compare w1 w2
         o  => o
   ```

   `n2`/`n1` (note the order) gives descending counts; `compare w1 w2` breaks ties alphabetically.

You'll use:

- `pack . map f . unpack` to apply a `Char -> Char` function to every character in a `String`.
- `Data.SortedMap` (`empty`, `insert`, `lookup`, `Data.SortedMap.toList`).
- `Data.List.sortBy`.

## How to test

Run it manually:

```bash
echo 'the quick brown fox. the lazy dog. the fox.' \
  | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch08
```

The test pipes the fixture into your program and checks all six output lines (`the: 3`, `fox: 2`, `brown: 1`, `dog: 1`, `lazy: 1`, `quick: 1`) appear.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the `compare n2 n1` (not `n1 n2`) — that flip is what makes the result descending.
