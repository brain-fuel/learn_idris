// nsjail jail adapter. Mirrors the bwrap constraint matrix using nsjail's
// own flag vocabulary.

import { execSync } from 'node:child_process';

export const name = 'nsjail';

export function available() {
  try {
    execSync('command -v nsjail', { stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
}

export function command(argv) {
  const home      = process.env.HOME ?? '/root';
  const pkgRoot   = process.env.IDRIS2_PKG_ROOT ?? `${home}/.local/state/pack/install`;
  const idrisHome = process.env.IDRIS2_HOME      ?? `${home}/.idris2`;

  return [
    'nsjail',
    '--quiet',
    '--mode=o',                 // run-once
    '--disable_clone_newnet',   // unshare net
    '--rlimit_as', '268435456',
    '--time_limit', '30',
    '--rlimit_nproc', '16',
    '--rlimit_fsize', '4194304',
    '--bindmount_ro', '/usr',
    '--bindmount_ro', '/lib',
    '--bindmount_ro', '/lib64',
    '--bindmount_ro', '/etc',
    '--bindmount_ro', pkgRoot,
    '--bindmount_ro', idrisHome,
    '--mount', 'none:/tmp:tmpfs:size=16777216',
    '--',
    ...argv,
  ];
}
