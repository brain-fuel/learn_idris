// Persistent Unix-socket client to the Idris-on-Chez server.
//
// Wire: 4-byte big-endian length prefix + UTF-8 JSON envelope. We open a
// fresh socket per request; v1 server is single-threaded blocking accept.
// (Multiplexing one persistent socket is a later optimisation that
// matches the eventual chez-native server in v2.)

import net from 'node:net';

export class UdsClient {
  constructor(path, log) {
    this.path = path;
    this.log  = log;
  }

  /**
   * send(envelope): Promise<replyEnvelope>
   * Opens a new socket, sends one length-prefixed JSON frame, reads one
   * reply, closes. Rejects on connect error or short read.
   */
  send(env) {
    return new Promise((resolve, reject) => {
      const sock = net.connect(this.path);
      let buf = Buffer.alloc(0);
      let expected = null;

      sock.on('connect', () => {
        const body = Buffer.from(JSON.stringify(env), 'utf8');
        const hdr  = Buffer.alloc(4);
        hdr.writeUInt32BE(body.length, 0);
        sock.write(Buffer.concat([hdr, body]));
      });

      sock.on('data', (chunk) => {
        buf = Buffer.concat([buf, chunk]);
        if (expected === null && buf.length >= 4) {
          expected = buf.readUInt32BE(0);
          buf = buf.subarray(4);
        }
        if (expected !== null && buf.length >= expected) {
          const payload = buf.subarray(0, expected).toString('utf8');
          sock.end();
          try {
            resolve(JSON.parse(payload));
          } catch (e) {
            reject(new Error(`UDS reply not JSON: ${e.message}`));
          }
        }
      });

      sock.on('error', (err) => reject(err));
      sock.on('close', () => {
        if (expected === null || buf.length < expected) {
          reject(new Error('UDS closed before full reply'));
        }
      });
    });
  }
}
