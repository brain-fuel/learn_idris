module Test.State

import Hedgehog
import JSON.Derive
import Shared.State
import Test.Gen

%default total

prop_roundtripUser : Property
prop_roundtripUser = property $ do
  u <- forAll genUser
  decodeEither (encode u) === Right u

prop_roundtripProgress : Property
prop_roundtripProgress = property $ do
  p <- forAll genProgress
  decodeEither (encode p) === Right p

prop_roundtripUiState : Property
prop_roundtripUiState = property $ do
  u <- forAll genUiState
  decodeEither (encode u) === Right u

prop_roundtripAppState : Property
prop_roundtripAppState = property $ do
  a <- forAll genAppState
  decodeEither (encode a) === Right a

export
groupState : Group
groupState = MkGroup "Shared.State"
  [ ("User JSON roundtrip",     prop_roundtripUser)
  , ("Progress JSON roundtrip", prop_roundtripProgress)
  , ("UiState JSON roundtrip",  prop_roundtripUiState)
  , ("AppState JSON roundtrip", prop_roundtripAppState)
  ]
