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

## 1 November 2026 — Windows Server media and installation start

- Downloaded the English x64 Windows Server 2025 Evaluation ISO through Microsoft's official Evaluation Center redirect.
- Verified the exact size as 8,152,356,864 bytes and recorded SHA-256 `7B052573BA7894C9924E3E87BA732CCD354D18CB75A883EFA9B900EA125BFD51`.
- Confirmed build `10.0.26100.32230` and all four expected Standard/Datacenter, Core/Desktop Experience image choices.
- Selected Windows Server 2025 Standard Evaluation (Desktop Experience).
- Saved the running Wazuh VM state before installation because its guest did not honor the ACPI shutdown request; no hard power-off was used.
- Diagnosed a VirtualBox EFI stall at `DXE_AP` under the Windows hypervisor backend.
- Removed the optional virtual TPM, then reduced the installer VM to one vCPU after the stall persisted. The next boot reached the Windows DVD successfully.
- Started installation to the dedicated empty 64 GB virtual disk.
- Completed the file-copy, device-configuration and reboot stages successfully.
- Reached the built-in Administrator password handoff and stopped without entering or storing a password.
- Ejected the installer ISO after confirming the VM booted from its virtual disk.

Administrator-password completion, first sign-in and post-install configuration are not claimed in this entry. The temporary NAT adapter will be disabled before domain promotion and identity testing.
