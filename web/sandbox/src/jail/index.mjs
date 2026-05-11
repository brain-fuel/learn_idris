// Jail adapter selector. Picks an adapter by name, refuses to start if the
// binary is missing.

import * as bwrap    from './bwrap.mjs';
import * as firejail from './firejail.mjs';
import * as nsjail   from './nsjail.mjs';
import * as none     from './none.mjs';

const ADAPTERS = { bwrap, firejail, nsjail, none };

/**
 * select(name, log): adapter
 * Throws if `name` is unknown or the adapter's binary isn't installed.
 * `log` is a pino logger (or any obj w/ .info/.warn).
 */
export function select(name, log) {
  const adapter = ADAPTERS[name];
  if (!adapter) {
    throw new Error(`unknown JAIL=${name}; valid: ${Object.keys(ADAPTERS).join(', ')}`);
  }
  if (!adapter.available()) {
    throw new Error(
      `JAIL=${name} selected but binary not found; install it or set JAIL=none for unsafe debug mode`
    );
  }
  if (adapter.warning) log.warn(adapter.warning());
  else                 log.info({ jail: name }, 'jail backend selected');
  return adapter;
}
