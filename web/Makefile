IDRIS2 ?= idris2

.PHONY: help
help:
	@echo "Targets:"
	@echo "  make web-typecheck   - typecheck every .idr in web/ (no pack deps required)"
	@echo "  make web-deps        - pack install-deps for all four web ipkgs"
	@echo "  make web-build       - build all four ipkgs (requires web-deps first)"
	@echo "  make web-clean       - remove build/ caches under web/"

# Per-ipkg typecheck. idris2 --typecheck respects the ipkg's sourcedir and
# resolves intra-package imports correctly; --check on bare files mis-derives
# module names from the path. Stubs declare no external `depends`, so no
# pack install is required at this stage.
#
# idris2 --check exits 0 even on Module-not-found; --typecheck on a clean
# ipkg currently exits non-zero on real errors but we still grep ^Error: as
# defense-in-depth, mirroring the parent Makefile.
.PHONY: web-typecheck
web-typecheck:
	@fail=0; \
	  for d in shared content-build server client; do \
	    ipkg=$$(ls $$d/*.ipkg 2>/dev/null | head -n1); \
	    [ -n "$$ipkg" ] || continue; \
	    base=$$(basename "$$ipkg"); \
	    echo "==> $(IDRIS2) --typecheck $$ipkg"; \
	    out=$$(cd "$$d" && $(IDRIS2) --typecheck "$$base" 2>&1); \
	    rc=$$?; \
	    echo "$$out"; \
	    if [ $$rc -ne 0 ] || echo "$$out" | grep -qE '^Error:'; then \
	      echo "FAIL: $$ipkg"; fail=1; \
	    fi; \
	  done; \
	  if [ $$fail -ne 0 ]; then exit 1; fi; \
	  echo "OK web-typecheck"

.PHONY: web-deps
web-deps:
	@for d in shared content-build server client t/shared; do \
	  ipkg=$$(ls $$d/*.ipkg 2>/dev/null | head -n1); \
	  [ -n "$$ipkg" ] || continue; \
	  echo "==> pack install-deps $$ipkg"; \
	  (cd $$d && pack --no-prompt install-deps "$$(basename $$ipkg)") || exit 1; \
	done; \
	echo "OK web-deps"

.PHONY: web-build
web-build:
	@for d in shared content-build server client; do \
	  ipkg=$$(ls $$d/*.ipkg 2>/dev/null | head -n1); \
	  [ -n "$$ipkg" ] || continue; \
	  echo "==> $(IDRIS2) --build $$ipkg"; \
	  (cd $$d && $(IDRIS2) --build "$$(basename $$ipkg)") || exit 1; \
	done; \
	echo "OK web-build"

.PHONY: web-test-shared
web-test-shared:
	@cd t/shared && pack --no-prompt build shared-tests.ipkg >/dev/null && \
	  ./build/exec/shared-tests

.PHONY: web-test
web-test: web-test-shared

.PHONY: web-clean
web-clean:
	@find . -type d -name build -exec rm -rf {} + 2>/dev/null; \
	echo "OK web-clean"
