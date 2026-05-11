module Server.Storage.MemBackend

import Data.IORef
import Data.List
import Server.Storage
import Shared.Ids

%default total

------------------------------------------------------------------------
-- In-memory completion tracker. One IORef holding (UserId, LessonSlug)
-- pairs; useful for tests and the very first dev runs.
------------------------------------------------------------------------

export covering
new : IO Storage
new = do
  ref <- newIORef (the (List (UserId, LessonSlug)) [])
  pure (MkStorage (get ref) (mark ref))
  where
    covering
    get : IORef (List (UserId, LessonSlug)) -> UserId -> IO (List LessonSlug)
    get ref u = do
      pairs <- readIORef ref
      pure (map snd (filter (\p => fst p == u) pairs))

    covering
    mark : IORef (List (UserId, LessonSlug)) -> UserId -> LessonSlug -> IO ()
    mark ref u s = do
      pairs <- readIORef ref
      writeIORef ref ((u, s) :: pairs)
