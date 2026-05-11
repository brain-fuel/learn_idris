// Length-prefix framing round-trip for the UDS client. We don't expose
// the framing helpers as a separate module (they're inline in udsClient
// for v1), so this test mocks the server side with a net.Server and
// drives one full roundtrip through UdsClient.

import { test } from 'node:test';
import assert from 'node:assert/strict';
import net from 'node:net';
import { mkdtempSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import pino from 'pino';
import { UdsClient } from '../src/udsClient.mjs';

const silent = pino({ level: 'silent' });

function startEchoUds() {
  const dir  = mkdtempSync(join(tmpdir(), 'bridge-test-'));
  const path = join(dir, 'echo.sock');
  const server = net.createServer((sock) => {
    let buf = Buffer.alloc(0);
    let expected = null;
    sock.on('data', (chunk) => {
      buf = Buffer.concat([buf, chunk]);
      if (expected === null && buf.length >= 4) {
        expected = buf.readUInt32BE(0);
        buf = buf.subarray(4);
      }
      if (expected !== null && buf.length >= expected) {
        const body = buf.subarray(0, expected);
        const reply = Buffer.from(JSON.stringify({ echoed: JSON.parse(body.toString()) }));
        const hdr = Buffer.alloc(4); hdr.writeUInt32BE(reply.length, 0);
        sock.write(Buffer.concat([hdr, reply]));
        sock.end();
      }
    });
  });
  return new Promise((resolve) => {
    server.listen(path, () => resolve({ server, path }));
  });
}

test('UdsClient round-trips a length-prefixed JSON frame', async (t) => {
  const { server, path } = await startEchoUds();
  t.after(() => new Promise((r) => server.close(r)));

  const client = new UdsClient(path, silent);
  const env = { v: 1, ts: 0, msg: { tag: 'CPing', contents: 42 } };
  const reply = await client.send(env);
  assert.deepEqual(reply, { echoed: env });
});

test('UdsClient round-trips a large (~64 KiB) frame', async (t) => {
  const { server, path } = await startEchoUds();
  t.after(() => new Promise((r) => server.close(r)));

  const client = new UdsClient(path, silent);
  const big = 'x'.repeat(64 * 1024 - 50);
  const env = { v: 1, ts: 0, msg: { tag: 'CLoadLesson', contents: big } };
  const reply = await client.send(env);
  assert.equal(reply.echoed.msg.contents.length, big.length);
});

test('UdsClient rejects on connect failure', async () => {
  const client = new UdsClient('/tmp/does-not-exist.sock', silent);
  await assert.rejects(client.send({ v: 1, ts: 0, msg: { tag: 'CPing', contents: 0 } }));
});
