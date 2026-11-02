# ACQ-001 — Windows Server evaluation media

## Summary

On 1 November 2026, Windows Server 2025 Evaluation installation media was downloaded through Microsoft's official Evaluation Center redirect, verified locally, inspected for expected images, and attached to the dedicated `AD-DC01` lab VM.

## Provenance

- Product: Windows Server 2025 Evaluation
- Architecture and language: x64, English (United States)
- Microsoft redirect: `https://aka.ms/WinServ2025iso-enus`
- Media label: `SSS_X64FREE_EN-US_DV9`
- Exact size: 8,152,356,864 bytes
- SHA-256: `7B052573BA7894C9924E3E87BA732CCD354D18CB75A883EFA9B900EA125BFD51`
- Build detected by VirtualBox: `10.0.26100.32230`

The hash is a locally generated acquisition baseline. Microsoft did not provide an independently compared checksum in this workflow, so the evidence does not overstate it as publisher-signed hash verification.

## Image inspection

VirtualBox's unattended-media detector identified:

1. Windows Server 2025 Standard Evaluation
2. Windows Server 2025 Standard Evaluation (Desktop Experience)
3. Windows Server 2025 Datacenter Evaluation
4. Windows Server 2025 Datacenter Evaluation (Desktop Experience)

Image 2 was selected. Standard provides the roles required for this isolated AD DS detection lab, while Desktop Experience supports transparent, screenshot-friendly administration and validation.

## Installation boundary

- Target VM: `AD-DC01`
- Target disk: dedicated empty 64 GB dynamic VDI
- Primary adapter: VirtualBox internal network `AD-LAB`
- Secondary adapter: temporary outbound-only NAT for setup and updates
- Clipboard, drag-and-drop, audio and recording: disabled

Installation was started only after the ISO byte count, SHA-256 and image list were verified. The media remains local and no Active Directory service is exposed to the host LAN.

## Verified installation result

- Installed edition: Windows Server 2025 Standard Evaluation (Desktop Experience)
- OS build family: `26100`
- Hostname after first reboot: `AD-DC01`
- AD DS feature state: `Installed`
- Isolated adapter: `AD-LAB`, static RFC1918 address, no default gateway
- Temporary update adapter: `TEMP-NAT`

The VM requires one vCPU on this host. A second post-install two-vCPU test reproduced the same VirtualBox EFI `DXE_AP` stall observed during installation; reverting to one vCPU restored a successful Windows boot.
