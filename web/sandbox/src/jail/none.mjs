// Passthrough adapter: no isolation. NEVER use in production.

export const name = 'none';

export function available() {
  return true;
}

export function command(argv) {
  return argv;
}

export function warning() {
  return 'WARN: JAIL=none — sandbox isolation DISABLED. Do not deploy.';
}
