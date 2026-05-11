// Sandbox bridge layer.
//
// One WS connection to the sandbox worker's :7401/control. Each browser
// session gets a per-browser sandbox `sid` derived from a counter; the
// sandbox W2S/S2W protocol talks in those sids. We map sandbox-side
// `sid` -> the browser WS that owns it, so S2W frames route back to the
// right browser as `SSandbox*` envelopes.

import { WebSocket } from 'ws';

let sidCounter = 0;
const nextSid = () => `sb${++sidCounter}-${Date.now()}`;

export class SandboxClient {
  constructor(url, log) {
    this.url = url;
    this.log = log;
    this.ws  = null;
    this.bySid    = new Map();   // sid -> { browserWs }
    this.browserToSids = new WeakMap(); // browserWs -> Set<sid>
  }

  ensureConn() {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) return;
    if (this.ws && this.ws.readyState === WebSocket.CONNECTING) return;
    this.log.info({ url: this.url }, 'sandbox: connecting');
    this.ws = new WebSocket(this.url);
    this.ws.on('open',    () => this.log.info('sandbox: open'));
    this.ws.on('message', (raw) => this.onSandboxMessage(raw.toString()));
    this.ws.on('close',   () => {
      this.log.warn('sandbox: closed; pending sids will error');
      for (const [sid, { browserWs }] of this.bySid) {
        this.emitToBrowser(browserWs, sandboxEnvelope('SError', ['SandboxBusy', 'sandbox worker disconnected']));
      }
      this.bySid.clear();
    });
    this.ws.on('error', (err) => this.log.error({ err: err.message }, 'sandbox: ws error'));
  }

  /**
   * openFor(browserWs, _userSid): allocates a fresh sandbox sid, sends
   * `Open` to the worker, returns the chosen sid (also stored in the
   * browser-side map).
   */
  openFor(browserWs) {
    this.ensureConn();
    const sid = nextSid();
    this.bySid.set(sid, { browserWs });
    let set = this.browserToSids.get(browserWs);
    if (!set) { set = new Set(); this.browserToSids.set(browserWs, set); }
    set.add(sid);
    this.sendWhenReady({ kind: 'Open', sid });
    return sid;
  }

  stdin(sid, data) {
    if (!this.bySid.has(sid)) return false;
    this.sendWhenReady({ kind: 'Stdin', sid, data });
    return true;
  }

  close(sid) {
    if (!this.bySid.has(sid)) return false;
    this.sendWhenReady({ kind: 'Close', sid });
    return true;
  }

  releaseBrowser(browserWs) {
    const set = this.browserToSids.get(browserWs);
    if (!set) return;
    for (const sid of set) this.sendWhenReady({ kind: 'Close', sid });
    this.browserToSids.delete(browserWs);
  }

  sendWhenReady(msg) {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(JSON.stringify(msg));
      return;
    }
    this.ws?.once('open', () => this.ws.send(JSON.stringify(msg)));
  }

  onSandboxMessage(raw) {
    let msg;
    try { msg = JSON.parse(raw); } catch { return; }
    const entry = this.bySid.get(msg.sid);
    if (!entry) return;
    const { browserWs } = entry;
    switch (msg.kind) {
      case 'Opened':
        this.emitToBrowser(browserWs, sandboxEnvelope('SSandboxOpened', msg.sid));
        break;
      case 'Stdout':
        this.emitToBrowser(browserWs, sandboxEnvelope('SSandboxStdout', [msg.sid, msg.chunk]));
        break;
      case 'Stderr':
        this.emitToBrowser(browserWs, sandboxEnvelope('SSandboxStderr', [msg.sid, msg.chunk]));
        break;
      case 'Exited':
        this.emitToBrowser(browserWs, sandboxEnvelope('SSandboxExit', [msg.sid, msg.code]));
        this.bySid.delete(msg.sid);
        this.browserToSids.get(browserWs)?.delete(msg.sid);
        break;
      case 'Denied':
        this.emitToBrowser(browserWs, sandboxEnvelope('SError', ['SandboxBusy', msg.reason]));
        this.bySid.delete(msg.sid);
        this.browserToSids.get(browserWs)?.delete(msg.sid);
        break;
    }
  }

  emitToBrowser(browserWs, env) {
    if (browserWs.readyState !== browserWs.OPEN) return;
    browserWs.send(JSON.stringify(env));
  }
}

function sandboxEnvelope(tag, contents) {
  return {
    v: 1,
    ts: Date.now(),
    msg: { tag, contents },
  };
}
