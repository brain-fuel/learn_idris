// Per-control-WS session registry. Enforces concurrent cap, routes incoming
// W2S messages by sid, and reaps every child on control-WS close.

import { Session } from './session.mjs';

export class Sessions {
  /**
   * @param {object} jail   selected jail adapter
   * @param {object} cfg    { maxLive, idleMs, wallMs }
   * @param {object} log    pino logger
   * @param {(msg) => void} emit  send-to-server callback
   */
  constructor(jail, cfg, log, emit) {
    this.jail = jail;
    this.cfg  = cfg;
    this.log  = log;
    this.emit = emit;
    this.byId = new Map();
  }

  dispatch(msg) {
    switch (msg.kind) {
      case 'Open':  return this.open(msg.sid);
      case 'Stdin': return this.stdin(msg.sid, msg.data);
      case 'Close': return this.close(msg.sid);
    }
  }

  open(sid) {
    if (this.byId.has(sid)) {
      this.emit({ kind: 'Denied', sid, reason: 'sid already open' });
      return;
    }
    if (this.byId.size >= this.cfg.maxLive) {
      this.emit({ kind: 'Denied', sid, reason: 'session cap reached' });
      return;
    }
    const session = new Session(sid, this.jail, this.cfg, this.log, (out) => {
      this.emit(out);
      if (out.kind === 'Exited') this.byId.delete(sid);
    });
    this.byId.set(sid, session);
  }

  stdin(sid, data) {
    const session = this.byId.get(sid);
    if (!session) {
      this.emit({ kind: 'Denied', sid, reason: 'unknown sid' });
      return;
    }
    if (data.length === 0) return;          // no-op + no token charge
    session.feed(data);
  }

  close(sid) {
    const session = this.byId.get(sid);
    if (!session) {
      this.emit({ kind: 'Denied', sid, reason: 'unknown sid' });
      return;
    }
    session.close();
  }

  reapAll() {
    for (const s of this.byId.values()) s.close('control-WS disconnect');
    this.byId.clear();
  }
}
