# Implementation Plan

## Phase 0 — Migration and recovery

- Confirm destination laptop CPU, RAM, free disk and virtualization support.
- Resume the existing Wazuh VM and perform a normal shutdown.
- Copy the complete powered-off VM directory over an isolated Ethernet link.
- Compare SHA-256 hashes between source and destination.
- Register the copied VM without running both copies simultaneously.
- Validate manager, indexer, dashboard, SSH and endpoint ingestion.
- Retain the source copy until validation is complete.

## Phase 1 — Network design

- Use a dedicated private lab subnet with no public routing.
- Keep Active Directory services off normal Wi-Fi and bridged home-LAN interfaces.
- Assign stable lab addresses and document boundaries without publishing sensitive details.
- Permit only required Wazuh enrollment, agent and administrative traffic.

## Phase 2 — Domain controller

- Install a supported Windows Server evaluation from an official source.
- Apply updates before isolation where necessary.
- Configure static addressing, DNS, AD DS and a test forest.
- Create organizational units, test users and test groups.
- Establish a documented account-lockout policy.
- Capture a clean baseline and recovery point.

## Phase 3 — Telemetry

- Record exact Windows, Wazuh and Sysmon versions.
- Configure recommended Advanced Audit Policy subcategories.
- Enroll the domain controller in Wazuh.
- Collect Security, System and PowerShell event channels.
- Add Sysmon only for telemetry that materially improves the investigation.
- Validate local event generation before writing custom rules.

## Phase 4 — Detection engineering

- Baseline built-in Wazuh coverage.
- Use a reserved project-specific custom-rule range after checking for collisions.
- Validate XML before deployment.
- Test representative events with `wazuh-logtest`.
- Restart services only after configuration validation and backup.
- Record rule IDs, levels, decoded fields and ATT&CK mappings.

## Phase 5 — Scenarios and investigations

Each scenario will:

1. Generate a unique marker.
2. Record exact local time and timezone.
3. Confirm the local event.
4. Confirm live Wazuh ingestion or independent rule validation.
5. Record relevant identities, hosts, processes and authentication fields.
6. Produce a concise investigation and analyst conclusion.
7. Explicitly state unverified portions.

## Phase 6 — Publication review

- Validate XML, PowerShell and Markdown.
- Scan tracked files and history for secrets.
- Review every screenshot.
- Check links and repository structure.
- Remove placeholders and unsupported claims.
- Confirm local and remote branches match.
- Publish only after final evidence review.
