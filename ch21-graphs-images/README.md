# Chapter 21 — Graphs & Images (PPM substitute)

**You'll learn:** Idris has no `matplotlib`, no `Pillow`. The substitute: **PPM (Portable Pixmap)** — a plain-text image format you can write byte-by-byte. Pure Idris, zero dependencies, and surprisingly capable for bar charts and simple graphics.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

PPM-P3 format (ASCII):
```
P3
<width> <height>
255
<R> <G> <B>  <R> <G> <B>  ...    -- one rgb triple per pixel, row-major
```

Modern viewers (Preview on macOS, `feh`/`xdg-open` on Linux, GIMP everywhere) open `.ppm` natively. To convert to `.png`: `system "convert chart.ppm chart.png"` (ImageMagick).

| Python concept                      | Idris form                                       |
|-------------------------------------|--------------------------------------------------|
| `plt.bar(xs, ys)`                   | render PPM by hand: pick a pixel grid, fill bars |
| `plt.plot(xs, ys)`                  | Bresenham's line algorithm (~10 lines of Idris)  |
| `Image.open(...).resize(...)`       | parse PPM, transform pixel array, re-emit        |

## External tool dependencies

Optional: `imagemagick` for `.ppm` → `.png` conversion. `sudo apt install imagemagick`.

## Pack dependencies

None.

## Miniproject (when authored)

Bar-chart-from-TSV: read a TSV of `(label, value)` rows, render as a labeled bar chart `.ppm`, optionally convert to `.png` via ImageMagick.
