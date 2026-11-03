# Detections

This directory contains one document per verified v1.0 detection objective.

Each document should describe:

- Data source and prerequisites
- Relevant event fields
- Detection logic and exclusions
- Expected Wazuh behavior
- False-positive considerations
- Triage questions
- MITRE ATT&CK mapping
- Links to sanitized evidence and investigations

Planned status is not evidence. Detection documents should be added only as telemetry is verified.

## Current detection objectives

- [`AD-LOCKOUT-001`](AD-LOCKOUT-001.md) — repeated failures followed by an account lockout
- [`AD-ACCOUNT-LIFECYCLE-001`](AD-ACCOUNT-LIFECYCLE-001.md) — account creation, group membership, unlock and disable monitoring
