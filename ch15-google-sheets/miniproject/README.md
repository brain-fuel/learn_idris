# Mini-project: gsheet-append (dry-run)

You'll build a tiny request builder for the Google Sheets API: read a sheet ID and a row of values, print exactly what the HTTP PUT would look like — without actually sending it.

> **Why a dry-run?** The chapter exercises walk through the real OAuth-token + Sheets v4 PUT request, but the miniproject deliberately stays offline so the test stays deterministic and you don't need a Google Cloud project to pass. The token is hard-coded to `FAKE_TOKEN`.

## What it should do

Read **one line** of stdin shaped like:

```
<spreadsheet-id> <sheet-name> <a,b,c>
```

(three space-separated tokens; the third token is a comma-separated row of cell values).

Then print three lines:

```
PUT https://sheets.googleapis.com/v4/spreadsheets/<id>/values/<sheet>!A1?valueInputOption=USER_ENTERED
Authorization: Bearer FAKE_TOKEN
Body: {"values":[["a","b","c"]]}
```

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
PUT https://sheets.googleapis.com/v4/spreadsheets/1abc/values/Sheet1!A1?valueInputOption=USER_ENTERED
Authorization: Bearer FAKE_TOKEN
Body: {"values":[["a","b","c"]]}
```

(Fixture is `1abc Sheet1 a,b,c`.)

## Where to write your code

Open `solution.idr`. The starter prints `FIXME` for every line. One large `-- TODO` block:

1. Parse the stdin line via `words` into `(id, sheetName, csv)`.
2. Build the URL with `https://sheets.googleapis.com/v4/spreadsheets/<id>/values/<sheet>!A1` plus the `?valueInputOption=USER_ENTERED` query string.
3. Build the `Authorization: Bearer FAKE_TOKEN` header.
4. Hand-roll the JSON body: split the CSV token on `,`, wrap each value in double-quotes, join with commas, wrap as `[...]`, then wrap as `{"values":[…]}`.
5. Print the three lines.

You'll use:

- `words` and `Data.String.split` (the latter returns `List1` — call `forget` for a plain `List`).
- String concatenation with `++`.
- A small custom `quote` and `joinComma` helper (the chapter exercises 05–09 build the same pieces).

## How to test

Run it manually:

```bash
echo '1abc Sheet1 a,b,c' | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch15
```

The test pipes the fixture and checks the output contains `PUT`, `values`, `Sheet1!A1`, and `Bearer`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the JSON: `{"values":[["a","b","c"]]}` is a single-row array of arrays, so you need two layers of brackets, even when there's only one row.
