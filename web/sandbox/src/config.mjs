// Env-driven config. Defaults match the master plan.

function intEnv(name, dflt) {
  const v = process.env[name];
  if (v === undefined) return dflt;
  const n = Number.parseInt(v, 10);
  if (Number.isNaN(n)) throw new Error(`env ${name}=${v} is not an integer`);
  return n;
}

export const config = {
  host:     process.env.HOST                ?? '127.0.0.1',
  port:     intEnv('PORT', 7401),
  path:     process.env.WS_PATH             ?? '/control',
  jail:     process.env.JAIL                ?? 'bwrap',
  maxLive:  intEnv('MAX_LIVE_SANDBOXES', 32),
  idleMs:   intEnv('IDLE_MS',  120_000),
  wallMs:   intEnv('WALL_MS',  600_000),
  logLevel: process.env.LOG_LEVEL           ?? 'info',
};
