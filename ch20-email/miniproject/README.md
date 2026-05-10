# Mini-project: mailer (dry-run)

You'll build a tiny request builder for Mailgun's transactional-email API: read four `key=value` tokens, print exactly what the HTTP POST would look like — without actually sending it.

> **Why a dry-run?** Sending real email costs money, leaks secrets, and can't be unsent. The miniproject prints the would-be POST so you can inspect every byte before any network call. The chapter's API key is hard-coded to `FAKE_KEY`.

## What it should do

Read **one line** of stdin shaped like:

```
from=Ada to=Bob subject=hi body=howdy
```

(four space-separated `key=value` tokens). Then print three lines:

```
POST https://api.mailgun.net/v3/example.com/messages
Authorization: Bearer FAKE_KEY
Body: from=Ada&to=Bob&subject=hi&text=howdy
```

> **One subtle rename:** the input uses `body=` (the natural English word), but Mailgun's form field is `text`, so the output renames `body=` → `text=`.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
POST https://api.mailgun.net/v3/example.com/messages
Authorization: Bearer FAKE_KEY
Body: from=Ada&to=Bob&subject=hi&text=howdy
```

## Where to write your code

Open `solution.idr`. The starter prints `FIXME` on every line. Three `-- TODO` blocks:

1. **Parse the input.** `words` to split on spaces (4 tokens), then split each token on `=` with `Data.String.split (== '=')` — `forget` the `List1` to a `List`.
2. **Build a `Message` record** from the four `(key, value)` pairs. The chapter's `record Message` has fields `from, to, subject, body : String`. Use `applyPair` to fold each pair into the record, ignoring unknown keys.
3. **Print the three lines** — POST URL, `Authorization: Bearer FAKE_KEY`, and the form-encoded body. Build the body with a `formFields` helper that joins `key=value` pairs with `&`, and remember the `body` → `text` rename in `messageToForm`.

You'll use:

- `words`, `Data.String.split`, `Data.String.joinBy`.
- A small `record Message` and record-update syntax (`{ from := v } m`).
- The chapter's exercises 06–09 walk through every helper.

## How to test

Run it manually:

```bash
echo 'from=Ada to=Bob subject=hi body=howdy' \
  | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch20
```

The test pipes the fixture and checks the output contains `POST`, `from=`, `to=`, `subject=`, and `text=` (note: `text=`, not `body=`).

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the rename: `body` is a fine field name on the `Message` record, but `messageToForm` must emit `("text", m.body)` so the wire-format matches Mailgun's API.
