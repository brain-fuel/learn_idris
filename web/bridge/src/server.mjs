// Bridge entry: HTTP for static client + /ws for the LiveView-style
// message channel. Each WS connection gets its own handler closure that
// knows its `browserWs`, the shared UDS client, and the shared sandbox
// client.

import http from 'node:http';
import { WebSocketServer } from 'ws';
import pino from 'pino';
import { config } from './config.mjs';
import { staticHandler } from './static.mjs';
import { UdsClient } from './udsClient.mjs';
import { SandboxClient } from './sandboxClient.mjs';
import { makeHandler } from './handlers.mjs';

const log = pino({ level: config.logLevel });

const httpServer = http.createServer(staticHandler(config.staticRoot));
const wss = new WebSocketServer({ server: httpServer, path: '/ws' });

const uds     = new UdsClient(config.udsPath, log);
const sandbox = new SandboxClient(config.sandboxUrl, log);

wss.on('connection', (browserWs, req) => {
  log.info({ remote: req.socket.remoteAddress }, 'browser WS connected');
  const handler = makeHandler({ browserWs, uds, sandbox, log });
  browserWs.on('message', handler);
  browserWs.on('close',   () => sandbox.releaseBrowser(browserWs));
  browserWs.on('error',   (err) => log.error({ err: err.message }, 'browser WS error'));
});

httpServer.listen(config.port, config.host, () => {
  const addr = httpServer.address();
  const port = typeof addr === 'object' && addr ? addr.port : config.port;
  // Stable line for tests:
  console.log(`BRIDGE_LISTENING http://${config.host}:${port}`);
  log.info({ port, udsPath: config.udsPath, sandbox: config.sandboxUrl }, 'bridge listening');
});

for (const sig of ['SIGINT', 'SIGTERM']) {
  process.on(sig, () => {
    log.info({ sig }, 'shutting down');
    wss.close();
    httpServer.close();
    process.exit(0);
  });
}
