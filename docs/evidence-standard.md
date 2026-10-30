# Evidence Standard

## Evidence classes

### Local evidence

The event was confirmed on the originating Windows system in Event Viewer or through an equivalent local query.

### Rule-test evidence

A representative event was independently decoded and matched using Wazuh rule-testing tools. This demonstrates rule behavior but not live ingestion.

### Live Wazuh evidence

The marked event was received, decoded, alerted and indexed by the live Wazuh environment.

These classes must never be presented as interchangeable.

## Required scenario fields

- Scenario ID and title
- Unique marker
- Start and end timestamp
- Timezone
- Source host role
- Test account or object
- Event provider and event ID
- Wazuh agent, rule ID and severity when applicable
- Logon type, status and substatus when applicable
- Process, parent process, command line and hashes when applicable
- Relevant object, group or Kerberos fields
- MITRE ATT&CK technique
- Evidence classification
- Analyst conclusion
- Limitations and cleanup result

## Sanitization

Replace environment-specific values with consistent labels only after preserving a private working copy. Sanitization must not change the meaning of the event or fabricate missing fields.

## Claim rule

A repository statement is considered verified only when it points to reviewed evidence. If end-to-end ingestion was not observed, the report must say so explicitly.
