# Configuration and Integration Reference

This page maps the completed v1.0 configuration to its evidence without duplicating secrets or the earlier portfolio projects.

## Active Directory

- Forest and DNS name: fictional `bluevale.test`
- NetBIOS name: `BLUEVALE`
- Domain controller: `AD-DC01`, Windows Server 2025 Standard Evaluation
- Functional level: Windows Server 2025
- Protected lab OUs: users, groups, workstations, servers and service accounts
- Fictional global groups: employees, help desk, lab administrators, server operators and SOC analysts
- Account lockout: five attempts, 15-minute duration and 15-minute observation window

Exact validation is in [`AD-001`](../evidence/AD-001-domain-controller-baseline.md) and [`AUD-001`](../evidence/AUD-001-windows-audit-baseline.md).

## Network isolation

`AD-LAB` is a VirtualBox internal network. `AD-DC01` has no connected NAT or bridged path during identity testing. Wazuh has the internal adapter plus constrained NAT and host management forwards bound only to loopback. No AD service is forwarded to the host or public network. Exact addresses and adapter identifiers remain private.

See [architecture](architecture.md) and [scope and safety](scope-and-safety.md).

## Wazuh integration

The domain controller uses the version-matched Wazuh `4.14.7` Windows agent. It collects Application, Security, System, PowerShell Operational and Sysmon Operational channels. Bidirectional encrypted TCP `1514` transport and scenario-specific live alerts were verified.

See [`WAZ-001`](../evidence/WAZ-001-domain-controller-agent.md), [`WAZ-002`](../evidence/WAZ-002-controlled-lockout-indexing.md), [`WAZ-003`](../evidence/WAZ-003-account-lifecycle-indexing.md) and [`WAZ-004`](../evidence/WAZ-004-failed-logon-indexing.md).

## Sysmon configuration and attribution

The deployed configuration is byte-for-byte identical to `config/sysmonconfig-15.21.xml` in the earlier [Sysmon Threat Detection Lab](https://github.com/Abdullahchoglay/sysmon-detection-lab). Its SHA-256 is `9EB6306AD0FEA3955E7E2148BDC7F6E0922FCA4C2A3396067C3E16A7F6CFCB44`.

That file is the balanced profile from Olaf Hartong's Sysmon Modular release `configs-a45dedb13a43`, attributed to Olaf Hartong and contributors and inspired by SwiftOnSecurity's original configuration. The upstream project did not expose a root license file at the pinned revision, so the exact upstream release and attribution are retained and no authorship is claimed. The XML is linked rather than duplicated here.

Package, hash, schema and service validation are in [`SYS-001`](../evidence/SYS-001-sysmon-telemetry.md).

