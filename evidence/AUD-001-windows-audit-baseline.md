# AUD-001 — Windows audit and log-retention baseline

## Summary

On 2 November 2026, the domain controller received a focused Advanced Audit Policy and log-retention baseline before detection scenarios began. Each selected subcategory was read back as `Success and Failure` after configuration.

## Verified audit subcategories

### Account Logon

- Credential Validation
- Kerberos Authentication Service
- Kerberos Service Ticket Operations
- Other Account Logon Events

### Logon/Logoff

- Logon
- Logoff
- Account Lockout
- Special Logon

### Account Management

- User Account Management
- Security Group Management
- Other Account Management Events

### Additional coverage

- Directory Service Changes
- Audit Policy Change
- Process Creation
- Other Object Access Events
- System Integrity

## Supporting settings

- Process command-line inclusion: enabled
- PowerShell Script Block Logging: enabled
- PowerShell Module Logging: enabled for all modules
- Security log maximum size: 256 MB
- PowerShell Operational log: enabled
- PowerShell Operational maximum size: 64 MB

## Account-lockout policy

- Threshold: 5 invalid attempts
- Lockout duration: 15 minutes
- Observation window: 15 minutes

The policy applies only to the fictional lab domain. No password-backed fictional test user was created at this checkpoint.

## Evidence classification and limitation

- Policy configuration and read-back: locally verified
- Event-channel enablement and sizes: locally verified
- Scenario-specific Security event IDs: not claimed here
- Wazuh decoder and rule correlation: deferred to marked scenarios

This item establishes that the required Windows audit sources are enabled. It does not claim that every enabled subcategory generated an event or alert during baseline configuration.

