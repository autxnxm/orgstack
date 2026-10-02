# 0001: Use Podman Quadlets for Container Orchestration

## Status
Accepted

## Context
orgstack runs a multi-service stack on bare-metal hosts. We need
boot-persistent, dependency-aware startup without a cluster.

## Decision
Define each service as a Podman Quadlet (`*.container`, `*.volume`)
under `~/.config/containers/systemd/` or `/etc/containers/systemd/`.
systemd handles lifecycle, ordering, and restart policy.

## Consequences
- No Docker daemon; no Compose.
- Logs via `journalctl`.
- Requires Podman 4.4+.
- SELinux volume mounts need `:Z`.
