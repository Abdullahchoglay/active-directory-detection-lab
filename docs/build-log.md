# Build Log

## 1 November 2026 — Destination assessment

- Confirmed Windows 11 Home, approximately 16 GB RAM, 4 physical CPU cores / 8 logical processors, and sufficient host storage.
- Confirmed VirtualBox 7.2.22 and Windows-hypervisor-backed execution.
- Found the transferred Wazuh VM registered from the transfer staging directory.
- Confirmed no Windows Server ISO or reusable domain-controller VM was present.

## 1 November 2026 — Wazuh migration recovery

- Performed a normal shutdown of the transferred VM.
- Recorded the powered-off VDI SHA-256 baseline.
- Created and registered `Wazuh-Primary` in permanent lab storage.
- Expanded the clone's virtual disk from approximately 42 GB to 64 GB.
- Set the clone to 6 GB RAM and 2 vCPU.
- Disabled clipboard, drag-and-drop, audio and recording.
- Added a second adapter on the VirtualBox internal network `AD-LAB`.
- Verified agent, enrollment and SSH listeners through localhost-only forwarding.
- Verified the dashboard login redirect and Wazuh API authentication challenge.
- Verified dashboard-advertised Wazuh version `4.14.7`.
- Created powered-off snapshot `migration-verified-2026-11-01`.
- Retained the transferred VM powered off as the recovery copy.

Guest filesystem expansion and package-level consistency checks remain pending authenticated guest access.

## 1 November 2026 — Domain-controller hardware preparation

- Created `AD-DC01` as a Windows Server 2025 VirtualBox machine.
- Configured EFI firmware and TPM 2.0.
- Assigned 3 GB RAM, 2 vCPU and a 64 GB dynamic VDI.
- Attached adapter 1 to the isolated `AD-LAB` internal network.
- Attached adapter 2 to temporary outbound NAT for installation, activation and updates.
- Left the VM powered off with an empty virtual DVD drive.

No Windows operating system or Active Directory role is installed. The NAT adapter will be disabled before domain promotion and identity testing.
