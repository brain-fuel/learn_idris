# Mini-project: multi-convert (CSV → JSON + XML)

You'll build a tiny format converter: read a CSV file with a header row, then print equivalent JSON and XML serializations of the same data.

## What it should do

Read the CSV at `ch18-csv-json-xml/miniproject/fixtures/contacts.csv`. The first row is the header (column names); the remaining rows are data. Print two blocks separated by markers:

```
=== JSON ===
[{"name":"Ada","email":"ada@example.com","age":"36"},{"name":"Bob",…},{"name":"Cleo",…}]
=== XML ===
<?xml version="1.0"?><contacts><contact><name>Ada</name><email>ada@example.com</email><age>36</age></contact><contact>…</contact><contact>…</contact></contacts>
```

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
=== JSON ===
[{"name":"Ada","email":"ada@example.com","age":"36"},{"name":"Bob","email":"bob@example.com","age":"29"},{"name":"Cleo","email":"cleo@example.com","age":"41"}]
=== XML ===
<?xml version="1.0"?><contacts><contact><name>Ada</name><email>ada@example.com</email><age>36</age></contact><contact><name>Bob</name><email>bob@example.com</email><age>29</age></contact><contact><name>Cleo</name><email>cleo@example.com</email><age>41</age></contact></contacts>
```

(Fixture: header `name,email,age` plus three rows for Ada/Bob/Cleo.)

## Where to write your code

Open `solution.idr`. The starter prints a single `FIXME: emit JSON and XML`. One large `-- TODO` block — the chapter's exercises 01–10 build every helper you'll reuse:

1. `readFile csvPath` to get the CSV text.
2. Parse: split on `\n` to get lines, drop empties, then split each line on `,` to get cells. The first line is the header; the rest are data rows.
3. JSON serializer: build a small `JSON` ADT (`JNull | JBoolean | JNumber | JString | JArray | JObject`), define `showJSON`, then map each row to a `JObject` zipping headers with values, wrapped in a `JArray`.
4. XML serializer: a small `xmlElement tag body` helper, then nest `<contacts><contact><field>value</field>…</contact>…</contacts>` and prepend the `<?xml version="1.0"?>` prologue.
5. Print `=== JSON ===`, then the JSON, then `=== XML ===`, then the XML.

You'll use:

- `Data.String.split` (call `forget` for a plain `List`).
- A custom `JSON` ADT with `mutual showJSON / showArr / showObj`.
- `++` to glue strings together.

The treatment is deliberately minimal — no escaping for special characters, no number-typed JSON values (everything's a string). The fixture is plain ASCII, so the test passes without escaping logic.

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch18
```

The test runs your program and checks the output contains `=== JSON ===`, `Ada`, `=== XML ===`, and `<contacts>`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the `mutual` block: `showJSON`, `showArr`, and `showObj` reference each other, so they need a single `mutual` declaration to typecheck.
