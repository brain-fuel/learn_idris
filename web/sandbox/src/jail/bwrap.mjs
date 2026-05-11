// bwrap (Bubblewrap) jail adapter.
//
// Strategy: read-only bind only the bits idris2 actually needs (system libs,
// pack-installed packages, ~/.idris2), give it an empty tmpfs at /tmp, no
// network, no shared IPC/PID/UTS. Then wrap the inner argv with prlimit so
// memory/CPU caps survive even if bwrap itself doesn't enforce them.

import { execSync } from 'node:child_process';

export const name = 'bwrap';

export function available() {
  try {
    execSync('command -v bwrap', { stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
}

/**
 * Resolve the actual idris2 binary path. The pack-installed `idris2` on
 * PATH is a shim that calls pack to dispatch; inside a sandboxed PID
 * namespace with no network and a pruned PATH, the shim chain is
 * unreliable. We ask pack for the real binary path once at startup.
 */
function resolveIdris2() {
  try {
    return execSync('pack app-path idris2', { encoding: 'utf8' }).trim();
  } catch {
    // Fallback: trust whatever's on PATH (works if `idris2` is the real bin).
    return 'idris2';
  }
}

const IDRIS2_BIN = resolveIdris2();

export function command(argv) {
  const home      = process.env.HOME ?? '/root';
  const pkgRoot   = process.env.IDRIS2_PKG_ROOT ?? `${home}/.local/state/pack/install`;
  const idrisHome = process.env.IDRIS2_HOME      ?? `${home}/.idris2`;

  // Replace argv[0] with the resolved absolute path.
  const inner = argv[0] === 'idris2' ? [IDRIS2_BIN, ...argv.slice(1)] : argv;

  // On modern Debian/Ubuntu /bin /lib /lib64 are all symlinks into /usr.
  // Recreate those symlinks inside the sandbox so #!/bin/sh and ld-linux
  // resolve. Then bind /usr + everything else.
  return [
    'bwrap',
    '--ro-bind',  '/usr',     '/usr',
    '--symlink',  'usr/bin',  '/bin',
    '--symlink',  'usr/sbin', '/sbin',
    '--symlink',  'usr/lib',  '/lib',
    '--symlink',  'usr/lib64','/lib64',
    '--ro-bind',  '/etc',     '/etc',
    '--ro-bind',  pkgRoot,    pkgRoot,
    '--ro-bind',  idrisHome,  idrisHome,
    '--proc',     '/proc',
    '--dev',      '/dev',
    '--tmpfs',    '/tmp',
    '--unshare-net',
    '--unshare-ipc',
    '--unshare-pid',
    '--unshare-uts',
    '--die-with-parent',
    '--new-session',
    '--',
    '/usr/bin/prlimit',
    '--as=268435456',       // 256 MB virtual memory
    '--cpu=30',             // 30 CPU-seconds
    '--nproc=16',
    '--',
    ...inner,
  ];
}
