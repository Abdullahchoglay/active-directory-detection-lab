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

The host safely runs the Wazuh VM and a small domain controller. A final check with both active left approximately 1.4 GB free, so a third 4 GB Windows client would overcommit the host and is excluded from v1.0.

Verified working envelope:

- Wazuh: 4.5 GB RAM, 2 vCPU
- Domain controller: 3 GB RAM, 1 vCPU
- Client: not created; resource-gated by the measured memory margin
- Dynamic disks with a host free-space floor of at least 80 GB

The completed v1.0 architecture is intentionally two VMs. The optional client can be revisited after a memory upgrade or by running components non-concurrently.

## Installation-media result

No reusable Windows Server VM or ISO was present during the initial assessment. On 1 November 2026, Windows Server 2025 evaluation media was acquired from Microsoft's official Evaluation Center redirect and verified before use.

| Item | Verified value |
|---|---|
| Media | Windows Server 2025 Evaluation, English (United States), x64 |
| Size | 8,152,356,864 bytes |
| SHA-256 | `7B052573BA7894C9924E3E87BA732CCD354D18CB75A883EFA9B900EA125BFD51` |
| Build reported by VirtualBox | `10.0.26100.32230` |
| Selected image | Windows Server 2025 Standard Evaluation (Desktop Experience) |

The ISO exposed Standard and Datacenter evaluation images, each with Server Core and Desktop Experience variants. Standard Evaluation with Desktop Experience was selected because the lab does not require Datacenter-only features and the GUI simplifies repeatable portfolio validation.
