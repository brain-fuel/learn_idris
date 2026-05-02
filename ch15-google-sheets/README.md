# Chapter 15 — Google Sheets

**You'll learn:** the Sheets v4 REST API is just HTTP — `GET https://sheets.googleapis.com/v4/spreadsheets/{id}/values/{range}` returns JSON. This chapter wires up the pack `http` + `json` packages to read, append, and update a Google Sheet from Idris.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

OAuth is the friction. Two paths:
1. **Service account** with a key JSON — recommended for headless. Generate the key once via `gcloud`, mint a JWT, exchange for a bearer token, cache it.
2. **API key** for read-only public sheets — simplest, only works on sheets shared "Anyone with link can view."

Authenticated requests carry an `Authorization: Bearer <token>` header. The body comes back JSON; parse with pack `json`.

## Pack dependencies

- `http` — HTTP client.
- `json` — JSON parser/serializer.

Configure in `ch15.ipkg`: `depends = base, http, json`. Install: `pack install http json`.

## Miniproject (when authored)

Row-appender CLI: `gsheet-append <spreadsheet-id> <sheet-name> <comma-separated-values>` appends a new row. Reads creds from `~/.config/learn_idris/sheets-key.json`.
