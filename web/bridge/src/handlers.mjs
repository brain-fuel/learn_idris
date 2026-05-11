// Per-browser-WS dispatcher. Splits incoming envelopes by route:
//   - sandbox-bound -> SandboxClient (Node owns the translation)
//   - state-bound   -> UdsClient (forward verbatim to Idris-on-Chez)

import { ClientEnvelope, routeFor } from './protocol.mjs';

export function makeHandler(ctx) {
  const { browserWs, uds, sandbox, log } = ctx;

  return async (raw) => {
    let env;
    try {
      const parsed = JSON.parse(raw.toString());
      env = ClientEnvelope.parse(parsed);
    } catch (err) {
      sendError(browserWs, env, 'ProtocolMismatch', `bad envelope: ${err.message}`);
      return;
    }

    const tag   = env.msg.tag;
    const route = routeFor(tag);

    if (route === 'sandbox') {
      handleSandbox(browserWs, sandbox, env);
      return;
    }

    try {
      const reply = await uds.send(env);
      browserWs.send(JSON.stringify(reply));
    } catch (err) {
      log.error({ err: err.message, tag }, 'uds send failed');
      sendError(browserWs, env, 'InternalError', `uds: ${err.message}`);
    }
  };
}

function handleSandbox(browserWs, sandbox, env) {
  const { tag, contents } = env.msg;
  switch (tag) {
    case 'CSandboxOpen':
      sandbox.openFor(browserWs);
      // Bridge does not echo a sync reply here; SSandboxOpened arrives
      // asynchronously once the sandbox worker confirms the spawn.
      return;
    case 'CSandboxStdin': {
      // Idris-side `CSandboxStdin SessionId String` encodes as
      //   { tag: "CSandboxStdin", contents: [sid, data] }
      const [sid, data] = Array.isArray(contents) ? contents : [];
      if (typeof sid !== 'string' || typeof data !== 'string') {
        sendError(browserWs, env, 'ProtocolMismatch', 'CSandboxStdin needs [sid, data]');
        return;
      }
      sandbox.stdin(sid, data);
      return;
    }
    case 'CSandboxClose': {
      const sid = typeof contents === 'string' ? contents : '';
      if (!sid) { sendError(browserWs, env, 'ProtocolMismatch', 'CSandboxClose needs sid'); return; }
      sandbox.close(sid);
      return;
    }
  }
}

function sendError(browserWs, envIn, code, msg) {
  if (browserWs.readyState !== browserWs.OPEN) return;
  const env = {
    v: envIn?.v ?? 1,
    ts: Date.now(),
    msg: { tag: 'SError', contents: [code, msg] },
  };
  browserWs.send(JSON.stringify(env));
}
