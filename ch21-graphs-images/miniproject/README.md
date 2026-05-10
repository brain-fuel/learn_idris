# Mini-project: chart-from-tsv

You'll build a tiny bar-chart renderer: read a TSV of `label<TAB>value` rows, paint a 20×10 PPM-P3 image with one black bar per row on a white canvas, write the image, and print a small report.

## What it should do

Read `ch21-graphs-images/miniproject/fixtures/values.tsv`. Each row is `<label><TAB><value>`. Pick four `x`-columns (e.g. `[2, 6, 10, 14]`), pair them with the values, and paint a 20-wide × 10-tall pixel grid: white background, one black bar per value rising from the bottom. Write the image as PPM-P3 to `/tmp/learn_idris_ch21_chart.ppm`. Then print three lines:

```
wrote /tmp/learn_idris_ch21_chart.ppm
20 10
P3 sample first row: 255 255 255  255 255 255  …  (20 pixel triples)
```

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
wrote /tmp/learn_idris_ch21_chart.ppm
20 10
P3 sample first row: 255 255 255  255 255 255  …  255 255 255
```

(Fixture has 4 rows: `apples 3`, `pears 5`, `kiwis 2`, `mangoes 4`. The bars rise from the bottom row, leaving the top rows mostly white — so the "first row" of the rendered image is all white.)

## Where to write your code

Open `solution.idr`. The starter prints `wrote FIXME / 0 0 / P3 FIXME`. The grid types (`Pixel`, `Row`, `Grid`) are already declared. One large `-- TODO` block:

1. `readFile tsvPath` and parse each non-empty line into `(label, value)`.
2. Layout: `let cols = [2, 6, 10, 14]` paired with the parsed values via `zip`.
3. Build a 20×10 white canvas (`replicate 10 (replicate 20 (255, 255, 255))`).
4. Paint one black bar per `(col, height)` pair using a `bar` helper that fills a 1-wide column from `(chartH - height)` downward.
5. Serialize via an `emit` helper: `header w h ++ showGrid rows`, where `header` is `"P3\n20 10\n255\n"` and each pixel renders as `"R G B"` joined with `"  "` (two spaces).
6. `writeFile outPath body`, then print the three required lines.

You'll use:

- `readFile`, `writeFile` from `System.File`.
- `Data.String.split (== '\t')` and `cast : String -> Nat`.
- The chapter's exercises 01–09 walk through `showRow`, `paintRow`, `drawRect`, `bar`, etc.

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
xxd /tmp/learn_idris_ch21_chart.ppm | head     # peek at the bytes
```

For a real visual, convert it with ImageMagick:

```bash
convert /tmp/learn_idris_ch21_chart.ppm /tmp/chart.png && xdg-open /tmp/chart.png
```

Then run the automatic test from the repo root:

```bash
make verify-ch21
```

The test deletes the prior PPM, runs your program, and checks the output contains `wrote /tmp/learn_idris_ch21_chart.ppm`, `P3`, `20 10`, and `255`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is bar layout: PPM rows go top-to-bottom, but bars grow upward from the *bottom*, so the bar for height `h` occupies the rows from `chartH - h` through `chartH - 1` — `drawRect col (minus chartH h) 1 h black grid` does the right thing.
