# Scope and Safety

## Authorized scope

This lab is limited to systems, virtual machines, accounts and networks owned by the project author. All identities are fictional test accounts created specifically for the lab.

## Safety controls

- Active Directory services remain on an isolated lab network.
- No public inbound access to LDAP, LDAPS, Kerberos, DNS, SMB or RPC.
- No real passwords, personal accounts or reused credentials.
- No credential dumping, malware, persistence or destructive payloads.
- Authentication tests are bounded, slow and restricted to named test accounts.
- Every scenario uses a unique marker and recorded timestamp.
- Configuration files are backed up before modification.
- XML and PowerShell syntax is checked before deployment.
- Wazuh and Windows service health is confirmed after material changes.
- Test accounts and objects are cleaned up after evidence collection.

## Evidence handling

The public repository must not contain:

- Credentials, tokens, private keys or password hashes
- Personal names, email addresses or account identifiers
- MAC addresses, public IP addresses or unnecessary internal addressing
- Raw EVTX files, packet captures or unrestricted Wazuh exports
- VM disks, installation images or saved states
- Screenshots with unreviewed hostnames, usernames or notifications

Evidence will be reduced to sanitized summaries containing only the fields required to support the documented conclusion.

## Non-goals

This is not a production architecture, penetration test, malware-analysis environment or red-team exercise. The project demonstrates defensive telemetry, rule validation and incident-response reasoning.
