module Server.Storage

import Shared.Ids

%default total

------------------------------------------------------------------------
-- Storage interface (record-of-functions style). Backends in
-- Server/Storage/{FsBackend,MemBackend}.idr supply concrete impls.
-- v1 is read-only; CCompleteLesson handling fills in `markComplete`
-- in the next pass.
------------------------------------------------------------------------

public export
record Storage where
  constructor MkStorage
  getCompleted  : UserId -> IO (List LessonSlug)
  markComplete  : UserId -> LessonSlug -> IO ()
