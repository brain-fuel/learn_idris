// firejail jail adapter. Uses ../profiles/idris2.firejail.profile.

import { execSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, resolve } from 'node:path';

export const name = 'firejail';

export function available() {
  try {
    execSync('command -v firejail', { stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
}

export function command(argv) {
  const here = dirname(fileURLToPath(import.meta.url));
  const profile = resolve(here, '../../profiles/idris2.firejail.profile');
  return ['firejail', `--profile=${profile}`, '--quiet', '--', ...argv];
}
