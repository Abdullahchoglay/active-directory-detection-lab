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

At this checkpoint, guest filesystem expansion and package-level consistency checks remained pending authenticated guest access. Package consistency was later verified; filesystem expansion was intentionally deferred because the root filesystem remained healthy with sufficient free space.

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

## 1–2 November 2026 — Domain-controller base configuration

- Completed the built-in Administrator credential step and first sign-in without recording a password in project artifacts.
- Verified Windows Server 2025 Standard Evaluation, OS build family `26100`.
- Renamed the Windows host to `AD-DC01`.
- Mapped the VirtualBox internal adapter by MAC address, renamed it `AD-LAB`, and assigned a static RFC1918 address without a default gateway.
- Renamed the temporary outbound adapter `TEMP-NAT`.
- Installed the Active Directory Domain Services role and management tools; `Get-WindowsFeature` reported `Installed`.
- Re-tested two vCPUs after installation. EFI again stalled at `DXE_AP` before Windows loaded, so the VM was returned to one vCPU and boot-verified.
- Searched for recommended quality updates and found the October 2026 cumulative and .NET security updates, Defender platform/intelligence updates, and MSRT. Installation was started before forest promotion.

## 2 November 2026 — Verified domain-controller baseline

- Installed the October 2026 Windows Server cumulative and .NET security updates, Defender platform/intelligence updates, and MSRT.
- Verified OS build `26100.33650` after the required update restarts.
- Corrected the guest timezone to `Israel Standard Time`.
- Pointed the isolated adapter to the local DNS service and disabled `TEMP-NAT` in Windows and at the VirtualBox link layer.
- Promoted `AD-DC01` as the first domain controller and DNS server for fictional forest `bluevale.test`, NetBIOS name `BLUEVALE`.
- Verified Windows Server 2025 domain and forest functional levels.
- Confirmed `DNS`, `KDC`, `Netlogon` and `NTDS` were running with automatic startup.
- Confirmed the domain A record resolved to the server's static lab address.
- Passed quiet functional checks for Advertising, Services, SYSVOL, NetLogons and Replications.
- Reviewed the broad `dcdiag /q` exceptions: Secure Boot update events are expected because Secure Boot is disabled, and the DFS Replication test referenced startup events from before SYSVOL initialization. Later DFSR event `4602` confirmed initial SYSVOL replication completed.
- Created protected `Bluevale Lab` OUs for users, groups, workstations, servers and service accounts.
- Created five fictional global security groups without assigning privileges or memberships.
- Performed a clean shutdown and created powered-off snapshot `ad-ds-baseline-2026-11-02`.

At this checkpoint, test identities and detection scenarios remained pending. They were completed in the later controlled scenario documented below.

## 2 November 2026 — Audit and telemetry baseline

- Applied a five-attempt account-lockout threshold with 15-minute duration and observation window to the fictional lab domain.
- Enabled Success and Failure auditing for the selected account-logon, logon/logoff, account-management, directory-service, policy-change, process-creation, object-access and system-integrity subcategories.
- Enabled process command-line auditing, PowerShell Script Block Logging and PowerShell Module Logging.
- Increased the Security log to 256 MB and PowerShell Operational log to 64 MB.
- Verified Wazuh manager, indexer, dashboard and Filebeat packages at `4.14.7-1`; all related services were active.
- Reduced the Wazuh VM to 4.5 GB RAM and revalidated simultaneous operation with the 3 GB domain controller.
- Configured Wazuh's isolated adapter with a static RFC1918 address and no default route.
- Verified the Wazuh root filesystem at 41 GB with approximately 15 GB free; guest expansion was deferred.
- Acquired the version-matched Wazuh Windows agent from the official package repository and verified its valid Wazuh, Inc. signature.
- Installed and enrolled `AD-DC01`; the installer returned `0`, `WazuhSvc` reached `STATE: 4 RUNNING`, and bidirectional TCP `1514` traffic was captured on the isolated link.
- Acquired Microsoft Sysmon `15.22` from the official Sysinternals endpoint and verified its Microsoft signature.
- Installed the well-formed schema `4.91` configuration; `Sysmon64` reached `STATE: 4 RUNNING` and its Operational log was enabled at 64 MB.
- Verified Application, Security, System, PowerShell Operational and Sysmon Operational event-channel collection in the Wazuh agent configuration.
- Generated benign process, DNS and Application-log activity, including marker `BluevaleLab / Event ID 100`.
- Counted 201 recent Sysmon and 157 recent PowerShell events locally.
- Captured 121,630 bytes of TCP payload on the bidirectional Wazuh `1514` flow during a 30-second post-validation window.

Dashboard-indexed event correlation is intentionally deferred to the first marked investigation scenario.

## 2 November 2026 — Controlled account-lockout scenario

