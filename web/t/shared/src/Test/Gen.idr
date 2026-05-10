module Test.Gen

import Data.Vect
import Hedgehog
import Shared.Ids
import Shared.State
import Shared.Protocol

%default total

------------------------------------------------------------------------
-- Generators for shared types. Sizes are intentionally small to keep
-- the suite fast.
------------------------------------------------------------------------

export
genShortStr : Gen String
genShortStr = string (linear 1 16) alphaNum

export
genNonEmptyStr : Gen String
genNonEmptyStr = string (linear 1 24) alphaNum

export
genSessionId : Gen SessionId
genSessionId = MkSessionId <$> genShortStr

export
genLessonSlug : Gen LessonSlug
genLessonSlug = MkLessonSlug <$> genShortStr

export
genUserId : Gen UserId
genUserId = MkUserId <$> genShortStr

export
genErrorCode : Gen ErrorCode
genErrorCode = element [ ProtocolMismatch
                       , NotAuthorized
                       , RateLimited
                       , SandboxBusy
                       , InternalError
                       ]

export
genUser : Gen User
genUser = [| MkUser genUserId genShortStr (bits64 $ linear 0 1000000) |]

export
genProgress : Gen Progress
genProgress = [| MkProgress
                   genUserId
                   (list (linear 0 4) genLessonSlug)
                   (maybe genLessonSlug)
              |]

export
genUiState : Gen UiState
genUiState = choice
  [ pure Loading
  , pure Ready
  , InSandbox <$> genSessionId
  ]

export
genAppState : Gen AppState
genAppState = [| MkAppState (maybe genUser) genProgress genUiState |]

------------------------------------------------------------------------
-- Protocol generators.
------------------------------------------------------------------------

export
genClientMsg : Gen ClientMsg
genClientMsg = choice
  [ CHello             <$> nat (linear 0 5)
  , CLoadLesson        <$> genLessonSlug
  , CCompleteLesson    <$> genLessonSlug
  , pure CSandboxOpen
  , [| CSandboxStdin genSessionId genShortStr |]
  , CSandboxClose      <$> genSessionId
  , CPing              <$> bits64 (linear 0 1000000)
  ]

genExitCode : Gen Int
genExitCode = integral (the (Hedgehog.Range Int) (linear (-1) 255))

export
genServerMsg : Gen ServerMsg
genServerMsg = choice
  [ [| SHello (nat $ linear 0 5) (maybe genUser) |]
  , SState <$> genAppState
  , SSandboxOpened <$> genSessionId
  , [| SSandboxStdout genSessionId genShortStr |]
  , [| SSandboxStderr genSessionId genShortStr |]
  , [| SSandboxExit genSessionId genExitCode |]
  , [| SError genErrorCode genShortStr |]
  , SPong <$> bits64 (linear 0 1000000)
  ]

export
genEnvelopeClient : Gen (Envelope ClientMsg)
genEnvelopeClient = [| MkEnvelope (nat $ linear 0 5) (bits64 $ linear 0 1000000) genClientMsg |]

export
genEnvelopeServer : Gen (Envelope ServerMsg)
genEnvelopeServer = [| MkEnvelope (nat $ linear 0 5) (bits64 $ linear 0 1000000) genServerMsg |]
