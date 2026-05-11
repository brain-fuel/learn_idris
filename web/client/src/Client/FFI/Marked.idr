module Client.FFI.Marked

import JS

%default total

-- marked.parse runs the markdown -> HTML compile; DOMPurify.sanitize strips
-- any unsafe HTML before we set innerHTML. Both are loaded as globals from
-- CDN <script> tags in client/index.html.
%foreign "browser:lambda: (s,w) => DOMPurify.sanitize(marked.parse(s))"
prim__renderMarkdown : String -> PrimIO String

export
renderMarkdown : HasIO io => String -> io String
renderMarkdown s = primIO (prim__renderMarkdown s)
