# Chapter 17 — PDF / Word (Markdown + pandoc substitute)

**You'll learn:** there is no `python-docx` or `PyPDF2` in the Idris ecosystem. The substitute is **generate Markdown** in pure Idris, then **shell out to `pandoc`** to convert to PDF, DOCX, HTML, or anything else pandoc supports. This is also how a lot of professional tooling works — Markdown is the lingua franca, pandoc is the multi-tool.

## Idris realization

| Python concept                         | Idris substitute                                   |
|----------------------------------------|----------------------------------------------------|
| `docx.Document().save("out.docx")`     | write Markdown, `system "pandoc x.md -o x.docx"`   |
| `PyPDF2.PdfReader("in.pdf").pages`     | `system "pdftotext in.pdf -"` reads as text        |
| `Document.add_heading("x")`            | `# x\n` in your Markdown                           |
| tables                                 | Markdown table syntax `| a | b |\n|---|---|`       |

## External tool dependencies

- `pandoc` — `sudo apt install pandoc` (Ubuntu).
- `pdftotext` (from `poppler-utils`) for read-side — `sudo apt install poppler-utils`.

## Pack dependencies

None.

## Miniproject

Invoice generator: take a TSV of line items, emit `invoice.md`, then run pandoc to produce `invoice.pdf`.
