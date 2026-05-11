// Shared.Protocol mirror in zod. The idris2-json package defaults to a
// TaggedObject shape: `{ tag: "CtorName", contents: <payload> }`.
//
// We validate just enough on the way through to route correctly; the
// authoritative typing lives in web/shared/src/Shared/Protocol.idr.
// Anything we accept here we forward verbatim; we never re-shape
// payloads.

import { z } from 'zod';

const ClientTags = z.enum([
  'CHello',
  'CLoadLesson',
  'CCompleteLesson',
  'CSandboxOpen',
  'CSandboxStdin',
  'CSandboxClose',
  'CPing',
]);

const ServerTags = z.enum([
  'SHello',
  'SState',
  'SSandboxOpened',
  'SSandboxStdout',
  'SSandboxStderr',
  'SSandboxExit',
  'SError',
  'SPong',
]);

// Permissive payload — `contents` may be a primitive, object, or array
// depending on the constructor. We don't validate inner shape here.
const TaggedMsg = (tags) => z.object({
  tag: tags,
  contents: z.unknown().optional(),
});

export const ClientMsg = TaggedMsg(ClientTags);
export const ServerMsg = TaggedMsg(ServerTags);

export const Envelope = (msgSchema) => z.object({
  v:   z.number().int(),
  ts:  z.number().int(),
  msg: msgSchema,
});

export const ClientEnvelope = Envelope(ClientMsg);
export const ServerEnvelope = Envelope(ServerMsg);

// Routing decision: which transport does this message take?
//   'sandbox' -> Node-handled, forwarded to the sandbox worker
//   'state'   -> forwarded to the Idris-on-Chez server over UDS
export function routeFor(tag) {
  switch (tag) {
    case 'CSandboxOpen':
    case 'CSandboxStdin':
    case 'CSandboxClose':
      return 'sandbox';
    default:
      return 'state';
  }
}
