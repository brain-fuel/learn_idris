# Chapter 23 — Keyboard & Mouse (xdotool shell-out)

**You'll learn:** GUI automation has no Idris-native library. The substitute on Linux/WSL2 is **`xdotool`** — `xdotool type "hello"`, `xdotool mousemove 100 200`, `xdotool key Return`. Same shell-out pattern as ch22.

This chapter is **Linux-only** (or macOS with `cliclick`, similar API). Native Windows GUI automation is out of scope.

## Idris realization

| Python `pyautogui`               | Idris (shell to `xdotool`)                       |
|----------------------------------|--------------------------------------------------|
| `pyautogui.click(x, y)`          | `system "xdotool mousemove X Y click 1"`         |
| `pyautogui.typewrite("hi")`      | `system "xdotool type 'hi'"`                     |
| `pyautogui.hotkey('ctrl', 'c')`  | `system "xdotool key ctrl+c"`                    |
| `pyautogui.screenshot(...)`      | `system "import -window root screenshot.png"` (ImageMagick) |
| `pyautogui.position()`           | `system "xdotool getmouselocation"`              |

## External tool dependency

- `xdotool` — `sudo apt install xdotool`.
- (Optional, screenshot) `imagemagick`.

## Pack dependencies

None.

## Miniproject

Auto-clicker that solves a small "click the buttons in this order" UI test. Runs against a known window title.

> **Caution:** automation that drives the keyboard/mouse can interact with whatever's focused. Run miniprojects in a freshly-opened test window so a stray click can't fire something destructive.
