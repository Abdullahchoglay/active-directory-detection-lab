# Active Directory Threat Detection and Incident Response Lab

> **Status: First identity investigation verified end to end.** The domain controller is monitored by Wazuh and Sysmon. A controlled account-lockout investigation now includes local Windows evidence, a live level-9 lockout alert, and exact built-in Wazuh mappings for four companion account-lifecycle events. This private repository remains a working draft while additional scenarios are completed.

## Overview

This project will extend the existing [Home SOC Lab](https://github.com/Abdullahchoglay/home-soc-lab) and [Sysmon Detection Lab](https://github.com/Abdullahchoglay/sysmon-detection-lab) with identity-focused monitoring in an isolated Active Directory environment.

The planned lab will connect Windows domain telemetry to Wazuh, develop defensible detections, and document harmless controlled scenarios using local evidence, rule validation, and live alerts where available.

## Planned architecture

```mermaid
flowchart LR
    subgraph Host[Windows 11 VirtualBox host]
        W[Wazuh all-in-one VM]
        DC[Windows Server 2025 domain controller]
        C[Planned Windows client VM]
    end
    C -->|Domain authentication| DC
    DC -->|Security, System, PowerShell and selected Sysmon telemetry| W
    C -->|Endpoint telemetry| W
    W --> D[Wazuh dashboard]
```

The lab network will be isolated from the public internet. Active Directory services will not be exposed through bridged networking or public port forwarding.

## Objectives

- Build a small test-only Active Directory forest.
- Monitor the domain controller with Wazuh.
- Collect identity, Kerberos, account-management, PowerShell, task, service, and selected Sysmon telemetry.
- Develop focused custom Wazuh rules only where built-in coverage is insufficient.
- Investigate controlled activity using unique markers and exact timestamps.
- Map verified activity to appropriate MITRE ATT&CK techniques.
- Publish only sanitized evidence that supports each claim.

## Planned scenarios

| Area | Examples | Status |
|---|---|---|
| Authentication | Successful and failed domain logons | Planned |
| Authentication abuse | Bounded failures against a fictional test account | Local sequence and live Wazuh indexing verified |
| Account lifecycle | Create, disable, enable and delete test users | Create, unlock and disable live alerts verified; enable and delete remain planned |
| Access control | Add and remove a test user from a privileged group | Unprivileged group addition verified; privileged-group scenario remains planned |
| Lockout | Trigger and investigate a test-account lockout | Live Wazuh rule `60115`, level `9`, verified |
| Kerberos | TGT and service-ticket activity | Planned |
| Directory changes | Selected Group Policy or directory-object changes | Planned |
| Endpoint activity | Marked PowerShell, scheduled task and service creation | Planned |
| Process telemetry | Parent-child relationships, command lines and hashes | Planned |

## Evidence standard

Every completed scenario must record:

- A unique test marker
- Exact timestamp and timezone
- Host and test-account context
- Local Windows or Sysmon evidence
- Wazuh ingestion or independent rule-test evidence
- Event IDs, rule IDs, levels and relevant decoded fields
- MITRE ATT&CK mapping
- Analyst conclusion and limitations

Local evidence, synthetic rule testing, and live Wazuh alerts will always be identified separately.

## Safety boundaries

- Systems and accounts owned by the project author only
- Test identities and non-production passwords only
- No credential dumping, malware, destructive actions or uncontrolled exploit code
- No exposure of AD services to the public internet
- Configuration backups before changes
- Syntax validation before service restarts
- Service-health checks after material changes
- No credentials, private keys, personal identifiers or unsafe raw logs committed

See [scope and safety](docs/scope-and-safety.md) for the full working boundary.

## Verified infrastructure state

The Wazuh VM migration to the destination laptop was validated on 1 November 2026. The powered-off transferred disk received a SHA-256 baseline, a separate permanent clone was created, and the original transfer copy was retained as recovery media. The clone booted successfully; Wazuh agent and enrollment listeners were reachable, the dashboard redirected to its login page, and the API returned the expected unauthenticated `401` response.

The permanent clone uses Wazuh `4.14.7`, a 64 GB dynamic disk, 4.5 GB RAM, localhost-only management forwarding, and a second adapter on the VM-only `AD-LAB` internal network. Manager, indexer, dashboard and Filebeat packages were verified at `4.14.7-1`; all core services were active. The root filesystem remains healthy with approximately 15 GB free, so guest expansion is deferred rather than claimed complete. See [migration validation](evidence/MIG-001-migration-validation.md).

`AD-DC01` runs Windows Server 2025 Standard Evaluation (Desktop Experience), build `26100.33650`, from its dedicated 64 GB virtual disk. The isolated `AD-LAB` adapter uses a static RFC1918 address without a default gateway. The temporary NAT adapter is disabled at both the guest and VirtualBox link layers.

The server is the first domain controller and DNS server for the fictional `bluevale.test` forest (`BLUEVALE`, Windows Server 2025 functional levels). DNS resolution, core directory services, SYSVOL, NetLogon, advertising and replication checks passed. A protected lab OU hierarchy and five unprivileged fictional security groups were created. No user password is stored in this repository. The VM uses 3 GB RAM and one vCPU because two independent two-vCPU boot tests reproduced an EFI `DXE_AP` stall under the host's Windows-hypervisor-backed VirtualBox path. A clean powered-off `ad-ds-baseline-2026-11-02` snapshot protects this milestone.

The domain controller now runs the version-matched Wazuh `4.14.7` agent and Microsoft Sysmon `15.22`. Application, Security, System, PowerShell Operational and Sysmon Operational channels are configured for Wazuh collection. Local service state, event generation and bidirectional encrypted TCP `1514` transport were verified. A dashboard search for the unique controlled-scenario account returned 18 live alerts. A focused Event ID `4740` query returned one live alert decoded by `windows_eventchannel` and matched by built-in Wazuh rule `60115` at level `9`. Exact one-hit queries also mapped Event IDs `4720`, `4728`, `4767` and `4725` to built-in rules `60109`, `60141`, `60133` and `60111`. See [`WAZ-001`](evidence/WAZ-001-domain-controller-agent.md), [`SYS-001`](evidence/SYS-001-sysmon-telemetry.md), [`WAZ-002`](evidence/WAZ-002-controlled-lockout-indexing.md) and [`WAZ-003`](evidence/WAZ-003-account-lifecycle-indexing.md).

## Roadmap

1. [x] Verify destination resources and virtualization support.
2. [x] Preserve, clone and validate the migrated Wazuh VM.
3. [x] Create the VirtualBox `AD-LAB` internal network attachment on Wazuh.
4. [x] Prepare the powered-off domain-controller VM hardware and isolated adapters.
5. [x] Acquire and verify supported Windows evaluation media from Microsoft.
6. [x] Finish updates, isolate temporary NAT and promote the verified `bluevale.test` domain-controller baseline.
7. [ ] Add a separate Windows domain client if the resource test passes.
8. [x] Configure auditing, Wazuh and selected Sysmon telemetry.
9. [ ] Baseline normal domain activity and execute additional harmless marked scenarios; the first marked identity scenario is complete.
10. [ ] Develop additional detections and investigations; lockout and companion lifecycle coverage are documented.
11. [ ] Complete secret, evidence, syntax and publication review.

## Repository structure

```text
docs/             Architecture, build notes, safety, evidence standards and troubleshooting
detections/       Detection objectives, logic and analyst guidance
rules/            Custom Wazuh rules and validation notes
investigations/   Scenario reports and analyst conclusions
evidence/         Sanitized evidence summaries and index
scripts/          Harmless reproduction and validation helpers
screenshots/      Reviewed screenshots only
```

## Relationship to previous work

This project will not repeat the existing Wazuh installation, endpoint enrollment, FIM, local failed-logon, PowerShell 4104, or baseline Sysmon work already documented in the first two projects. It will reuse that foundation and concentrate on Active Directory identity telemetry and incident-response analysis.

## Publication status

This repository remains private while the infrastructure and evidence are incomplete. A public release and version tag will be considered only after syntax checks, secret scanning, evidence review, link validation and claim verification.
