# Setup (Teacher, one-time per machine)

Run this once before the first lesson with a new learner. The learner should not need to read this.

## 1. Verify Idris 2

```bash
idris2 --version
```

Expect Idris 2 ≥ 0.7.0. Already installed at `/home/brainfuel/.local/bin/idris2` on the dev machine (v0.8.0).

If missing, install from source — Idris 2 needs Chez Scheme as its backend:

```bash
sudo apt install chezscheme
git clone https://github.com/idris-lang/Idris2.git ~/Idris2
cd ~/Idris2
make bootstrap SCHEME=chez
make install
```

The bootstrap step takes ~10 min on a modern laptop. Add `~/.idris2/bin` (or wherever `make install` placed it) to your `PATH`.

## 2. Install pack (Idris 2 package manager)

`pack` is the de-facto Idris 2 package manager — it pins a curated collection of libraries that build together. The chapter `.ipkg` files in this curriculum (`ch13.ipkg` onwards) reference packages from a pack collection.

```bash
git clone https://github.com/stefan-hoeck/idris2-pack.git ~/idris2-pack
cd ~/idris2-pack
make app
make install-app
```

After install, add `~/.pack/bin` to your `PATH`. Verify:

```bash
pack info
pack switch latest
```

The first run of `pack switch latest` downloads the current package collection (~1 min). On the dev machine the active collection at first author was `nightly-260327`.

Note: the chapters in Wave 1 (ch00, ch01) do not depend on any external packages — Idris 2's `prelude`, `base`, and `contrib` libraries are enough. `pack` becomes load-bearing only at ch13 and beyond, when chapter `.ipkg` files start declaring `depends = http, json, parser-tsv` etc.

## 3. Smoke test

```bash
cd /home/brainfuel/johannes/learn_idris
idris2 --exec main ch00-hello/hello.idr
```

It will prompt for a name. Type one, hit Enter. Expect a greeting back.

Then run the verifier:

```bash
make verify-ch00
```

Expect a green "OK ch00-hello" line at the end.

## 4. Nvim Idris 2 LSP (optional but recommended)

The learner edits in `nvim`. Without an LSP they get plain syntax highlighting only. With `idris2-lsp` they get type-on-hover, holes-as-tooltips, and error squiggles — which short-circuits a *lot* of "I don't understand the error" friction with Idris's type errors.

```bash
git clone https://github.com/idris-community/idris2-lsp.git ~/idris2-lsp
cd ~/idris2-lsp
make install-with-src-api
```

Then in `~/.config/nvim/lua/plugins/idris.lua` (or wherever your lspconfig lives):

```lua
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

if not configs.idris2_lsp then
  configs.idris2_lsp = {
    default_config = {
      cmd = { 'idris2-lsp' },
      filetypes = { 'idris2' },
      root_dir = lspconfig.util.root_pattern('*.ipkg', '.git'),
      settings = {},
    },
  }
end
lspconfig.idris2_lsp.setup{}
```

Add filetype detection in nvim init:

```lua
vim.filetype.add({
  extension = {
    idr = 'idris2',
    ipkg = 'idris2',
  },
})
```

Verify with `:LspInfo` on a `.idr` buffer — it should show `idris2_lsp` attached.

## 5. External tools used by later chapters

Some chapters shell out to external tools instead of pure-Idris libraries (the pack ecosystem doesn't yet cover them):

- `sqlite3` (ch16) — `sudo apt install sqlite3`
- `pandoc` (ch17) — `sudo apt install pandoc`
- `imagemagick` (ch21 PPM→PNG conversion, ch23 screenshots) — `sudo apt install imagemagick`
- `tesseract-ocr` (ch22) — `sudo apt install tesseract-ocr`
- `xdotool` (ch23, Linux/WSLg only) — `sudo apt install xdotool`
- `espeak-ng` (ch24) — `sudo apt install espeak-ng`

For the **Wave 5 capstone (ch21–ch24)** install all four in one go before working through those chapters:

```bash
sudo apt install -y imagemagick tesseract-ocr xdotool espeak-ng
```

Verify each resolves and the round-trip works:

```bash
which tesseract xdotool espeak-ng convert            # all should print /usr/bin/...
xdotool getmouselocation                             # X server reachable (WSLg ok)
espeak-ng -w /tmp/_smoke.wav "hi" && head -c 4 /tmp/_smoke.wav  # prints "RIFF"
```

`xdotool` needs a working X display. On WSL2, recent versions ship WSLg, which exposes a working `$DISPLAY=:0` automatically. If `xdotool getmouselocation` errors out with a missing display, either upgrade WSL or run ch23 tests under `xvfb-run` (`sudo apt install xvfb`).

Earlier-wave tools (`sqlite3`, `pandoc`) install on demand when those chapters come up.

## 5a. Per-chapter pack workspaces (ch13+)

Starting at ch13 some chapters depend on pack ecosystem packages (`http` for ch13/ch15/ch20 in Wave 4). Rather than installing those globally with `pack install <pkg>`, this curriculum pins each chapter's deps in a per-chapter `pack.toml`:

```
ch13-web-scraping/pack.toml
ch15-google-sheets/pack.toml
ch20-email/pack.toml
```

Each is one stanza:

```toml
[pack]
collection = "nightly-260327"
```

That collection pin (and only that) makes builds reproducible across machines: every learner who runs `pack switch nightly-260327` once gets the same `http` commit, the same `idris2`, the same scheme backend.

After cloning the repo, run **once**:

```bash
make bootstrap-pack
```

This walks every `chNN-*/pack.toml` and runs `pack install-deps chNN.ipkg` inside the chapter directory. First run on a cold cache builds `http` (and its transitive deps like `tls`, `base64`) — takes a few minutes. Subsequent runs are no-ops.

`make verify-chNN` re-runs `pack install-deps` automatically when a `pack.toml` is present, and exports `IDRIS2_PACKAGE_PATH=$(pack package-path)` so `idris2 --check` resolves the chapter's pack imports. No manual `pack` invocation needed during normal use.

Why per-chapter (not a single root `pack.toml`): keeps each chapter self-contained — copying `chNN-*/` into a different repo or sharing it as a standalone exercise still works without dragging in unrelated deps.

## 6. Reuse with another learner

Clone a fresh copy of this repo. Each learner gets their own clone. Curriculum content stays on `main`; their work lives in their clone.
