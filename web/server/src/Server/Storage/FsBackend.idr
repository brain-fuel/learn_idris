module Server.Storage.FsBackend

import Server.Storage
import Shared.Ids

%default total

------------------------------------------------------------------------
-- Filesystem-backed completion tracker. TODO: append-only newline-
-- delimited JSON in `<varDir>/<userId>.jsonl`. v1 placeholder ships
-- the same shape as MemBackend so handlers can swap freely.
------------------------------------------------------------------------

export covering
mkBackend : String -> IO Storage
mkBackend _ = pure (MkStorage stubGet stubMark)
  where
    stubGet : UserId -> IO (List LessonSlug)
    stubGet _ = pure []

    stubMark : UserId -> LessonSlug -> IO ()
    stubMark _ _ = pure ()
