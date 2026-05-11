import { test } from 'node:test';
import assert from 'node:assert/strict';
import { parse, encode } from '../src/protocol.mjs';

// Round-trip every S2W constructor.
test('S2W encode round-trips through JSON.parse', () => {
  const cases = [
    { kind: 'Opened', sid: 'a' },
    { kind: 'Stdout', sid: 'a', chunk: 'hello\n' },
    { kind: 'Stderr', sid: 'a', chunk: 'oops' },
    { kind: 'Exited', sid: 'a', code: 0 },
    { kind: 'Exited', sid: 'a', code: -1 },
    { kind: 'Denied', sid: '',  reason: 'parse failure' },
    { kind: 'Denied', sid: 'a', reason: 'rate limit' },
  ];
  for (const c of cases) {
    const wire = encode(c);
    assert.deepEqual(JSON.parse(wire), c);
  }
});

test('encode rejects malformed S2W', () => {
  assert.throws(() => encode({ kind: 'Opened' }));               // missing sid
  assert.throws(() => encode({ kind: 'Stdout', sid: 'a' }));     // missing chunk
  assert.throws(() => encode({ kind: 'Bogus', sid: 'a' }));      // unknown kind
});

test('parse accepts valid W2S frames', () => {
  for (const c of [
    { kind: 'Open',  sid: 'a' },
    { kind: 'Stdin', sid: 'a', data: ':t Nat' },
    { kind: 'Close', sid: 'a' },
  ]) {
    const r = parse(JSON.stringify(c));
    assert.equal(r.ok, true);
    assert.deepEqual(r.value, c);
  }
});

test('parse rejects malformed JSON', () => {
  const r = parse('{not json');
  assert.equal(r.ok, false);
  assert.match(r.error, /not JSON/);
});

test('parse rejects missing kind', () => {
  const r = parse(JSON.stringify({ sid: 'a' }));
  assert.equal(r.ok, false);
});

test('parse rejects unknown kind', () => {
  const r = parse(JSON.stringify({ kind: 'WhoAmI', sid: 'a' }));
  assert.equal(r.ok, false);
});

test('parse rejects empty sid', () => {
  const r = parse(JSON.stringify({ kind: 'Open', sid: '' }));
  assert.equal(r.ok, false);
});
