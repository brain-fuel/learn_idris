// Bridge integration smoke. Boots:
//   - a mock UDS server (Node) that echoes every state-bound envelope
//   - a mock sandbox WS server (Node) that ACKs each Open with Opened
//   - the bridge process on PORT=0, pointed at both mocks
// Then drives one browser-side WS roundtrip per route.

import { test } from 'node:test';
import assert from 'node:assert/strict';
import net from 'node:net';
import http from 'node:http';
import { spawn } from 'node:child_process';
import { mkdtempSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { WebSocketServer, WebSocket } from 'ws';

const here       = dirname(fileURLToPath(import.meta.url));
const bridgeRoot = resolve(here, '..');

async function startMockUds() {
  const dir  = mkdtempSync(join(tmpdir(), 'bridge-smoke-'));
  const path = join(dir, 'mock.sock');
  const server = net.createServer((sock) => {
    let buf = Buffer.alloc(0);
    let expected = null;
    sock.on('data', (chunk) => {
      buf = Buffer.concat([buf, chunk]);
      while (true) {
        if (expected === null) {
          if (buf.length < 4) return;
          expected = buf.readUInt32BE(0);
          buf = buf.subarray(4);
        }
        if (buf.length < expected) return;
        const body = buf.subarray(0, expected);
        buf = buf.subarray(expected);
        expected = null;
        const env = JSON.parse(body.toString());
        const reply = { v: env.v, ts: env.ts, msg: { tag: 'SPong', contents: env.ts } };
        const replyBuf = Buffer.from(JSON.stringify(reply));
        const hdr = Buffer.alloc(4); hdr.writeUInt32BE(replyBuf.length, 0);
        sock.write(Buffer.concat([hdr, replyBuf]));
      }
    });
  });
  await new Promise((r) => server.listen(path, r));
  return { server, path };
}

async function startMockSandbox() {
  const httpServer = http.createServer();
  const wss = new WebSocketServer({ server: httpServer, path: '/control' });
  wss.on('connection', (ws) => {
    ws.on('message', (raw) => {
      const msg = JSON.parse(raw.toString());
      if (msg.kind === 'Open') {
        ws.send(JSON.stringify({ kind: 'Opened', sid: msg.sid }));
        ws.send(JSON.stringify({ kind: 'Stdout', sid: msg.sid, chunk: 'mockprompt> ' }));
      } else if (msg.kind === 'Stdin') {
        ws.send(JSON.stringify({ kind: 'Stdout', sid: msg.sid, chunk: `echo: ${msg.data}` }));
      } else if (msg.kind === 'Close') {
        ws.send(JSON.stringify({ kind: 'Exited', sid: msg.sid, code: 0 }));
      }
    });
  });
  await new Promise((r) => httpServer.listen(0, '127.0.0.1', r));
  const port = httpServer.address().port;
  return { httpServer, url: `ws://127.0.0.1:${port}/control` };
}

async function startBridge(env) {
  const child = spawn('node', ['src/server.mjs'], {
    cwd: bridgeRoot,
    env: { ...process.env, ...env, PORT: '0', LOG_LEVEL: 'error' },
    stdio: ['ignore', 'pipe', 'inherit'],
  });
  return new Promise((res, rej) => {
    let buf = '';
    const onData = (b) => {
      buf += b.toString();
      const m = buf.match(/BRIDGE_LISTENING (http:\/\/\S+)/);
      if (m) {
        child.stdout.off('data', onData);
        res({ child, url: m[1] });
      }
    };
    child.stdout.on('data', onData);
    setTimeout(() => rej(new Error('bridge startup timeout')), 5000);
  });
}

function awaitMessage(ws, predicate, timeoutMs = 5000) {
  return new Promise((res, rej) => {
    const t = setTimeout(() => { ws.off('message', onMsg); rej(new Error('await timeout')); }, timeoutMs);
    const onMsg = (raw) => {
      const env = JSON.parse(raw.toString());
      if (predicate(env)) {
        clearTimeout(t); ws.off('message', onMsg); res(env);
      }
    };
    ws.on('message', onMsg);
  });
}

test('bridge: state route forwards CPing to UDS and relays SPong', async (t) => {
  const udsMock = await startMockUds();
  const sbMock  = await startMockSandbox();
  const bridge  = await startBridge({
    UDS_PATH:    udsMock.path,
    SANDBOX_URL: sbMock.url,
    STATIC_ROOT: bridgeRoot,
  });
  t.after(() => {
    bridge.child.kill('SIGTERM');
    return Promise.all([
      new Promise((r) => udsMock.server.close(r)),
      new Promise((r) => sbMock.httpServer.close(r)),
    ]);
  });

  const ws = new WebSocket(bridge.url.replace('http', 'ws') + '/ws');
  await new Promise((r, j) => { ws.once('open', r); ws.once('error', j); });

  ws.send(JSON.stringify({ v: 1, ts: 9999, msg: { tag: 'CPing', contents: 9999 } }));
  const reply = await awaitMessage(ws, (m) => m.msg.tag === 'SPong');
  assert.equal(reply.msg.contents, 9999);
  ws.close();
});

test('bridge: sandbox route opens session, streams output, exits', async (t) => {
  const udsMock = await startMockUds();
  const sbMock  = await startMockSandbox();
  const bridge  = await startBridge({
    UDS_PATH:    udsMock.path,
    SANDBOX_URL: sbMock.url,
    STATIC_ROOT: bridgeRoot,
  });
  t.after(() => {
    bridge.child.kill('SIGTERM');
    return Promise.all([
      new Promise((r) => udsMock.server.close(r)),
      new Promise((r) => sbMock.httpServer.close(r)),
    ]);
  });

  const ws = new WebSocket(bridge.url.replace('http', 'ws') + '/ws');
  await new Promise((r, j) => { ws.once('open', r); ws.once('error', j); });

  // CSandboxOpen -> expect SSandboxOpened with sid
  ws.send(JSON.stringify({ v: 1, ts: 0, msg: { tag: 'CSandboxOpen' } }));
  const opened = await awaitMessage(ws, (m) => m.msg.tag === 'SSandboxOpened');
  const sid = opened.msg.contents;
  assert.equal(typeof sid, 'string');

  // SSandboxStdout (mock prompt) follows
  await awaitMessage(ws, (m) => m.msg.tag === 'SSandboxStdout');

  // CSandboxStdin -> SSandboxStdout
  ws.send(JSON.stringify({ v: 1, ts: 0, msg: { tag: 'CSandboxStdin', contents: [sid, ':t Nat'] } }));
  const out = await awaitMessage(ws,
    (m) => m.msg.tag === 'SSandboxStdout' && Array.isArray(m.msg.contents) && m.msg.contents[1].includes('echo:'));
  assert.match(out.msg.contents[1], /echo:/);

  // CSandboxClose -> SSandboxExit
  ws.send(JSON.stringify({ v: 1, ts: 0, msg: { tag: 'CSandboxClose', contents: sid } }));
  const exited = await awaitMessage(ws, (m) => m.msg.tag === 'SSandboxExit');
  assert.equal(exited.msg.contents[0], sid);

  ws.close();
});

test('bridge: serves static index.html from STATIC_ROOT', async (t) => {
  // Use bridgeRoot itself as static — it has package.json.
  const udsMock = await startMockUds();
  const sbMock  = await startMockSandbox();
  const bridge  = await startBridge({
    UDS_PATH:    udsMock.path,
    SANDBOX_URL: sbMock.url,
    STATIC_ROOT: bridgeRoot,
  });
  t.after(() => {
    bridge.child.kill('SIGTERM');
    return Promise.all([
      new Promise((r) => udsMock.server.close(r)),
      new Promise((r) => sbMock.httpServer.close(r)),
    ]);
  });

  // Static handler treats / as /index.html; bridgeRoot has no index.html
  // but package.json should serve.
  const url = bridge.url + '/package.json';
  const res = await fetch(url);
  assert.equal(res.status, 200);
  const body = await res.json();
  assert.equal(body.name, 'learn-idris-bridge');
});
