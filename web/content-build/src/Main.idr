module Main

import ContentBuild.Scan
import ContentBuild.Emit
import ContentBuild.Assets

%default total

-- TODO Task 4 (build pipeline): walk ../ch??-*/README.md, parse h1 + slug,
-- emit shared/src/Generated/Routes.idr, copy READMEs to web/build/assets/.
main : IO ()
main = putStrLn "content-build: stub (Task 4 will implement)"
