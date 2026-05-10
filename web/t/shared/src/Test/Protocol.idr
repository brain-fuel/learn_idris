module Test.Protocol

import Hedgehog
import JSON.Derive
import Shared.Protocol
import Test.Gen

%default total

prop_roundtripClientMsg : Property
prop_roundtripClientMsg = property $ do
  m <- forAll genClientMsg
  decodeEither (encode m) === Right m

prop_roundtripServerMsg : Property
prop_roundtripServerMsg = property $ do
  m <- forAll genServerMsg
  decodeEither (encode m) === Right m

prop_roundtripEnvelopeClient : Property
prop_roundtripEnvelopeClient = property $ do
  e <- forAll genEnvelopeClient
  decodeEither (encode e) === Right e

prop_roundtripEnvelopeServer : Property
prop_roundtripEnvelopeServer = property $ do
  e <- forAll genEnvelopeServer
  decodeEither (encode e) === Right e

export
groupProtocol : Group
groupProtocol = MkGroup "Shared.Protocol"
  [ ("ClientMsg JSON roundtrip",          prop_roundtripClientMsg)
  , ("ServerMsg JSON roundtrip",          prop_roundtripServerMsg)
  , ("Envelope ClientMsg JSON roundtrip", prop_roundtripEnvelopeClient)
  , ("Envelope ServerMsg JSON roundtrip", prop_roundtripEnvelopeServer)
  ]
