// End-to-end smoke. Spawns the worker on a random port (PORT=0), opens a
// WS, runs Open -> Stdin :t Nat -> Close, asserts the expected reply
// shapes. Uses JAIL=none so this passes on any host (CI may not have bwrap).

import { test } from 'node:test';
import assert from 'node:assert/strict';
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, resolve } from 'node:path';
import { WebSocket } from 'ws';

const here       = dirname(fileURLToPath(import.meta.url));
const workerPath = resolve(here, '../src/worker.mjs');

function startWorker() {
  return new Promise((resolveStart, reject) => {
    const child = spawn('node', [workerPath], {
      env: { ...process.env, PORT: '0', JAIL: 'none', LOG_LEVEL: 'error' },
      stdio: ['ignore', 'pipe', 'inherit'],
    });
    let buf = '';
    const onData = (b) => {
      buf += b.toString('utf8');
      const m = buf.match(/SANDBOX_LISTENING (ws:\/\/\S+)/);
      if (m) {
        child.stdout.off('data', onData);
        resolveStart({ child, url: m[1] });
      }
    };
    child.stdout.on('data', onData);
    child.on('error', reject);
    setTimeout(() => reject(new Error('worker startup timeout')), 5000);
  });
}

function awaitMessage(ws, predicate, timeoutMs = 10000) {
  return new Promise((resolveMsg, reject) => {
    const t = setTimeout(() => {
      ws.off('message', onMsg);
      reject(new Error(`timeout waiting for ${predicate}`));
    }, timeoutMs);
    const onMsg = (raw) => {
      const msg = JSON.parse(raw.toString('utf8'));
      if (predicate(msg)) {
        clearTimeout(t);
        ws.off('message', onMsg);
        resolveMsg(msg);
      }
    };
    ws.on('message', onMsg);
  });
}

test('worker round-trip: Open -> Stdin :t Nat -> Close', async (t) => {
  const { child, url } = await startWorker();
  t.after(() => child.kill('SIGTERM'));

  const ws = new WebSocket(url);
  await new Promise((r, j) => { ws.once('open', r); ws.once('error', j); });

  const sid = 't1';

  // Open -> Opened
  ws.send(JSON.stringify({ kind: 'Open', sid }));
  const opened = await awaitMessage(ws, (m) => m.kind === 'Opened' && m.sid === sid);
  assert.deepEqual(opened, { kind: 'Opened', sid });

  // First stdout chunk should arrive (idris2 prints "Main> " prompt)
  await awaitMessage(ws, (m) => m.kind === 'Stdout' && m.sid === sid);

  // Stdin :t Nat -> Stdout containing "Nat"
  ws.send(JSON.stringify({ kind: 'Stdin', sid, data: ':t Nat' }));
  const stdoutMsg = await awaitMessage(ws,
    (m) => m.kind === 'Stdout' && m.sid === sid && m.chunk.includes('Nat')
  );
  assert.match(stdoutMsg.chunk, /Nat/);

  // Close -> Exited
  ws.send(JSON.stringify({ kind: 'Close', sid }));
  const exited = await awaitMessage(ws, (m) => m.kind === 'Exited' && m.sid === sid);
  assert.equal(exited.kind, 'Exited');
  assert.equal(typeof exited.code, 'number');

  ws.close();
});

test('worker rejects malformed frames with Denied', async (t) => {
  const { child, url } = await startWorker();
  t.after(() => child.kill('SIGTERM'));

  const ws = new WebSocket(url);
  await new Promise((r, j) => { ws.once('open', r); ws.once('error', j); });

  ws.send('{not json');
  const denied = await awaitMessage(ws, (m) => m.kind === 'Denied');
  assert.match(denied.reason, /not JSON/);

  ws.close();
});

test('worker rejects unknown sid stdin with Denied', async (t) => {
  const { child, url } = await startWorker();
  t.after(() => child.kill('SIGTERM'));

  const ws = new WebSocket(url);
  await new Promise((r, j) => { ws.once('open', r); ws.once('error', j); });

  ws.send(JSON.stringify({ kind: 'Stdin', sid: 'nope', data: 'foo' }));
  const denied = await awaitMessage(ws,
    (m) => m.kind === 'Denied' && m.sid === 'nope'
  );
  assert.match(denied.reason, /unknown sid/);

  ws.close();
});
