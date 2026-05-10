module Shared.State

import JSON.Derive
import Shared.Ids

%default total
%language ElabReflection

public export
record User where
  constructor MkUser
  id        : UserId
  email     : String
  createdAt : Bits64        -- millis since epoch

public export
record Progress where
  constructor MkProgress
  user             : UserId
  completedLessons : List LessonSlug
  currentLesson    : Maybe LessonSlug

public export
data UiState
  = Loading
  | Ready
  | InSandbox SessionId

public export
record AppState where
  constructor MkAppState
  user     : Maybe User
  progress : Progress
  ui       : UiState

%runElab derive "User"     [Show, Eq, ToJSON, FromJSON]
%runElab derive "Progress" [Show, Eq, ToJSON, FromJSON]
%runElab derive "UiState"  [Show, Eq, ToJSON, FromJSON]
%runElab derive "AppState" [Show, Eq, ToJSON, FromJSON]
