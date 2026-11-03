# Safe Reproduction Guide

## Purpose

This guide reproduces the bounded identity scenario without real accounts, unrestricted password spraying or destructive actions. Run it only inside the isolated `bluevale.test` lab.

## Preconditions

1. Start `Wazuh-Primary`, wait for the dashboard to become healthy, then start `AD-DC01`.
2. Confirm the domain controller has only its `AD-LAB` adapter connected; temporary NAT must remain disabled.
3. Confirm `WazuhSvc`, `Sysmon64`, DNS, KDC, NetLogon and NTDS are running.
4. Confirm the domain lockout threshold is exactly five attempts in 15 minutes.
5. Confirm `GG-Employees` is unprivileged.
6. Take or verify a recoverable powered-off baseline before changing the lab.

## Run the controlled scenario

Open an elevated Windows PowerShell session on `AD-DC01`, copy the reviewed helper into the guest through approved removable media, inspect it, and run:

```powershell
.\Invoke-ControlledLockoutLab.ps1 -Execute
```

The script still presents PowerShell's high-impact confirmation unless the operator explicitly supplies `-Confirm:$false`. It refuses to run outside the expected fictional domain and domain controller. The runtime account password is generated in memory, never printed, and cleared. The account is left disabled even when cleanup follows an error.

Expected local counts are five `4625` failures and one each of `4720`, `4728`, `4740`, `4767` and `4725` for the unique account. Treat any mismatch as a failed run; do not edit evidence to fit expectations.

## Verify Wazuh

Use the generated account name in Discover:

```text
data.win.eventdata.targetUserName:"<test-account>" AND data.win.system.eventID:"4625"
```

```text
data.win.eventdata.targetUserName:"<test-account>" AND data.win.system.eventID:"4740"
```

```text
data.win.eventdata.targetUserName:"<test-account>" AND data.win.system.eventID:("4720" OR "4767" OR "4725")
```

For the group addition, the added principal is in `memberName`:

```text
data.win.system.eventID:"4728" AND data.win.eventdata.memberName:*<test-account>*
```

Record exact timestamps, event counts, decoder, rule ID, level, groups and ATT&CK fields. Preserve Windows timestamps as authoritative when indexing is delayed.

## Cleanup

1. Verify the test account is disabled.
2. Export only sanitized evidence needed for the investigation.
3. After evidence review, remove the disabled test identity if it is no longer required; record the cleanup separately rather than altering the original scenario result.
4. Follow the [shutdown procedure](cleanup-and-shutdown.md).

Do not run this helper against another domain, change the fixed attempt cap, target multiple users or reuse real credentials.

