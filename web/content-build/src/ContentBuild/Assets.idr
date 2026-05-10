module ContentBuild.Assets

%default total

-- TODO: copyReadmes : List (Nat, String, String) -> IO ()
-- Copy each chNN-slug/README.md to web/build/assets/<slug>.md for
-- runtime fetch by the client (avoids bundling prose into web-client.js).
