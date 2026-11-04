# Project Completion Report

Completion date: 4 November 2026

## Outcome

The private v1.0 project is complete and ready for publication. It demonstrates an isolated two-VM Active Directory detection lab, live Windows and Sysmon telemetry in Wazuh, a bounded fictional-account scenario, two detection objectives, an end-to-end investigation and six reviewed screenshots.

Publication itself is intentionally not included in this completion state. Repository visibility, public release creation and the prepared LinkedIn post remain untouched until the owner explicitly publishes them.

## Completed deliverables

- Resource-aware host and migration assessment
- Verified permanent Wazuh manager clone with the transferred source retained as non-running recovery media
- Isolated `bluevale.test` domain controller on the VirtualBox internal network `AD-LAB`
- Advanced Windows audit policy, PowerShell logging, Sysmon and Wazuh collection
- Safe five-attempt authentication-failure and account-lockout scenario using a fictional identity
- Live Wazuh mappings for Events `4625`, `4720`, `4728`, `4740`, `4767` and `4725`
- Detection documents for authentication lockout and account lifecycle activity
- Incident report with timeline, ATT&CK interpretation, triage guidance and cleanup result
- Sanitized evidence index, six reviewed screenshots and a bounded reproduction helper
- Architecture, configuration, safety, troubleshooting, limitations and cleanup documentation
- Current-tree and complete-history privacy review
- PowerShell syntax, Markdown link, screenshot, Git integrity and local/remote parity checks
- Prepared but unpublished LinkedIn draft

## Evidence summary

The verified scenario contains ten primary Windows events: five failed logons and one each for account creation, group membership, lockout, unlock and disable. Wazuh indexed all ten under built-in rules with observed levels from `5` to `9`. The exact account search returned 18 alerts when related records were included.

The repository deliberately excludes credentials, exact internal addresses, SIDs, raw EVTX, packet captures and unrestricted Wazuh JSON. No result was fabricated and no unverified endpoint, privileged-group, Kerberos, scheduled-task or service-creation scenario is claimed.

## Engineering decisions

- A third Windows client VM was excluded because measured host memory made three simultaneous guests unsafe.
- No custom Wazuh XML was deployed because the built-in rules already produced useful, actionable alerts.
- The account group test used only the unprivileged `GG-Employees` group.
- Windows Server evaluation software is used only in this non-production lab.

These constraints are fully documented in [known limitations](known-limitations.md) and do not weaken the verified project outcomes.

## Release state

- Private repository content: complete
- Local and private remote `main`: synchronized at the last release audit
- Version target: `v1.0.0`
- GitHub description and topics: prepared in the [publication checklist](publication-checklist.md)
- GitHub release: not published
- LinkedIn post: drafted, not published
- Final lab state: both VMs powered off; temporary ISO ejected; DC NAT cable disconnected

See [release validation](release-validation.md) for the technical gates and [publication checklist](publication-checklist.md) for the only remaining owner-authorized public actions.

## Deliverable map

| Portfolio requirement | Primary artifact |
|---|---|
| Professional project overview | [`README.md`](../README.md) |
| Architecture and isolation | [Architecture](architecture.md) |
| Host and VM assessment | [Environment assessment](environment-assessment.md) |
| Build and troubleshooting record | [Build log](build-log.md), [troubleshooting](troubleshooting.md) |
| AD, audit, Wazuh and Sysmon configuration | [Configuration reference](configuration-reference.md) |
| Detection engineering | [`AD-LOCKOUT-001`](../detections/AD-LOCKOUT-001.md), [`AD-ACCOUNT-LIFECYCLE-001`](../detections/AD-ACCOUNT-LIFECYCLE-001.md) |
| Incident investigation | [`IR-001`](../investigations/IR-001-controlled-account-lockout.md) |
| Sanitized evidence | [Evidence index](../evidence/README.md), [screenshot catalog](../screenshots/README.md) |
| Safe reproduction | [Reproduction guide](reproduction-guide.md), [bounded helper](../scripts/Invoke-ControlledLockoutLab.ps1) |
| Scope, safety and limitations | [Scope and safety](scope-and-safety.md), [known limitations](known-limitations.md) |
| Attribution and versions | [Configuration reference](configuration-reference.md) |
| Cleanup and recovery | [Cleanup and shutdown](cleanup-and-shutdown.md) |
| Private release verification | [Release validation](release-validation.md) |
| Prepared public metadata | [Publication checklist](publication-checklist.md) |
| Prepared social announcement | [LinkedIn draft](linkedin-post-draft.md) |
