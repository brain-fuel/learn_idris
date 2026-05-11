// Sandbox worker entry. One control WS endpoint, one Sessions registry per
// connection. Designed for loopback use only — never expose :7401 publicly.

import { WebSocketServer } from 'ws';
import pino from 'pino';
import { config } from './config.mjs';
import { parse, encode } from './protocol.mjs';
import { Sessions } from './sessions.mjs';
import { select } from './jail/index.mjs';

const log  = pino({ level: config.logLevel });
const jail = select(config.jail, log);

const wss = new WebSocketServer({
  host: config.host,
  port: config.port,
  path: config.path,
});

wss.on('listening', () => {
  const addr = wss.address();
  // PORT=0 picks a random port; we log the actual one so smoke tests can read it.
  const port = typeof addr === 'object' && addr ? addr.port : config.port;
  // Stable, machine-parseable line for tests:
  console.log(`SANDBOX_LISTENING ws://${config.host}:${port}${config.path}`);
  log.info({ port, jail: jail.name }, 'sandbox worker listening');
});

wss.on('connection', (ws, req) => {
  log.info({ remote: req.socket.remoteAddress }, 'control WS connected');

  const emit = (msg) => {
    if (ws.readyState !== ws.OPEN) return;
    try { ws.send(encode(msg)); }
    catch (err) { log.error({ err: err.message, msg }, 'send failed'); }
  };

  const sessions = new Sessions(jail, config, log, emit);

  ws.on('message', (raw, isBinary) => {
    if (isBinary) {
      emit({ kind: 'Denied', sid: '', reason: 'binary frames not supported' });
      return;
    }
    const result = parse(raw.toString('utf8'));
    if (!result.ok) {
      emit({ kind: 'Denied', sid: '', reason: result.error });
      return;
    }
    sessions.dispatch(result.value);
  });

  ws.on('close', () => {
    log.info('control WS closed; reaping sessions');
    sessions.reapAll();
  });

  ws.on('error', (err) => {
    log.error({ err: err.message }, 'control WS error');
  });
});

// Graceful shutdown
for (const sig of ['SIGINT', 'SIGTERM']) {
  process.on(sig, () => {
    log.info({ sig }, 'shutting down');
    wss.close();
    process.exit(0);
  });
}
