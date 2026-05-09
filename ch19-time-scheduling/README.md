# Chapter 19 — Time & Scheduling

**You'll learn:** `System.Clock` for wall-clock and monotonic time, `sleep` for waiting, `system` for scheduling via cron. Idris has no `datetime` library yet — we use clock primitives plus shell-out to `date`/`cal` for human-readable formatting.

## Idris realization

| Python concept                      | Idris form                                            |
|-------------------------------------|-------------------------------------------------------|
| `time.time()`                       | `clockTime UTC : IO Clock`                            |
| `time.sleep(n)`                     | `sleep n : IO ()`                                     |
| `datetime.now()`                    | combine `clockTime` + `system "date +%Y-%m-%d %H:%M"` |
| `subprocess.Popen([...])`           | `system` for fire-and-forget; `popen` for piped       |
| `schedule` library                  | shell out to `at` or `cron`                           |

## External tool dependencies

- `date` (POSIX) — for human-readable timestamps.
- `at` or `cron` — for scheduling.

## Pack dependencies

None — `System.Clock`, `System.Concurrency`, `System` are in `base`.

## Miniproject

A pomodoro timer: 25 min work, 5 min break, repeat 4× then 15 min long break. Uses `System.Clock` for timing, `system "notify-send ..."` for desktop notifications.
