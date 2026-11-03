# Lab Cleanup and Shutdown

## Routine shutdown

1. Confirm no scenario or Wazuh indexing task is still running.
2. Verify test accounts created for scenarios are disabled or removed according to the investigation record.
3. Shut down `AD-DC01` normally from Windows and wait until VirtualBox reports `powered off`.
4. Shut down `Wazuh-Primary` normally and wait for manager, indexer and dashboard writes to complete.
5. Never hard-power-off either VM while disk activity is present.
6. Keep the original transferred Wazuh VM non-running; never start it alongside the permanent clone.

Starting Wazuh before the domain controller and stopping the domain controller before Wazuh preserves the telemetry path during guest activity.

## Snapshot procedure

- Take snapshots only after normal guest shutdown when possible.
- Name snapshots with purpose and date, for example `v1.0-release-2026-11-03`.
- Do not treat a snapshot as an independent backup.
- Retain the original transferred disk and the permanent VM storage in separate locations until recovery is tested.
- Avoid long-term saved-state use for the domain controller; it caused clock drift in this lab.

## Scenario cleanup

- Confirm the fictional test account cannot authenticate.
- Remove a disabled test identity only after its evidence has been reviewed.
- Remove temporary ISO attachments and keep temporary NAT links disconnected.
- Do not delete raw private evidence solely to make the public repository look cleaner; retain it securely outside Git according to personal retention needs.

## Recovery check

After an unexpected stop, verify filesystem/service health, Windows time, DNS, KDC, NetLogon, NTDS, `WazuhSvc` and `Sysmon64` before generating new evidence. Record any recovery action in the build or troubleshooting log.

