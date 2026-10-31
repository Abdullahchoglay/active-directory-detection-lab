# Destination Environment Assessment

Assessment date: 1 November 2026

## Host capacity

| Item | Observed state |
|---|---|
| Operating system | Windows 11 Home, 64-bit |
| Processor | 4 physical cores / 8 logical processors |
| Memory | Approximately 16 GB |
| Free storage at assessment | Approximately 247 GB |
| Virtualization | Available; VirtualBox operates through the Windows hypervisor backend |
| VirtualBox | 7.2.22 |

The Windows hypervisor remains enabled. It is not disabled for performance because preserving host security is a project requirement.

## Resource decision

The host can run the Wazuh VM and a small domain controller, but simultaneous Wazuh, domain-controller and Windows-client operation requires conservative allocation and closing unrelated memory-heavy applications.

Planned working envelope:

- Wazuh: 6 GB RAM, 2 vCPU
- Domain controller: approximately 2.5–3 GB RAM, 2 vCPU
- Client: 4 GB RAM, 2 vCPU, created only after an all-VM resource test
- Dynamic disks with a host free-space floor of at least 80 GB

The separate Windows client is a gated objective, not a completed component.

## Installation-media result

No Windows Server ISO or reusable Windows Server VM was found in the assessed storage locations. Windows evaluation media must be acquired from Microsoft before the domain-controller phase.
