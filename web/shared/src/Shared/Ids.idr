module Shared.Ids

%default total

-- TODO Task 2: replace placeholder aliases with newtype wrappers
-- (constructor-private; smart constructors validate format) and derive
-- ToJSON/FromJSON via idris2-json.
public export
SessionId : Type
SessionId = String

public export
LessonSlug : Type
LessonSlug = String

public export
UserId : Type
UserId = String

public export
ErrorCode : Type
ErrorCode = String
