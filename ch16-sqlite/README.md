# Chapter 16 — SQLite (shell-out substitute)

**You'll learn:** the Idris pack ecosystem has a Postgres binding (`pg`) but no SQLite binding yet. This chapter substitutes by **shelling out to the `sqlite3` CLI**: `system "sqlite3 db.sqlite '<query>'"`. Output comes back as TSV; parse it with the same `parser-tsv` from ch14.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python `sqlite3` concept              | Idris form                                            |
|---------------------------------------|-------------------------------------------------------|
| `conn = sqlite3.connect("db.sqlite")` | nothing — we connect per-query                        |
| `cur.execute("INSERT ...")`           | `system ("sqlite3 db.sqlite \"INSERT ...\"")`         |
| `cur.fetchall()` returns rows         | shell `-separator $'\t'` flag → parse TSV result      |
| transactions                          | wrap multiple statements in `BEGIN; ... COMMIT;`      |

This is more verbose than a native binding, but: it works today, has zero pack deps, and the exercise is "compose shell commands safely from Idris" — a useful skill.

## External tool dependency

`sqlite3` CLI must be on `PATH`. Install via `sudo apt install sqlite3` (Ubuntu) or `brew install sqlite` (macOS).

## Pack dependencies

- `parser-tsv` — to parse `sqlite3 -separator '\t'` output.

## Miniproject (when authored)

Tiny task tracker: `task add "do laundry"`, `task list`, `task done 3` — backed by a `tasks.sqlite` file with a single `tasks` table.
