# AD-LOCKOUT-001 — Repeated failures followed by account lockout

## Status

Telemetry prerequisites, local Windows evidence and Wazuh transport are verified. Dashboard decoding and built-in Wazuh rule coverage remain pending authenticated review.

## Objective

Identify repeated failed authentication against one domain identity and raise confidence when the sequence culminates in an account lockout.

## Data sources

- Windows Security Event ID `4625` — failed logon
- Windows Security Event ID `4740` — account locked out
- Optional Event ID `4767` — account unlocked during analyst or administrator response
- Wazuh Windows `eventchannel` collection

## Candidate correlation logic

1. Group failed logons by normalized target account and domain.
2. Count failures within the domain observation window.
3. Exclude machine accounts ending in `$` and explicitly documented service-account noise only after baseline review.
4. Raise severity when Event ID `4740` follows the failure sequence for the same account.
5. Attach the failure count, source workstation or address when present, logon type, caller computer and lockout timestamp.

The current lab threshold is five failures in 15 minutes. A production rule should read the actual domain policy rather than hard-code the lab value.

## Fields to review in Wazuh

- `win.system.eventID`
- `win.system.computer`
- `win.eventdata.targetUserName`
- `win.eventdata.targetDomainName`
- `win.eventdata.logonType`
- `win.eventdata.ipAddress`
- `win.eventdata.workstationName`
- `win.eventdata.callerComputerName`
- Wazuh rule ID, level, groups and MITRE fields

Field availability must be confirmed against the decoded dashboard event before a custom rule is written.

## Expected behavior

- Individual failures may be low or medium confidence depending on logon type and source.
- A threshold breach should raise severity.
- A matching `4740` should produce the highest-confidence signal in this sequence.
- A later `4767` is response context, not proof that the original activity was benign.

## False-positive considerations

- Stale credentials in scheduled tasks, services or mapped drives
- Users retrying an outdated password after a reset
- Mobile devices repeatedly authenticating with cached credentials
- Misconfigured applications or service accounts
- Administrative testing

## Triage questions

- Was the source expected for this account and logon type?
- Did failures target one identity or many identities?
- Was there a success before or after the failures?
- Was the account recently created, enabled, reset or added to a group?
- Did an administrator unlock the account, and was that action authorized?
- Are similar attempts visible on other domain controllers or endpoints?

## ATT&CK mapping

- [T1110.001 — Brute Force: Password Guessing](https://attack.mitre.org/techniques/T1110/001/)

## Evidence

- [`IR-001`](../investigations/IR-001-controlled-account-lockout.md)
- [`AUD-001`](../evidence/AUD-001-windows-audit-baseline.md)
- [`SYS-001`](../evidence/SYS-001-sysmon-telemetry.md)

