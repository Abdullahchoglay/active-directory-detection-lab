# Implementation Plan

## Phase 0 — Migration and recovery — completed

- [x] Confirm destination laptop CPU, RAM, free disk and virtualization support.
- [x] Resume the transferred Wazuh VM and perform a normal shutdown.
- [x] Record a powered-off SHA-256 baseline for the transferred VDI.
- [x] Create and register a separate permanent clone.
- [x] Validate dashboard, API, SSH, agent and enrollment reachability.
- [x] Retain the original transferred copy powered off.
- [x] Verify the dashboard-advertised Wazuh version (`4.14.7`).
- [ ] Verify guest package consistency and filesystem expansion after authenticated guest access.
- [ ] Verify end-to-end Windows event ingestion after the first lab agent is enrolled.

## Phase 1 — Network design — in progress

- [x] Attach Wazuh to the dedicated VirtualBox internal network `AD-LAB`.
- [x] Bind host-side Wazuh management forwarding to localhost only.
- [ ] Assign stable internal addresses after the domain-controller VM exists.
- Keep Active Directory services off normal Wi-Fi and bridged home-LAN interfaces.
- Assign stable lab addresses and document boundaries without publishing sensitive details.
- Permit only required Wazuh enrollment, agent and administrative traffic.

## Phase 2 — Domain controller

- [x] Create the powered-off `AD-DC01` VM with EFI, 3 GB RAM, 2 vCPU and a 64 GB dynamic disk.
- [x] Attach the primary adapter to `AD-LAB` and a temporary secondary adapter to outbound NAT.
- [x] Acquire and hash a supported Windows Server evaluation from an official source.
- [x] Install Windows Server 2025 Standard Evaluation (Desktop Experience) through the first-run credential handoff.
- [x] Complete the built-in Administrator password step and first sign-in without storing the password in project artifacts.
- [x] Rename the host `AD-DC01`, name both adapters and assign `an isolated RFC1918 address` to isolated `AD-LAB`.
- [x] Install the AD DS role and management tools.
- [x] Re-test two vCPUs after installation. Both tests reproduced the EFI `DXE_AP` stall, so one vCPU is the verified bootable configuration on this host.
- [ ] Complete recommended Windows quality updates before isolation and promotion.
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
