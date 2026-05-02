# Chapter 20 — Email & Notifications

**You'll learn:** sending email is **not** "speak SMTP from scratch" anymore — that's a maze of TLS, auth, anti-spam. Use a transactional-email REST API (Mailgun, Postmark, SendGrid). It's an HTTP POST with a JSON body. Same shape applies to SMS (Twilio) and push (Pushover).

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python concept                       | Idris form                                       |
|--------------------------------------|--------------------------------------------------|
| `smtplib.SMTP(...)`                  | skip — use a REST API instead                    |
| `requests.post("https://api.mailgun.net/v3/...", auth=...)` | pack `http` POST with bearer token |
| `twilio.rest.Client().messages.create(...)` | same: HTTP POST                           |
| Pushover API                         | HTTPS POST with form body                        |

Auth: every provider gives you an API key. Read it from `~/.config/learn_idris/<provider>.key` so it never lives in the repo.

## Pack dependencies

- `http`
- `json`

Install: `pack install http json`.

## Miniproject (when authored)

Daily-digest mailer: take a TSV of yesterday's events, format as Markdown, render to HTML, POST via Mailgun.
