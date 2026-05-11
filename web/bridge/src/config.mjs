// Env-driven config for the Node bridge.

function intEnv(name, dflt) {
  const v = process.env[name];
  if (v === undefined) return dflt;
  const n = Number.parseInt(v, 10);
  if (Number.isNaN(n)) throw new Error(`env ${name}=${v} is not an integer`);
  return n;
}

export const config = {
  host:        process.env.HOST         ?? '127.0.0.1',
  port:        intEnv('PORT', 8080),
  udsPath:     process.env.UDS_PATH     ?? '/tmp/learn-idris-server.sock',
  sandboxUrl:  process.env.SANDBOX_URL  ?? 'ws://127.0.0.1:7401/control',
  staticRoot:  process.env.STATIC_ROOT  ?? '../client/build/serve',
  logLevel:    process.env.LOG_LEVEL    ?? 'info',
};
