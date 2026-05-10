# Mini-project: xkcd-snap

You'll build a tiny HTML scraper: read a saved xkcd.com snapshot, extract the comic title, image URL, and alt text using parser combinators.

> **Note:** the chapter README's miniproject paragraph hints at fetching `https://xkcd.com` over the network. The actual project (and reference solution) reads a **committed snapshot** at `fixtures/xkcd.html` instead — that keeps the test offline-deterministic and avoids depending on xkcd's live HTML. The chapter exercises do cover real `Network.HTTP.Client.get` calls; the miniproject focuses on the parsing half.

## What it should do

Read the saved HTML at `ch13-web-scraping/miniproject/fixtures/xkcd.html`. Extract three things:

- The `<title>` tag's text (e.g. `xkcd: Sandwich`).
- The `<img src="…">` URL of the comic image.
- The `<img alt="…">` alt text.

Print them in this format:

```
title: <text>
image: <url>
alt: <text>
```

Example run (fixture is a small saved page with `<title>xkcd: Sandwich</title>` and one `<img src="//imgs.xkcd.com/comics/sandwich.png" alt="A perfect sandwich" />`):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
title: xkcd: Sandwich
image: //imgs.xkcd.com/comics/sandwich.png
alt: A perfect sandwich
```

(`fixtures/input.txt` contains just `go` — a trigger so a `getLine` call won't block. The current stub doesn't read it; the reference key doesn't either.)

## Where to write your code

Open `solution.idr`. The stub typechecks but prints `FIXME` placeholders. One large `-- TODO` block:

- Read `miniproject/fixtures/xkcd.html` with `readFile`.
- Build small parser combinators (a `HtmlParser` record + `charP`, `stringP`, plus helpers like `untilTag` and `untilQuote`). The chapter's exercises 01–10 walk through every piece.
- Write `extractTitle` and `extractAttrAfter` (a generic helper that finds an anchor like `<img`, then a quoted attribute like `src="…"`).
- Print the three lines.

You'll use:

- `readFile` from `System.File`.
- `unpack`, `pack`, `break`, `Maybe`-driven do-notation.
- The same combinator pattern from the ch09 miniproject (a `runP` field returning `Maybe (a, String)`).

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch13
```

The test runs your program and checks the output contains `title: xkcd: Sandwich`, `image: //imgs.xkcd.com`, and `alt: A perfect sandwich`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is `findAfter`: when `stringP needle` doesn't match, you advance the input by **one character** and retry, so the search slides past anchored matches.
