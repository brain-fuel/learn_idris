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

## 5. (Optional) tools used by later chapters

Some Wave 2+ chapters shell out to external tools instead of pure-Idris libraries (the pack ecosystem doesn't yet cover them):

- `sqlite3` (ch16) — `sudo apt install sqlite3`
- `pandoc` (ch17) — `sudo apt install pandoc`
- `tesseract-ocr` (ch22) — `sudo apt install tesseract-ocr`
- `xdotool` (ch23, Linux only) — `sudo apt install xdotool`
- `espeak-ng` (ch24) — `sudo apt install espeak-ng`

Install on demand when the chapter calls for it; not needed before ch13.

## 6. Reuse with another learner

Clone a fresh copy of this repo. Each learner gets their own clone. Curriculum content stays on `main`; their work lives in their clone.
