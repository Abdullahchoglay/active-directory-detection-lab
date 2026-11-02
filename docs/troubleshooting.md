# Troubleshooting Record

## Dashboard returned 503 after boot

Immediately after the migrated clone booted, the dashboard listener returned:

```text
503 Service Unavailable
Wazuh dashboard server is not ready yet
```

The VM remained running and its guest network was responsive. The API became available first and returned the expected unauthenticated `401`. After approximately three minutes, the dashboard returned a `302` redirect to its login page. The condition was recorded as service initialization rather than a failed migration.

## Host memory pressure

With the transferred VM configured for 8 GB RAM, host free memory dropped below 1 GB and VirtualBox logged short guest heartbeat stalls. The permanent clone was first reduced to 6 GB and later to 4.5 GB after package and service checks. Wazuh and the 3 GB domain controller then ran simultaneously with a narrow but stable host-memory margin. Nonessential VM features remain disabled, and unrelated workloads should be closed before adding a client VM.

## VirtualBox console rejected synthetic keyboard input

Mouse and keyboard capture became unreliable after the domain controller entered normal operation. The console also briefly rendered black after a VirtualBox preferences dialog; a save-state and resume restored it without rebooting Windows. No untrusted pasted text was executed.

Signed deployment packages and configuration launchers were placed on read-only ISO images. The user explicitly launched them inside the guest and approved UAC. Service readiness was then verified from installer output and isolated-link packet captures instead of depending on console automation.

## Wazuh agent installed but initially produced no transport

The first launcher installed the MSI successfully but did not explicitly start `WazuhSvc`. A 30-second isolated-link capture contained no TCP agent flow. The launcher was corrected to elevate first, start the service and query its state. The installer returned `0`, the service reached `STATE: 4 RUNNING`, and a repeat capture showed bidirectional TCP `1514` traffic.

## Domain-controller clock drift after saved-state resume

The first controlled lockout scenario exposed a guest clock approximately 5 hours 32 minutes behind the host even though both systems used `Israel Standard Time`. The VM does not have VirtualBox Guest Additions, and its saved-state clock had not advanced correctly.

The original scenario timestamps were retained with an explicit evidence caveat. The disabled temporary NAT adapter and VirtualBox cable were enabled only long enough for an outbound Windows Time synchronization. `w32tm` completed successfully with leap indicator `0` and stratum `5`. The guest adapter disabled itself in a `finally` block, and the VirtualBox cable was turned off immediately afterward. Future scenarios use the corrected clock.

## Cryptographic transfer limitation

The receiving laptop did not contain the sender's original checksum manifest. A SHA-256 hash was therefore recorded after a normal shutdown as a post-transfer baseline. The successful boot and service checks provide operational validation, but the repository does not claim an independent source-to-destination checksum comparison.

## Domain-controller diagnostics reported event-log warnings

The first broad `dcdiag /q` run reported the `SystemLog` and `DFSREvent` tests. The System log entries were Windows Secure Boot certificate-update failures expected on this EFI VM because Secure Boot is disabled. The DFS Replication entries were generated while the host was not yet a domain controller and during initial promotion. Later DFSR event `4602` confirmed SYSVOL initialization completed.

The functional directory checks were rerun explicitly:

```powershell
dcdiag /q /test:Advertising /test:Services /test:SysVolCheck /test:NetLogons /test:Replications
```

They returned no output, which is the quiet success condition. The event-log warnings are retained as evidence and were not cleared to force a cosmetically clean result.
