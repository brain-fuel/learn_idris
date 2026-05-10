# firejail profile for sandboxed idris2 REPL sessions.
# Used by web/sandbox/src/jail.mjs:
#   firejail --profile=/path/to/idris2.firejail.profile -- idris2 --no-banner
# nsjail fallback expresses the same constraints via --rlimit_as,
# --cgroup_mem_max, --disable_clone_newnet=false.
#
# REQUIRES VALIDATION: idris2 starts cleanly under `net none` with
# the whitelisted package path read-only. Spike before deploy.

caps.drop all
seccomp
netfilter
net none

private
private-tmp
private-dev
nosound
no3d
nodvd
notv
nou2f
noprinters

# 256 MB virtual memory cap
rlimit-as 268435456
# 30 CPU-seconds per session
rlimit-cpu 30
# 4 MB max file size (output capture)
rlimit-fsize 4194304
rlimit-nofile 64
rlimit-nproc 16

# Read-only system + idris2 package store
read-only /usr
read-only /home/sandbox/idris2-pkgs

# Per-session ephemeral working directory (created by jail.mjs before exec)
whitelist /home/sandbox/work
