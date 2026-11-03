# WAZ-003 — Controlled account-lifecycle live indexing

## Summary

On 3 November 2026, four focused Wazuh Discover searches verified live built-in alert coverage for the account-management events already recorded locally in `IR-001`. Each query returned exactly one alert from `AD-DC01` in the `wazuh-alerts-*` data view.

## Scenario correlation

- Marker: `BLV-AUTH-20261102-164444`
- Test-only account: `blvlock-11021644`
- Source agent: `AD-DC01`
- Windows channel: `Security`
- Decoder for every reviewed alert: `windows_eventchannel`
- Final account state: disabled

The account is fictional and unique to this authorized lab scenario.

## Queries

Account creation, unlock and disable used the target-identity pattern:

```text
data.win.eventdata.targetUserName:"blvlock-11021644" AND data.win.system.eventID:"<event-id>"
```

For Event ID `4728`, `targetUserName` is the affected group rather than the added principal. The account-specific search therefore used:

```text
data.win.system.eventID:"4728" AND data.win.eventdata.memberName:*blvlock-11021644*
```

This field distinction is operationally important when building group-change searches.

## Reviewed alerts

| Dashboard time | Event | Rule | Level | Description | Rule groups | MITRE metadata |
|---|---:|---:|---:|---|---|---|
| `2026-11-02 22:16:19.893` | `4720` | `60109` | `8` | User account enabled or created | `windows`, `windows_security`, `adduser`, `account_changed` | `T1098`; Persistence |
| `2026-11-02 22:16:20.735` | `4728` | `60141` | `5` | Security Enabled Global Group Member Added | `windows`, `windows_security`, `group_changed`, `win_group_changed` | `T1484`; Defense Evasion, Privilege Escalation |
| `2026-11-02 22:16:29.606` | `4767` | `60133` | `5` | User account unlocked | `windows`, `windows_security`, `account_changed` | `T1098`; Persistence |
| `2026-11-02 22:16:29.663` | `4725` | `60111` | `8` | User account disabled or deleted | `windows`, `windows_security`, `adduser`, `account_changed` | `T1098`, `T1531`; Persistence, Impact |

The built-in Event ID `4728` description appends the member SID. That dynamic identifier is intentionally omitted here. Local scenario evidence confirms the target was the unprivileged `GG-Employees` lab group; this test does not validate a privileged-group alert.

## Creation-record detail

The expanded Event ID `4720` record additionally verified:

| Field | Sanitized observed value |
|---|---|
| Windows `systemTime` | `2026-11-02T14:44:45.9779688Z` |
| `agent.name` | `AD-DC01` |
| `data.win.system.channel` | `Security` |
| `data.win.system.computer` | `AD-DC01.bluevale.test` |
| `data.win.eventdata.targetDomainName` | `BLUEVALE` |
| `data.win.eventdata.targetUserName` | `blvlock-11021644` |

The dashboard times reflect later indexing after the saved-state clock issue documented in `IR-001`; the original Windows event time remains authoritative for the activity timeline.

## Evidence classification

- Local Windows event counts and sequence: verified in [`IR-001`](../investigations/IR-001-controlled-account-lockout.md)
- Live Wazuh ingestion: verified
- Exact decoder, rule ID, level, description, groups and ATT&CK fields: verified for all four events
- Privileged-group change: not tested
- Account enable and delete actions: not tested

## Sanitization decision

The expanded data contained a private agent address, SIDs and event-record identifiers, while the Event ID `4728` description embedded the full member SID. Those views were rejected. The committed [`wazuh-account-lifecycle-alerts.png`](../screenshots/wazuh-account-lifecycle-alerts.png) uses full-screen mode and omits the description column; it retains only timestamps, rule IDs, tactics, MITRE IDs, levels and Windows event IDs.

## Analyst conclusion

The controlled identity's creation, unprivileged group addition, unlock and disable actions are visible in the live Wazuh alert index under built-in rules. The observed coverage is sufficient for baseline monitoring; future engineering should focus on correlation and privileged-group prioritization instead of duplicating the four rules.

