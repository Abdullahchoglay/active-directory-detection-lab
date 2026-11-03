# MIG-001 — Wazuh VM migration validation

## Summary

On 1 November 2026, the transferred Wazuh VirtualBox VM was assessed, shut down normally, hashed, cloned into permanent lab storage, and boot-tested. The original transfer copy remains powered off and has not been deleted.

## Source baseline

- Source state before hashing: powered off
- Source VDI virtual capacity: approximately 42 GB
- Source VDI SHA-256: `C39572A002130F48DD68946BAA52F8A5EBF4BC94369879D758119A48BA9688BF`
- VirtualBox accepted the medium and reported no disk corruption or attachment errors.
- No original source-side checksum manifest was present on the receiving laptop, so this is a post-transfer baseline rather than an independent proof against the sender's original hash.

## Permanent clone

- Clone name: `Wazuh-Primary`
- Clone storage: dedicated local lab directory outside the transfer staging folder
- RAM: 4.5 GB
- vCPU: 2
- Dynamic disk capacity: 64 GB
- Powered-off clone VDI SHA-256: `BD49999C2026764B93D90B20C063F06A06E14E1FFCA8997DC806A5204AAF8C97`
- Adapter 1: VirtualBox NAT with management forwards bound only to localhost
- Adapter 2: VirtualBox internal network `AD-LAB`
- Clipboard, drag-and-drop, audio and recording: disabled
- Original transfer VM: retained powered off as the recovery copy
- Recovery snapshot: `migration-verified-2026-11-01`

The virtual disk was expanded at the VirtualBox layer. Authenticated guest validation later showed a 41 GB root filesystem with approximately 15 GB free. Guest expansion is therefore deferred and is not claimed complete.

## Live validation

The clone booted and obtained its private NAT address. The following checks passed from the host through localhost-only forwarding:

| Check | Result |
|---|---|
| Wazuh agent listener | TCP 1514 reachable |
| Agent enrollment listener | TCP 1515 reachable |
| SSH listener | TCP 2222 reachable |
| Dashboard | HTTP 302 redirect to `/app/login` |
| Wazuh API | HTTP 401 with `No authorization token provided` |
| Dashboard metadata | Wazuh `4.14.7`, OpenSearch Dashboards `2.19.5` |
| Guest package consistency | Manager, indexer, dashboard and Filebeat `4.14.7-1` |
| Core services | Manager, indexer, dashboard and Filebeat active |

The dashboard initially returned `503 Wazuh dashboard server is not ready yet` while the indexer and dashboard initialized. It reached the login redirect after approximately three minutes. The API subsequently returned its expected authentication challenge.

## Evidence classification

- VirtualBox configuration and storage evidence: locally verified
- Service reachability: locally verified from the host
- Dashboard/API readiness: live endpoint verification
- Dashboard-advertised Wazuh version: live verified as `4.14.7`
- Package-level version consistency inside the guest: verified
- Domain-controller agent service and bidirectional TCP `1514` transport: verified in `WAZ-001`
- Dashboard-indexed scenario event: not yet verified

## Conclusion

The migration recovery gate is satisfied. The permanent clone boots, exposes management services only through local forwarding, and receives bidirectional agent transport over the VM-only lab network. The original transferred VM remains available and non-running as recovery media. Dashboard-level correlation was later verified in [`WAZ-002`](WAZ-002-controlled-lockout-indexing.md), [`WAZ-003`](WAZ-003-account-lifecycle-indexing.md) and [`WAZ-004`](WAZ-004-failed-logon-indexing.md).
