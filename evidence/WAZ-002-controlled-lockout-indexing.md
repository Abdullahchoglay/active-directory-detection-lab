# WAZ-002 — Controlled lockout live indexing

## Summary

On 2–3 November 2026, authenticated Wazuh Discover review correlated the unique fictional account from `IR-001` to live alerts in the `wazuh-alerts-*` data view. A focused Event ID `4740` query then verified the exact live decoder, built-in rule, level and ATT&CK metadata.

## Query and result

- Filter field: `data.win.eventdata.targetUserName`
- Test-only value: `blvlock-11021644`
- Live result count: `18` alerts
- Source agent: `AD-DC01`
- Data source: Windows `Security` event channel

The test account name is unique to this bounded scenario and does not identify a real person or production identity.

## Representative expanded record

The expanded dashboard record exposed the following reviewed fields:

| Field | Sanitized observed value |
|---|---|
| `agent.name` | `AD-DC01` |
| `data.win.system.channel` | `Security` |
| `data.win.system.computer` | `AD-DC01.bluevale.test` |
| `data.win.system.eventID` | `4725` |
| `data.win.eventdata.targetDomainName` | `BLUEVALE` |
| `data.win.eventdata.targetUserName` | `blvlock-11021644` |

Event ID `4725` represents the deliberate cleanup step that disabled the test account after the locally verified lockout and unlock sequence.

## Exact lockout alert

The focused query combined the unique account with `data.win.system.eventID:"4740"` and returned exactly one live alert.

| Field | Sanitized observed value |
|---|---|
| Dashboard timestamp | `2026-11-02 22:16:28.781` local display time |
| Windows `systemTime` | `2026-11-02T14:44:54.9769155Z` |
| `agent.name` | `AD-DC01` |
| `data.win.system.channel` | `Security` |
| `data.win.system.eventID` | `4740` |
| `data.win.eventdata.targetUserName` | `blvlock-11021644` |
| Caller computer | `AD-DC01` |
| `decoder.name` | `windows_eventchannel` |
| `rule.id` | `60115` |
| `rule.level` | `9` |
| `rule.description` | `User account locked out (multiple login errors)` |
| `rule.groups` | `windows`, `windows_security`, `authentication_failures` |
| `rule.mitre.id` | `T1110`, `T1531` |
| `rule.mitre.technique` | Brute Force, Account Access Removal |
| `rule.mitre.tactic` | Credential Access, Impact |

The dashboard timestamp reflects later indexing after the documented saved-state clock correction. The Windows `systemTime` aligns with the original local scenario timeline and remains the authoritative event timestamp.

## Evidence classification

- Local Windows evidence: verified separately in [`IR-001`](../investigations/IR-001-controlled-account-lockout.md)
- Encrypted agent transport: verified separately in `IR-001`
- Live Wazuh ingestion and indexing for the unique scenario identity: verified
- Exact Wazuh decoder, rule ID, level, groups and MITRE fields for Event ID `4740`: verified

The 18-result filter proves that events tied to the unique scenario identity reached the live Wazuh alert index. The one-result Event ID `4740` filter establishes the built-in Wazuh path for the lockout itself.

## Sanitization decision

The initial live result table displayed the agent's exact private address, and the expanded payload included a machine SID and event-record identifier. A later column-only dashboard view removed those fields, but its browser chrome contained unrelated personal tabs and bookmarks. Those captures were not committed. This text-first record preserves the security-relevant result without publishing unnecessary identifiers or personal context.

## Analyst conclusion

The controlled account lifecycle is visible end to end from Windows auditing through a live level-9 Wazuh lockout alert. Built-in rule `60115` provides useful coverage without a redundant custom rule. Companion account-management rule mappings are recorded separately in [`WAZ-003`](WAZ-003-account-lifecycle-indexing.md). Future correlation work can focus on enriching the alert with the preceding failure sequence and source attribution.
