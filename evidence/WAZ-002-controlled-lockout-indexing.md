# WAZ-002 — Controlled lockout live indexing

## Summary

On 2 November 2026, an authenticated Wazuh Discover review correlated the unique fictional account from `IR-001` to live alerts in the `wazuh-alerts-*` data view. This evidence upgrades the scenario from transport-only verification to scenario-specific live indexing evidence.

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

## Evidence classification

- Local Windows evidence: verified separately in [`IR-001`](../investigations/IR-001-controlled-account-lockout.md)
- Encrypted agent transport: verified separately in `IR-001`
- Live Wazuh ingestion and indexing for the unique scenario identity: verified
- Exact Wazuh rule ID, level, groups and MITRE fields for Event ID `4740`: not captured and not claimed

The 18-result filter proves that events tied to the unique scenario identity reached the live Wazuh alert index. The expanded `4725` record proves representative decoded Windows fields. It does not establish the built-in rule path for every event in the set.

## Sanitization decision

The live result table also displayed the agent's exact private address, and the expanded payload included a machine SID. Those values are intentionally omitted. No unrestricted JSON export or screenshot was committed. This text-first record preserves the security-relevant result without publishing unnecessary identifiers.

## Analyst conclusion

The controlled account lifecycle is visible end to end from Windows auditing through the live Wazuh index. A focused review of Event ID `4740` is still required before documenting a Wazuh rule ID or deciding whether custom correlation provides value beyond the built-in Windows-event coverage.
