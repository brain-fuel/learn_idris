module Client.FFI.Marked

%default total

-- All %foreign calls quarantined under Client.FFI.*.
-- TODO Task 3: real binding once dom-mvc + esbuild are wired:
-- %foreign "browser:lambda: (s) => DOMPurify.sanitize(marked.parse(s))"
-- prim__renderMarkdown : String -> PrimIO String
