# Chapter 13 — Web Scraping

**You'll learn:** how to fetch a URL with the `http` pack package, then extract data from the HTML response using parser combinators (the same technique from ch09). Idris doesn't ship a `BeautifulSoup` analogue — you write a small HTML matcher tailored to the scrape you need.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python concept                      | Idris form                                            |
|-------------------------------------|-------------------------------------------------------|
| `requests.get(url).text`            | `Network.HTTP.Client.get url` from pack `http`        |
| `BeautifulSoup(html, "html.parser")`| your own parser combinator over the HTML string       |
| `soup.find("a", class_="x")`        | hand-write a matcher for the tag/attr you need        |
| sessions, cookies                   | the `http` pkg supports stateful clients              |

## Pack dependencies

- `http` — HTTP client.

Configure in `ch13.ipkg`:
```
depends = base, http
```

Install via: `pack install http` (run once per machine).

## Miniproject (when authored)

Daily comic downloader: scrape <https://xkcd.com>, find the image URL, download it to `comic-<date>.png`. Practices HTTP, simple HTML parsing, and writing binary files.
