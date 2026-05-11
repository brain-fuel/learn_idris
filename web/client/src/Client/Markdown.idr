module Client.Markdown

import Client.FFI.Marked
import JS

%default total

-- Single entry point: take a markdown blob, return sanitized HTML.
-- Errors are impossible from the JS side (marked.parse + DOMPurify.sanitize
-- both return strings), so no Either wrapping.
export
render : HasIO io => String -> io String
render = renderMarkdown
