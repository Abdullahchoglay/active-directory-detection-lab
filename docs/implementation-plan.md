# Implementation Plan

## Phase 0 — Migration and recovery — completed

- [x] Confirm destination laptop CPU, RAM, free disk and virtualization support.
- [x] Resume the transferred Wazuh VM and perform a normal shutdown.
- [x] Record a powered-off SHA-256 baseline for the transferred VDI.
- [x] Create and register a separate permanent clone.
- [x] Validate dashboard, API, SSH, agent and enrollment reachability.
- [x] Retain the original transferred copy non-running as recovery media.
- [x] Verify the dashboard-advertised Wazuh version (`4.14.7`).
- [x] Verify guest package consistency and filesystem health after authenticated guest access.
- [x] Verify Windows agent enrollment and bidirectional event transport.
- [x] Verify a uniquely identified Windows scenario in the dashboard and record representative decoded Windows fields.
- [x] Record exact Wazuh decoder and rule fields for the scenario's Event ID `4740` lockout record.
- [x] Record exact built-in Wazuh mappings for the scenario's Event IDs `4720`, `4728`, `4767` and `4725`.

## Phase 1 — Network design — completed for the current two-VM baseline

- [x] Attach Wazuh to the dedicated VirtualBox internal network `AD-LAB`.
- [x] Bind host-side Wazuh management forwarding to localhost only.
- [x] Assign a stable RFC1918 address to the domain controller without publishing the exact value.
- Keep Active Directory services off normal Wi-Fi and bridged home-LAN interfaces.
- Assign stable lab addresses and document boundaries without publishing sensitive details.
- Permit only required Wazuh enrollment, agent and administrative traffic.

## Phase 2 — Domain controller

- [x] Create the powered-off `AD-DC01` VM with EFI, 3 GB RAM, 2 vCPU and a 64 GB dynamic disk.
- [x] Attach the primary adapter to `AD-LAB` and a temporary secondary adapter to outbound NAT.
- [x] Acquire and hash a supported Windows Server evaluation from an official source.
- [x] Install Windows Server 2025 Standard Evaluation (Desktop Experience) through the first-run credential handoff.
- [x] Complete the built-in Administrator password step and first sign-in without storing the password in project artifacts.
- [x] Rename the host `AD-DC01`, name both adapters and assign a static RFC1918 address to isolated `AD-LAB`.
- [x] Install the AD DS role and management tools.
- [x] Re-test two vCPUs after installation. Both tests reproduced the EFI `DXE_AP` stall, so one vCPU is the verified bootable configuration on this host.
- [x] Complete recommended Windows quality updates before isolation and promotion.
- [x] Configure static addressing, local DNS, AD DS and fictional forest `bluevale.test`.
- [x] Disable temporary NAT before promotion.
- [x] Create the protected lab OU hierarchy and fictional security groups.
- [x] Create and safely retire the first password-backed fictional identity only within a bounded controlled scenario.
- [x] Establish a documented account-lockout policy.
- [x] Capture clean powered-off snapshot `ad-ds-baseline-2026-11-02`.

## Phase 3 — Telemetry — local and transport baseline completed

- [x] Record exact Windows, Wazuh and Sysmon versions.
- [x] Configure recommended Advanced Audit Policy subcategories.
- [x] Enroll the domain controller in Wazuh.
- [x] Collect Application, Security, System and PowerShell event channels.
- [x] Add reviewed Sysmon telemetry.
- [x] Validate local event generation before writing custom rules.
- [x] Verify bidirectional encrypted transport on the isolated link.
- [x] Correlate the unique scenario account to live dashboard events and capture representative decoded fields.
- [x] Capture exact Wazuh rule ID, level, groups and lockout-specific fields for Event ID `4740`.
- [x] Capture exact rule ID, level, groups and ATT&CK fields for account creation, group membership, unlock and disable events.

## Phase 4 — Detection engineering — completed for v1.0

- [x] Baseline built-in Wazuh coverage for the first lockout and account-lifecycle sequence.
- [x] Document why redundant custom rules were not deployed for the verified built-in alerts.
- [x] Record rule IDs, levels, decoded fields and ATT&CK mappings for five failure alerts, one lockout and four lifecycle alerts.
- [x] Mark custom-rule collision checks, XML deployment and `wazuh-logtest` as not applicable because no custom XML was deployed.
- [x] Avoid an unnecessary manager restart.

## Phase 5 — Scenarios and investigations — completed for v1.0

The bounded `IR-001` scenario:

1. [x] Generated a unique marker.
2. [x] Recorded exact local time, timezone and the clock-quality caveat.
3. [x] Confirmed the local events and bounded counts.
4. [x] Confirmed live Wazuh ingestion and exact built-in rules.
5. [x] Recorded relevant identity, host, process and authentication fields.
6. [x] Produced an investigation and analyst conclusion.
7. [x] Stated unverified portions and cleanup state explicitly.

## Phase 6 — Publication review — release gate

- [x] Validate the committed PowerShell helper; custom XML validation is not applicable.
- [x] Sanitize and rescan the complete Git history.
- [x] Review every screenshot.
- [x] Check Markdown links and repository structure.
- [x] Remove draft wording and unsupported claims.
- [x] Confirm final local and remote branches match after publication.
- [ ] Recreate the signed-off `v1.0.0` tag on the final commit and publish the GitHub release when explicitly authorized.
