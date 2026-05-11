// Minimal static file handler. Resolves URLs against a fixed root,
// rejects path traversal, sets a sane content-type, streams the file.

import { createReadStream } from 'node:fs';
import { stat } from 'node:fs/promises';
import { resolve, extname, normalize } from 'node:path';

const MIME = {
  '.html': 'text/html; charset=utf-8',
  '.css':  'text/css; charset=utf-8',
  '.js':   'application/javascript; charset=utf-8',
  '.mjs':  'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.md':   'text/markdown; charset=utf-8',
  '.svg':  'image/svg+xml',
  '.png':  'image/png',
  '.jpg':  'image/jpeg',
  '.ico':  'image/x-icon',
};

export function staticHandler(rootArg) {
  const root = resolve(rootArg);

  return async (req, res) => {
    let url = req.url.split('?')[0];
    if (url === '/' || url === '') url = '/index.html';
    const rel = normalize(url).replace(/^\/+/, '');
    const full = resolve(root, rel);

    if (!full.startsWith(root + '/') && full !== root) {
      res.writeHead(403).end('forbidden');
      return;
    }

    try {
      const s = await stat(full);
      if (!s.isFile()) { res.writeHead(404).end('not found'); return; }
    } catch {
      res.writeHead(404).end('not found');
      return;
    }

    const type = MIME[extname(full).toLowerCase()] ?? 'application/octet-stream';
    res.writeHead(200, { 'content-type': type, 'cache-control': 'no-cache' });
    createReadStream(full).pipe(res);
  };
}