- Created one fictional test identity with a runtime-generated password that was never printed or persisted in project artifacts.
- Added the identity only to the unprivileged `GG-Employees` group.
- Performed exactly five invalid network-logon attempts, matching the configured lockout threshold.
- Verified the account locked, unlocked it, confirmed the unlocked state and disabled it during cleanup.
- Recorded Security Event IDs `4625`, `4720`, `4725`, `4728`, `4740` and `4767` for the test identity.
- Counted 19 Sysmon events during the local scenario window.
- Recorded scenario marker `BLV-AUTH-20261102-164444` and script exit code `0`.
- Captured 341,186 bytes of TCP payload in the bidirectional Wazuh `1514` flow during a 30-second post-event window.
- Discovered that saved-state resume had left the guest clock approximately 5 hours 32 minutes behind the host.
- Preserved the original guest timestamps, performed a controlled outbound-only Windows Time synchronization, and immediately disabled the guest NAT adapter and VirtualBox cable again.

The scenario was first documented as local Windows evidence plus verified Wazuh transport.

## 2 November 2026 — Live Wazuh scenario correlation

- Searched the live `wazuh-alerts-*` data view for the unique controlled-scenario account.
- Correlated `18` indexed alerts to that identity.
- Expanded a representative Security event and verified the fictional domain-controller host, target domain, target account and Windows Event ID `4725` cleanup action.
- Excluded the exact private agent address, SID, unrestricted event payload and unsanitized dashboard screenshot from Git.
- Recorded this as scenario-specific live indexing evidence, while leaving the exact Wazuh rule ID, level and groups for the local Event ID `4740` lockout record explicitly unverified.

## 3 November 2026 — Exact Wazuh lockout-rule validation

- Applied an exact Discover query for the unique scenario account and Event ID `4740`; it returned one live alert.
- Verified decoder `windows_eventchannel`, built-in rule `60115`, level `9` and description `User account locked out (multiple login errors)`.
- Verified groups `windows`, `windows_security` and `authentication_failures`.
- Verified MITRE IDs `T1110` and `T1531`, techniques Brute Force and Account Access Removal, and tactics Credential Access and Impact.
- Recorded the dashboard alert time and original Windows `systemTime`, retaining the documented clock-skew caveat.
- Declined to deploy a redundant custom lockout rule because built-in rule `60115` already provides an actionable high-confidence alert.

## 3 November 2026 — Account-lifecycle rule validation

- Queried the same controlled identity for account creation (`4720`), unlock (`4767`) and disable (`4725`); each exact query returned one live alert.
- Corrected the Event ID `4728` search to use `memberName` after confirming `targetUserName` represents the affected group.
- Verified built-in rules `60109`, `60141`, `60133` and `60111`, with levels `8`, `5`, `5` and `8` respectively.
- Recorded each alert's decoder, description, groups, MITRE IDs, tactics and dashboard timestamp.
- Confirmed the group change involved only the unprivileged `GG-Employees` lab group; no privileged-group validation is claimed.
- Excluded private addresses, SIDs, event-record identifiers and browser screenshots containing unrelated personal context.
- Declined to add duplicate event-ID rules; documented future value in lifecycle correlation and privileged-group prioritization instead.

## 3 November 2026 — Failed-logon sequence validation

- Queried the unique controlled account with Event ID `4625`; Wazuh returned all five expected live alerts.
- Verified decoder `windows_eventchannel`, built-in rule `60122`, level `5`, description `Logon Failure - Unknown user or bad password` and authentication-failure rule groups.
- Expanded one alert and verified network logon type `3`, `Negotiate`, `Advapi`, the general logon-failure status, incorrect-password substatus and the controlled Windows PowerShell process.
- Preserved the distinction between Wazuh's observed `T1531` metadata and the analyst's sequence-level `T1110.001` password-guessing interpretation.

## 3 November 2026 — Release history sanitation

- Created and verified a private, complete recovery bundle outside the repository before rewriting history.
- Replaced an exact isolated-lab address in earlier revisions with a non-sensitive description.
- Replaced a personal author email in the complete `main` history with the repository owner's GitHub noreply address.
- Confirmed that the final project tree was byte-for-byte unchanged by the rewrite.
- Rescanned every reachable revision for both removed values and found no remaining match.

## 3 November 2026 — Sanitized dashboard screenshots

- Captured full-screen Discover views for the five failed logons, the level-9 account lockout and the four account-lifecycle alerts.
- Restricted the captures to detection-relevant columns and excluded browser chrome, address values, SIDs and unrestricted payloads.
- Removed the lifecycle description column because the built-in Event ID `4728` description embedded the full member SID.
- Retried the endpoint overview after an API health-check error; it loaded with `Active (0)` and `Disconnected (2)`.
- Did not create or label an active-agent screenshot because the live page did not support that claim at capture time.
