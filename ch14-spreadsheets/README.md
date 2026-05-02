# Chapter 14 — Spreadsheets (TSV substitute)

**You'll learn:** the Idris ecosystem has no `openpyxl` — Excel `.xlsx` files are not directly readable from pure Idris yet. This chapter substitutes **tab-separated values (TSV)**, parsed with the pack `parser-tsv` package. The exercises mirror Python's spreadsheet workflow (read, transform, sum a column, write back) but on TSV files instead of `.xlsx`.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python `openpyxl` concept             | Idris form on TSV                                    |
|---------------------------------------|------------------------------------------------------|
| `wb = load_workbook("f.xlsx")`        | `parsed <- parseTSVFile "f.tsv"`                     |
| `cell.value`                          | indexing into the parsed `List (List String)`        |
| writing: `cell.value = ...`           | rebuild the rows, `writeFile` as TSV                 |
| multiple sheets                       | one TSV per "sheet"; convention only                 |

If the learner needs *real* Excel, the workflow is: open in LibreOffice → File → Save As → TSV.

## Pack dependencies

- `parser-tsv` — TSV parser.

Configure in `ch14.ipkg`: `depends = base, parser-tsv`. Install: `pack install parser-tsv`.

## Miniproject (when authored)

Take a TSV of monthly expenses (`date<TAB>category<TAB>amount`), produce a category-totals report.
