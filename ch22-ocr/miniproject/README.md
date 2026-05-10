# Mini-project: Receipt Scanner (OCR via tesseract)

You'll build a tiny receipt parser: shell out to `tesseract` to OCR a receipt image, find the line that says `TOTAL`, extract the dollar amount, and print it formatted to two decimals.

## Prerequisites

You need the `tesseract` CLI (and the `eng` language data) on your `$PATH`. On Debian/Ubuntu: `sudo apt install tesseract-ocr`. Idris doesn't ship a native OCR library, so this miniproject is a shell-out wrapper.

## What it should do

OCR the image at `ch22-ocr/miniproject/fixtures/receipt.png` and print two lines:

```
ocr'd <N> lines
total: $<XX.XX>
```

`<N>` is the count of non-empty OCR'd lines. `<XX.XX>` is the dollar amount on the line containing `TOTAL`, formatted to two decimal places. If no `TOTAL` line is found, print `total: no total found` instead.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
ocr'd 7 lines
total: $42.99
```

(`fixtures/receipt.png` is a small synthetic receipt image with a `TOTAL: $42.99` line. Line counts vary slightly with the OCR engine version — that's why the test only pins the `total: $42.99` substring.)

## Where to write your code

Open `solution.idr`. The starter prints `ocr'd 0 lines / total: $FIXME`. Five `-- TODO` blocks:

1. Build a tesseract command string — `tesseract <imgPath> <outStem> -l eng 2>/dev/null` — and run it with `System.system`. Qualify the call (`System.system`) so it doesn't clash with `System.Escaped.system` if you import both.
2. On non-zero exit code, print an error and stop.
3. On success, `readFile (outStem ++ ".txt")` (tesseract appends `.txt` to whatever `outStem` you give it). Split with `lines` and filter out empty lines for the count.
4. Find the line containing `"TOTAL"` with `find (isInfixOf "TOTAL")`. Split that line on `'$'`, take the last segment, `parseDouble` after `trim`.
5. Print the two output lines: `ocr'd <count> lines` and either `total: $<fmt2 amount>` or `total: no total found`.

You'll use:

- `System.system` from `System`.
- `readFile`, `Data.String.lines`, `Data.String.trim`.
- `Data.List.find` and `Data.String.isInfixOf`.
- A 2-decimal `fmt2` helper (the chapter exercises walk through it).

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
```

You can sanity-check tesseract independently:

```bash
tesseract fixtures/receipt.png /tmp/manual_check -l eng
cat /tmp/manual_check.txt
```

Then run the automatic test from the repo root:

```bash
make verify-ch22
```

The test deletes the prior OCR text file, runs your program, and checks the output contains `total: $42.99`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the `$`-extraction: `split (== '$') line` returns segments around each `$`, so a line like `TOTAL: $42.99` splits into `["TOTAL: ", "42.99"]` — the **last** segment is the price. `last'` (the safe variant returning `Maybe`) does that without exploding on a missing `$`.
