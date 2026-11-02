# WAZ-001 — Domain-controller Wazuh agent validation

## Summary

On 2 November 2026, the domain controller was enrolled with a version-matched Wazuh `4.14.7` Windows agent over the isolated VirtualBox network. The package was obtained from Wazuh's official package repository, validated before installation, and installed without exposing Active Directory services outside the lab.

## Package validation

| Item | Verified value |
|---|---|
| Package | `wazuh-agent-4.14.7-1.msi` |
| Size | 5,935,104 bytes |
| SHA-256 | `E967F36B75589D6210244FD58239C7021FA53A77C38D92315C3B3BD115002EDE` |
| Authenticode | Valid |
| Signer | Wazuh, Inc. |
| Manager version | `4.14.7` |

Matching the agent to the manager avoids relying on forward-version compatibility during the initial evidence baseline.

## Local service evidence

The installer returned exit code `0`. The Windows service query then reported `WazuhSvc` in `STATE: 4 RUNNING` with a zero Win32 exit code. No enrollment password, API credential or dashboard credential was recorded in project artifacts.

## Transport evidence

A 30-second local packet capture was taken only on the domain controller's isolated VirtualBox adapter after the service started. It recorded bidirectional TCP traffic between the domain controller and Wazuh's agent listener on port `1514`.

- Local raw capture retained outside Git: `15,386` bytes
- Local capture SHA-256: `1097114BEABA8A0699F51D5F212929B1395191AA9552D6D1A2AD5F569E91CEC6`
- Directional flows: domain controller to manager and manager to domain controller
- Exact RFC1918 addresses and the packet capture are intentionally excluded from the repository

## Evidence classification and limitation

- Package origin, hash and signature: locally verified
- Windows service state: locally verified
- Encrypted agent transport: locally verified on the isolated link
- Dashboard agent record and indexed alert review: not claimed in this item

The service and transport evidence establish successful endpoint-to-manager communication. They do not by themselves prove that a specific Windows event was indexed or alerted in the dashboard.

