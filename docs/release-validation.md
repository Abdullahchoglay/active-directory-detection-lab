# v1.0 Release Validation

Validation date: 3 November 2026

| Gate | Result | Notes |
|---|---|---|
| PowerShell syntax | Pass | `Invoke-ControlledLockoutLab.ps1` parsed with the native PowerShell AST parser; it was not executed during release validation |
| Custom-rule XML | Not applicable | No custom Wazuh XML is deployed in v1.0 |
| Markdown links | Pass | Repository-relative links resolve; external project and ATT&CK links were checked during the release audit |
| Current-tree privacy scan | Pass | No exact lab address, machine SID, personal email or high-confidence embedded credential found |
| Full-history privacy scan | Pass | Rewrote `main` to remove an exact lab address and replace a personal author email with the repository owner's GitHub noreply address; rescanned every reachable revision with no remaining match |
| Screenshot review | Pass | All three PNGs reviewed; no credential, personal identifier, exact lab address, SID, public IP or notification found |
| Claim review | Pass | Unverified client, privileged-group, enable/delete, Kerberos and endpoint scenarios are stated as limitations rather than results |
| Git integrity | Pass | `git fsck --full` and `git diff --check` completed without repository errors; the final tree matched the pre-rewrite tree exactly |
| Local/remote parity | Pending publication | Rechecked after the final commit and history sanitation |

## Screenshot decisions

The committed screenshots show only the signed Sysmon result, Wazuh event-channel verification and the controlled local scenario summary. Wazuh dashboard captures were not committed because expanded records exposed private addressing and identifiers, while browser chrome showed unrelated personal context. Text-first evidence preserves the reviewed rule fields instead.

## Credential-scan interpretation

The reproduction helper necessarily contains variables named for an in-memory generated password and a fixed obviously invalid lab-only string. Review confirmed that it contains no reusable or environment credential, never prints the generated value, and clears it in `finally`.

This record is updated only with observed results; a tag or release is not treated as evidence that a failed gate passed.
