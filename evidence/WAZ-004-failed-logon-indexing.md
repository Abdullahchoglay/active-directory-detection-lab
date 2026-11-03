# WAZ-004 — Controlled failed-logon sequence live indexing

## Summary

On 3 November 2026, an exact Wazuh Discover query verified all five Windows Security Event ID `4625` records from the bounded `IR-001` scenario. The five live alerts immediately preceded the separately verified account-lockout alert.

## Query and result

```text
data.win.eventdata.targetUserName:"blvlock-11021644" AND data.win.system.eventID:"4625"
```

- Result count: `5`
- Agent: `AD-DC01`
- Channel: Windows `Security`
- Decoder: `windows_eventchannel`
- Wazuh rule: `60122`
- Level: `5`
- Description: `Logon Failure - Unknown user or bad password`
- Groups: `windows`, `windows_security`, `authentication_failed`
- Built-in MITRE mapping: `T1531` / Impact / Account Access Removal

## Alert sequence

The dashboard displayed the five alerts at:

1. `2026-11-02 22:16:23.843`
2. `2026-11-02 22:16:24.982`
3. `2026-11-02 22:16:26.081`
4. `2026-11-02 22:16:27.411`
5. `2026-11-02 22:16:28.877`

The exact lockout alert followed at `22:16:28.781` in the dashboard display. Dashboard ordering at sub-second precision should not be treated as the authoritative activity sequence because the scenario has a documented guest-clock and delayed-indexing caveat. The original Windows timestamps and local scenario logic establish that the five bounded failures caused the lockout.

## Expanded failure fields

One expanded alert verified:

| Field | Sanitized observed value |
|---|---|
| Windows `systemTime` | `2026-11-02T14:44:55.0125874Z` |
| `authenticationPackageName` | `Negotiate` |
| `logonProcessName` | `Advapi` |
| `logonType` | `3` — network logon |
| `processName` | Windows PowerShell executable |
| `status` | `0xc000006d` — logon failure |
| `subStatus` | `0xc000006a` — incorrect password |
| `failureReason` | Windows message token `%%2313` |
| `rule.firedtimes` | `5` |

The exact private agent address, process identifier, machine identifiers and unrestricted message were excluded.

## Interpretation

The built-in rule classifies each failure independently. The controlled sequence is analytically consistent with [T1110.001 Password Guessing](https://attack.mitre.org/techniques/T1110/001/), but Wazuh rule `60122` itself supplied `T1531`. The detection document keeps those two facts separate instead of replacing observed metadata with an analyst-selected mapping.

## Conclusion

The complete pre-lockout failure sequence is verified in the live Wazuh alert index. A custom rule was not added because the built-in failure and lockout alerts are reliable; future correlation can add sequence count and source context without duplicating the underlying rules.

