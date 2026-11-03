# AD-ACCOUNT-LIFECYCLE-001 — Domain account and group changes

## Status

Validated against one controlled account-lifecycle sequence. Four exact Wazuh Discover queries returned one live alert each for account creation, group membership, unlock and disable actions.

## Objective

Identify security-relevant domain account changes and preserve enough actor, target and group context for an analyst to distinguish routine administration from persistence, privilege escalation or access-removal activity.

## Data sources

- Windows Security Event ID `4720` — user account created
- Windows Security Event ID `4728` — member added to a security-enabled global group
- Windows Security Event ID `4767` — user account unlocked
- Windows Security Event ID `4725` — user account disabled
- Wazuh Windows `eventchannel` collection

## Detection logic

1. Alert on the relevant account-management event IDs from domain controllers.
2. Preserve the initiating subject, target identity, target domain and affected group.
3. Treat additions to privileged groups as higher priority than the unprivileged lab-group change validated here.
4. Correlate creation, enablement, unlock, group membership and disable/delete activity for the same identity within an analyst-selected window.
5. Suppress only documented automation after its expected actors, target scope and change window are baselined.

Event ID `4728` requires special field handling: `targetUserName` represents the group, while `memberName` identifies the added principal. Searching for the controlled account in `targetUserName` returned no result; searching `memberName` returned the expected single alert.

## Verified Wazuh behavior

| Event | Rule | Level | Description | Groups | MITRE |
|---:|---:|---:|---|---|---|
| `4720` | `60109` | `8` | User account enabled or created | `windows`, `windows_security`, `adduser`, `account_changed` | `T1098` / Persistence |
| `4728` | `60141` | `5` | Security Enabled Global Group Member Added | `windows`, `windows_security`, `group_changed`, `win_group_changed` | `T1484` / Defense Evasion, Privilege Escalation |
| `4767` | `60133` | `5` | User account unlocked | `windows`, `windows_security`, `account_changed` | `T1098` / Persistence |
| `4725` | `60111` | `8` | User account disabled or deleted | `windows`, `windows_security`, `adduser`, `account_changed` | `T1098`, `T1531` / Persistence, Impact |

All four alerts used decoder `windows_eventchannel`.

## Custom-rule decision

No duplicate custom rules were deployed. The built-in rules reliably surfaced the controlled changes with useful severity and ATT&CK metadata. Future custom logic should add value through privileged-group prioritization, unusual-actor baselining or multi-event lifecycle correlation.

## False-positive considerations

- Approved joiner, mover and leaver workflows
- Help-desk account unlocks
- Identity-governance automation
- Planned group-membership changes
- Test accounts and temporary project identities
- Replicated administration observed on multiple domain controllers

## Triage questions

- Who initiated the change, from which administrative session and host?
- Is the target a person, service, machine or temporary test identity?
- Was the account created and added to a group in a short interval?
- Does the affected group confer administrative, remote-access or data-access privileges?
- Was an unlock preceded by failures or a lockout?
- Was disablement expected cleanup or an access-removal response?

## Evidence

- [`IR-001`](../investigations/IR-001-controlled-account-lockout.md)
- [`WAZ-003`](../evidence/WAZ-003-account-lifecycle-indexing.md)

