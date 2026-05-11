// Wire protocol between server and worker. JSON-encoded WS text frames,
// tagged-union shape `{ "kind": "<Tag>", ... }`. Validated both directions
// by zod. Mirror of what Server.SandboxClient on the Idris side will speak.

import { z } from 'zod';

// Worker receives (W2S) ----------------------------------------------------

export const Open  = z.object({
  kind: z.literal('Open'),
  sid:  z.string().min(1),
});

export const Stdin = z.object({
  kind: z.literal('Stdin'),
  sid:  z.string().min(1),
  data: z.string(),
});

export const Close = z.object({
  kind: z.literal('Close'),
  sid:  z.string().min(1),
});

export const W2S = z.discriminatedUnion('kind', [Open, Stdin, Close]);

// Worker sends (S2W) -------------------------------------------------------

export const Opened = z.object({
  kind: z.literal('Opened'),
  sid:  z.string().min(1),
});

export const Stdout = z.object({
  kind:  z.literal('Stdout'),
  sid:   z.string().min(1),
  chunk: z.string(),
});

export const Stderr = z.object({
  kind:  z.literal('Stderr'),
  sid:   z.string().min(1),
  chunk: z.string(),
});

export const Exited = z.object({
  kind: z.literal('Exited'),
  sid:  z.string().min(1),
  code: z.number().int(),
});

export const Denied = z.object({
  kind:   z.literal('Denied'),
  sid:    z.string(),                 // may be '' for parse errors w/o sid
  reason: z.string(),
});

export const S2W = z.discriminatedUnion('kind', [Opened, Stdout, Stderr, Exited, Denied]);

// Helpers -----------------------------------------------------------------

/**
 * parse(raw): { ok: true, value } | { ok: false, error }
 * Accepts only frames matching the W2S schema.
 */
export function parse(raw) {
  let json;
  try {
    json = JSON.parse(raw);
  } catch (e) {
    return { ok: false, error: `not JSON: ${e.message}` };
  }
  const r = W2S.safeParse(json);
  if (r.success) return { ok: true, value: r.data };
  return { ok: false, error: r.error.issues.map(i => `${i.path.join('.')}: ${i.message}`).join('; ') };
}

/**
 * encode(msg): string
 * Validates against S2W; throws if msg is not a legal worker output.
 * (Throwing is fine here — encoding bugs are programmer errors, not
 * protocol-level conditions to surface to the peer.)
 */
export function encode(msg) {
  const r = S2W.safeParse(msg);
  if (!r.success) {
    throw new Error(`encode: invalid S2W: ${JSON.stringify(msg)}`);
  }
  return JSON.stringify(r.data);
}
