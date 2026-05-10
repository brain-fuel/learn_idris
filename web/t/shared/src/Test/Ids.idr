module Test.Ids

import Hedgehog
import JSON.Derive
import Shared.Ids
import Test.Gen

%default total

------------------------------------------------------------------------
-- JSON round-trip properties for the ID types.
------------------------------------------------------------------------

prop_roundtripSessionId : Property
prop_roundtripSessionId = property $ do
  s <- forAll genSessionId
  decodeEither (encode s) === Right s

prop_roundtripLessonSlug : Property
prop_roundtripLessonSlug = property $ do
  s <- forAll genLessonSlug
  decodeEither (encode s) === Right s

prop_roundtripUserId : Property
prop_roundtripUserId = property $ do
  s <- forAll genUserId
  decodeEither (encode s) === Right s

prop_roundtripErrorCode : Property
prop_roundtripErrorCode = property $ do
  e <- forAll genErrorCode
  decodeEither (encode e) === Right e

------------------------------------------------------------------------
-- Smart-constructor laws.
------------------------------------------------------------------------

prop_mkSessionIdRejectsEmpty : Property
prop_mkSessionIdRejectsEmpty = withTests 1 . property $ do
  mkSessionId "" === Nothing

prop_mkLessonSlugRejectsEmpty : Property
prop_mkLessonSlugRejectsEmpty = withTests 1 . property $ do
  mkLessonSlug "" === Nothing

prop_mkUserIdRejectsEmpty : Property
prop_mkUserIdRejectsEmpty = withTests 1 . property $ do
  mkUserId "" === Nothing

prop_mkSessionIdAcceptsNonEmpty : Property
prop_mkSessionIdAcceptsNonEmpty = property $ do
  s <- forAll genNonEmptyStr
  mkSessionId s === Just (MkSessionId s)

export
groupIds : Group
groupIds = MkGroup "Shared.Ids"
  [ ("SessionId JSON roundtrip",   prop_roundtripSessionId)
  , ("LessonSlug JSON roundtrip",  prop_roundtripLessonSlug)
  , ("UserId JSON roundtrip",      prop_roundtripUserId)
  , ("ErrorCode JSON roundtrip",   prop_roundtripErrorCode)
  , ("mkSessionId rejects empty",  prop_mkSessionIdRejectsEmpty)
  , ("mkLessonSlug rejects empty", prop_mkLessonSlugRejectsEmpty)
  , ("mkUserId rejects empty",     prop_mkUserIdRejectsEmpty)
  , ("mkSessionId accepts non-empty", prop_mkSessionIdAcceptsNonEmpty)
  ]
