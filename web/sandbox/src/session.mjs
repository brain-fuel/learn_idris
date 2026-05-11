// One sandbox session = one long-lived idris2 child wrapped by the chosen
// jail. Owns the rate limiter + idle/wall-clock timers, and pipes stdout
// + stderr back to the supplied callback (which is the WS-emitter from the
// Sessions registry).

import { spawn } from 'node:child_process';
import { TokenBucket } from './ratelimit.mjs';

const STDIN_BUCKET_CAPACITY     = 20;
const STDIN_BUCKET_REFILL_PER_S = 1;

export class Session {
  /**
   * @param {string} sid
   * @param {object} jail   adapter from jail/index.mjs
   * @param {object} cfg    { idleMs, wallMs }
   * @param {object} log    pino-ish logger
   * @param {(msg: object) => void} emit
   */
  constructor(sid, jail, cfg, log, emit) {
    this.sid    = sid;
    this.cfg    = cfg;
    this.log    = log.child({ sid });
    this.emit   = emit;
    this.bucket = new TokenBucket(STDIN_BUCKET_CAPACITY, STDIN_BUCKET_REFILL_PER_S);
    this.idleTimer    = null;
    this.wallTimer    = null;
    this.killTimer    = null;
    this.alive        = false;
    this.spawn(jail);
  }

  spawn(jail) {
    const argv = jail.command(['idris2', '--no-banner', '--no-color']);
    this.log.info({ argv }, 'spawning idris2');
    const env = { ...process.env };  // pass IDRIS2_PACKAGE_PATH, HOME, PATH

    this.proc = spawn(argv[0], argv.slice(1), {
      stdio: ['pipe', 'pipe', 'pipe'],
      env,
    });
    this.alive = true;

    this.proc.stdout.on('data', (b) => this.onChunk('Stdout', b.toString('utf8')));
    this.proc.stderr.on('data', (b) => this.onChunk('Stderr', b.toString('utf8')));

    this.proc.on('exit', (code, signal) => {
      this.log.info({ code, signal }, 'child exited');
      this.alive = false;
      this.clearTimers();
      this.emit({ kind: 'Exited', sid: this.sid, code: code ?? -1 });
    });

    this.proc.on('error', (err) => {
      this.log.error({ err: err.message }, 'spawn error');
      this.alive = false;
      this.clearTimers();
      this.emit({ kind: 'Denied', sid: this.sid, reason: `spawn: ${err.message}` });
    });

    this.emit({ kind: 'Opened', sid: this.sid });
    this.armWallClock();
    this.armIdle();
  }

  onChunk(kind, chunk) {
    this.emit({ kind, sid: this.sid, chunk });
    this.armIdle();
  }

  /**
   * feed(data): caller already validated data is non-empty.
   */
  feed(data) {
    if (!this.alive) {
      this.emit({ kind: 'Denied', sid: this.sid, reason: 'session not alive' });
      return;
    }
    if (!this.bucket.consume(1)) {
      this.emit({ kind: 'Denied', sid: this.sid, reason: 'rate limit' });
      return;
    }
    try {
      this.proc.stdin.write(data + '\n');
    } catch (err) {
      this.log.warn({ err: err.message }, 'stdin write failed');
      this.emit({ kind: 'Denied', sid: this.sid, reason: `stdin: ${err.message}` });
      return;
    }
    this.armIdle();
  }

  close(reason = 'client requested') {
    if (!this.alive) return;
    this.log.info({ reason }, 'closing session');
    this.kill('SIGTERM');
    this.killTimer = setTimeout(() => this.kill('SIGKILL'), 2000).unref();
  }

  kill(signal) {
    try {
      this.proc.kill(signal);
    } catch (err) {
      this.log.warn({ err: err.message, signal }, 'kill failed');
    }
  }

  armIdle() {
    clearTimeout(this.idleTimer);
    this.idleTimer = setTimeout(() => {
      this.log.warn('idle timeout');
      this.close('idle timeout');
    }, this.cfg.idleMs).unref();
  }

  armWallClock() {
    this.wallTimer = setTimeout(() => {
      this.log.warn('wall-clock cap');
      this.close('wall-clock cap');
    }, this.cfg.wallMs).unref();
  }

  clearTimers() {
    clearTimeout(this.idleTimer);
    clearTimeout(this.wallTimer);
    clearTimeout(this.killTimer);
    this.idleTimer = this.wallTimer = this.killTimer = null;
  }
}
