# Mini-project: Invoice Generator (Markdown → PDF)

You'll build a tiny invoice generator: read a TSV of line items, render a Markdown invoice with a totals table, then shell out to `pandoc` to produce a PDF.

## Prerequisites

You need `pandoc` on your `$PATH` (and a TeX distribution for the PDF backend — `pandoc` will tell you if something's missing). On Debian/Ubuntu: `sudo apt install pandoc texlive-xetex`.

## What it should do

Read the TSV at `ch17-pdf-word/miniproject/fixtures/items.tsv`. Each row is `<qty><TAB><description><TAB><unit-price>`. Then:

1. Parse each row into an `Item` record.
2. Build a Markdown document: an `# Invoice` heading, a four-column table (`qty | desc | unit | line total`), and a `Total: $<grand-total>` line.
3. `writeFile /tmp/learn_idris_ch17_invoice.md` with the document.
4. `system "pandoc /tmp/learn_idris_ch17_invoice.md -o /tmp/learn_idris_ch17_invoice.pdf"`.
5. Confirm the PDF exists, then print exactly `wrote /tmp/learn_idris_ch17_invoice.pdf`.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
wrote /tmp/learn_idris_ch17_invoice.pdf
```

(Fixture has 3 rows: `2 Widget 10.00`, `1 Gizmo 25.50`, `3 Thingamajig 5.00`. Line totals: `20.00`, `25.50`, `15.00`. Grand total: `60.50`.)

## Where to write your code

Open `solution.idr`. The starter prints `wrote FIXME` so the test fails until you wire up the real flow. Six `-- TODO` blocks:

1. `readFile tsvPath` to get the TSV text.
2. Parse each non-empty row into `(qty, desc, unitPrice)`. Use `Data.String.split (== '\t')` (it returns `List1`; `forget` it).
3. Build the Markdown — heading, table (header row, separator `|---|---|---|---|`, one row per item), then a `Total: $XX.XX` line.
4. `writeFile mdPath document` (mark the writer `covering` since `writeFile` is `covering`).
5. `code <- System.system ("pandoc " ++ mdPath ++ " -o " ++ pdfPath)`.
6. If `code == 0` and `exists pdfPath`, print `wrote <pdfPath>`; otherwise print an error.

You'll use:

- `Data.String.split`, `parseInteger`, `parseDouble`.
- `System.File.writeFile` and `System.File.exists`.
- `System.system` for the pandoc invocation.
- A 2-decimal `fmt2` helper (`show 25.5` gives `"25.5"`, but invoices want `"25.50"`).

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
xdg-open /tmp/learn_idris_ch17_invoice.pdf   # or `open` on macOS
```

Then run the automatic test from the repo root:

```bash
make verify-ch17
```

The test deletes the prior `.md` and `.pdf` first, runs your program, and checks the output contains `wrote /tmp/learn_idris_ch17_invoice.pdf`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the cents formatter: `cast (d * 100.0 + 0.5) : Integer` rounds to the nearest cent, then `divMod 100` splits it back into dollars and cents — the `+ 0.5` is what stops `1.495` from rendering as `1.49`.
