# IR-001 — Controlled account lockout

## Executive summary

A bounded password-guessing simulation was executed against one fictional lab account on 2 November 2026. Exactly five invalid network-logon attempts triggered the configured domain lockout threshold. The account was then unlocked, verified, and disabled. Local Windows evidence, post-event Wazuh transport and scenario-specific live dashboard alerting were confirmed. The exact Event ID `4740` record matched built-in Wazuh rule `60115` at level `9`.

## Scenario identity

- Marker: `BLV-AUTH-20261102-164444`
- Test account: `blvlock-11021644`
- Domain: fictional `bluevale.test` lab only
- Attempt limit: five invalid passwords
- Final state: disabled
- Script exit code: `0`

The account password was generated at runtime, never printed or written to the repository, and cleared from script variables after account creation.

## Timeline

The guest originally recorded:

| Guest timestamp | Activity |
|---|---|
| `2026-11-02T16:44:44.7335181+02:00` | Scenario and account creation began |
| `2026-11-02T16:44:46.0875226+02:00` | Lockout observed after five bounded failures |
| Immediately afterward | Account unlocked, unlock state verified, then account disabled |

### Clock-quality caveat

The domain controller had resumed from saved state without VirtualBox Guest Additions and its clock was approximately 5 hours 32 minutes behind the host. The timestamp offset was discovered immediately after the scenario. A controlled outbound-only Windows Time synchronization corrected the guest from `16:48` to `22:20` local time using `time.windows.com`; the temporary NAT adapter and its VirtualBox cable were then disabled again.

The original guest timestamps are retained here rather than rewritten. Future scenario timestamps use the corrected clock.

## Local Windows evidence

The scenario reported these events for the test identity:

| Event ID | Count | Meaning in this scenario |
|---:|---:|---|
| 4625 | 5 | Failed logon attempts |
| 4720 | 1 | Test user created |
| 4728 | 1 | Test user added to the unprivileged employees group |
| 4740 | 1 | Test account locked out |
| 4767 | 1 | Test account unlocked |
| 4725 | 1 | Test account disabled during cleanup |

The script also counted 19 Sysmon events generated during the scenario window.

![Controlled lockout scenario result](../screenshots/controlled-lockout-scenario.png)

## Wazuh transport evidence

A 30-second capture on the isolated domain-controller adapter after the scenario recorded:

- 1,007 total packets
- 947 packets in the bidirectional Wazuh TCP `1514` flow
- 341,186 bytes of TCP payload on that flow
- Local raw capture size: 416,194 bytes
- Local capture SHA-256: `E9E051397E0CDE55C744C853DF692CF617E99ED5B99CBC8D65FE19436657C1C1`

The packet capture and exact RFC1918 addresses remain outside Git.

## Live Wazuh indexing evidence

An authenticated Wazuh Discover search for the unique test identity returned `18` alerts in the live `wazuh-alerts-*` data view. An expanded cleanup result showed:

| Field | Sanitized observed value |
|---|---|
| Agent | `AD-DC01` |
| Windows channel | `Security` |
| Computer | fictional `AD-DC01.bluevale.test` host |
| Target domain | `BLUEVALE` |
| Target account | `blvlock-11021644` |
| Expanded Windows Event ID | `4725` — cleanup disable action |

This established scenario-specific endpoint-to-indexer ingestion rather than transport alone. A second exact query combined the same target account with Event ID `4740` and returned one live alert:

| Alert field | Reviewed value |
|---|---|
| Dashboard alert time | `2026-11-02 22:16:28.781` local display time |
| Windows event time | `2026-11-02T14:44:54.9769155Z` |
| Event ID | `4740` |
| Decoder | `windows_eventchannel` |
| Wazuh rule | `60115` |
| Level | `9` |
| Description | `User account locked out (multiple login errors)` |
| Groups | `windows`, `windows_security`, `authentication_failures` |
| MITRE IDs | `T1110`, `T1531` |
| MITRE tactics | Credential Access, Impact |
| Caller computer | `AD-DC01` |

The alert's later dashboard time is consistent with the documented saved-state clock skew and delayed post-synchronization indexing; the original Windows event time remains the authoritative activity timestamp. The internal agent address, machine SID, event-record identifier and unrestricted payload were deliberately excluded from repository evidence. See [`WAZ-002`](../evidence/WAZ-002-controlled-lockout-indexing.md).

Focused one-hit queries also verified the companion account-management alerts:

| Event ID | Action | Wazuh rule | Level | MITRE IDs |
|---:|---|---:|---:|---|
| `4720` | Account created | `60109` | `8` | `T1098` |
| `4728` | Added to unprivileged `GG-Employees` | `60141` | `5` | `T1484` |
| `4767` | Account unlocked | `60133` | `5` | `T1098` |
| `4725` | Account disabled | `60111` | `8` | `T1098`, `T1531` |

The `4728` correlation required `data.win.eventdata.memberName` because `targetUserName` identifies the affected group, not the added principal. Exact descriptions, rule groups, tactics and timestamps are recorded in [`WAZ-003`](../evidence/WAZ-003-account-lifecycle-indexing.md).

## Detection interpretation

Five failed logons for one account followed by Event ID `4740` is consistent with a bounded password-guessing pattern. MITRE ATT&CK maps systematic password attempts against an account to [T1110.001 Password Guessing](https://attack.mitre.org/techniques/T1110/001/).

This activity was authorized and generated by the lab script. It does not indicate a real compromise.

## Analyst assessment

- The domain lockout control operated at the configured threshold.
- Security auditing captured the authentication and account-lifecycle sequence.
- Sysmon continued generating endpoint telemetry during the scenario.
- Wazuh transport carried a substantial encrypted payload burst after event generation.
- Wazuh Discover correlated 18 live alerts to the unique scenario account, and an expanded cleanup event contained the expected sanitized Windows fields.
- The exact `4740` record generated a live level-9 alert under built-in rule `60115` with authentication-failure and ATT&CK metadata.
- The account creation, unprivileged group addition, unlock and disable records each generated a scenario-specific live built-in Wazuh alert.
- The account was left disabled, limiting any residual access risk.

## Limitation and next step

The bounded scenario is verified end to end. The built-in lockout rule provides a strong high-confidence signal, so no redundant custom Event ID `4740` rule was deployed. A future enhancement may correlate the preceding five `4625` failures when source attribution and sequence context add operational value beyond rule `60115`.

