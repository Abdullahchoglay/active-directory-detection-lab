# AD-001 — Domain-controller baseline validation

## Evidence classification

- **Source:** local Windows Server administrative validation
- **Date:** 2 November 2026
- **Timezone:** Israel Standard Time
- **Live Wazuh evidence:** not tested in this evidence item
- **Detection claim:** none

## Scope

This evidence establishes the recoverable Active Directory baseline before Wazuh enrollment, Sysmon installation, audit-policy changes, test identities or detection scenarios.

## Verified results

| Check | Sanitized result |
|---|---|
| Host | `AD-DC01` |
| Operating system | Windows Server 2025 Standard Evaluation, Desktop Experience |
| Build | `26100.33650` |
| Forest / domain | `bluevale.test` |
| NetBIOS name | `BLUEVALE` |
| Functional levels | Windows Server 2025 forest and domain |
| Core services | DNS, KDC, NetLogon and NTDS running; automatic startup |
| DNS | Domain A record resolved to the DC's static isolated-lab address |
| Functional DC diagnostics | Advertising, Services, SYSVOL, NetLogons and Replications passed quietly |
| Isolation | Temporary NAT disabled in the guest and at the VirtualBox link layer |
| Recovery | Clean powered-off snapshot `ad-ds-baseline-2026-11-02` |

## Directory structure

The protected `Bluevale Lab` hierarchy contains OUs for lab users, groups, workstations, servers and service accounts. Five fictional global security groups were created without privileged memberships:

- `GG-Employees`
- `GG-Helpdesk`
- `GG-Lab-Admins`
- `GG-Server-Operators`
- `GG-SOC-Analysts`

No fictional password-backed users were created in this baseline.

## Diagnostic limitation

A broad quiet diagnostic also reported event-log-based warnings. Secure Boot certificate-update entries are expected because this virtual machine does not use Secure Boot. DFS Replication events occurred before promotion and during initial SYSVOL setup; later DFSR event `4602` recorded successful SYSVOL initialization. The relevant logs were preserved, not cleared. Functional directory tests were then run explicitly and passed with no quiet-mode output.

## Conclusion

The domain controller is suitable as the recovery baseline for the next telemetry phase. This evidence does not establish Wazuh enrollment, event ingestion, alerting, or detection effectiveness.
