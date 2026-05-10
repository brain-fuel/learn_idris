module Shared.Ids

import JSON.Derive

%default total
%language ElabReflection

------------------------------------------------------------------------
-- ID newtypes
--
-- Single-field records: idris2-json's default Options unwrap these to
-- bare JSON strings on the wire (e.g. MkSessionId "abc" => "abc"), so
-- payloads remain compact while Idris keeps the type discipline.
------------------------------------------------------------------------

public export
record SessionId where
  constructor MkSessionId
  unSessionId : String

public export
record LessonSlug where
  constructor MkLessonSlug
  unLessonSlug : String

public export
record UserId where
  constructor MkUserId
  unUserId : String

%runElab derive "SessionId"  [Show, Eq, Ord, ToJSON, FromJSON]
%runElab derive "LessonSlug" [Show, Eq, Ord, ToJSON, FromJSON]
%runElab derive "UserId"     [Show, Eq, Ord, ToJSON, FromJSON]

------------------------------------------------------------------------
-- Closed error enum.
------------------------------------------------------------------------

public export
data ErrorCode
  = ProtocolMismatch
  | NotAuthorized
  | RateLimited
  | SandboxBusy
  | InternalError

%runElab derive "ErrorCode" [Show, Eq, Ord, ToJSON, FromJSON]

------------------------------------------------------------------------
-- Smart constructors: reject empty input. Task 5 may tighten these to
-- dependent-type-enforced invariants (e.g. slug-shape proof).
------------------------------------------------------------------------

export
mkSessionId : String -> Maybe SessionId
mkSessionId "" = Nothing
mkSessionId s  = Just (MkSessionId s)

export
mkLessonSlug : String -> Maybe LessonSlug
mkLessonSlug "" = Nothing
mkLessonSlug s  = Just (MkLessonSlug s)

export
mkUserId : String -> Maybe UserId
mkUserId "" = Nothing
mkUserId s  = Just (MkUserId s)
