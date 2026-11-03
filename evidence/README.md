# Evidence

Only reviewed, sanitized evidence summaries belong here.

Raw EVTX files, packet captures, unrestricted JSON exports, credentials, machine identifiers and sensitive screenshots are excluded. Each evidence item must identify whether it represents local telemetry, rule-test validation or a live Wazuh alert.

## Current evidence index

- [`MIG-001`](MIG-001-migration-validation.md) — migrated Wazuh VM validation
- [`ACQ-001`](ACQ-001-windows-server-media.md) — Windows Server evaluation-media acquisition
- [`AD-001`](AD-001-domain-controller-baseline.md) — sanitized domain-controller baseline validation
- [`AUD-001`](AUD-001-windows-audit-baseline.md) — Windows Advanced Audit Policy, PowerShell logging and retention baseline
- [`WAZ-001`](WAZ-001-domain-controller-agent.md) — domain-controller agent and isolated transport validation
- [`SYS-001`](SYS-001-sysmon-telemetry.md) — Sysmon, Wazuh event-channel and telemetry-flow baseline
- [`WAZ-002`](WAZ-002-controlled-lockout-indexing.md) — live Wazuh indexing correlation for the controlled lockout scenario
- [`WAZ-003`](WAZ-003-account-lifecycle-indexing.md) — live Wazuh rule mapping for controlled account and group changes
