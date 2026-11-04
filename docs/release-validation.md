# v1.0 Release Validation

Validation date: 4 November 2026

| Gate | Result | Notes |
|---|---|---|
| PowerShell syntax | Pass | `Invoke-ControlledLockoutLab.ps1` parsed with the native PowerShell AST parser; it was not executed during release validation |
| Custom-rule XML | Not applicable | No custom Wazuh XML is deployed in v1.0 |
| Markdown links | Pass | Repository-relative links resolve; external project and ATT&CK links were checked during the release audit |
| Current-tree privacy scan | Pass | No exact lab address, machine SID, personal email or high-confidence embedded credential found |
| Full-history privacy scan | Pass | Rewrote `main` to remove an exact lab address and replace a personal author email with the repository owner's GitHub noreply address; rescanned every reachable revision with no remaining match |
| Screenshot review | Pass | All six PNGs reviewed; no credential, personal identifier, exact lab address, SID, public IP or notification found |
| Screenshot integrity | Pass | Dimensions, byte sizes and SHA-256 hashes are recorded in the screenshot catalog |
| Claim review | Pass | Unverified client, privileged-group, enable/delete, Kerberos and endpoint scenarios are stated as limitations rather than results |
| Git integrity | Pass | `git fsck --full` and `git diff --check` completed without repository errors; the final tree matched the pre-rewrite tree exactly |
| Local/remote parity | Pass | Sanitized `main` was published with a guarded force-push and the local and remote release-candidate commit IDs matched |

## Screenshot decisions

The original screenshots show the signed Sysmon result, Wazuh event-channel verification and the controlled local scenario summary. Three additional full-screen Wazuh Discover captures show the five failed logons, the level-9 lockout and four account-lifecycle alerts. The lifecycle description column was deliberately omitted because Event ID `4728` embedded the full member SID; expanded records and browser chrome remain excluded. The [screenshot catalog](../screenshots/README.md) records the final integrity values.

## Credential-scan interpretation

The reproduction helper necessarily contains variables named for an in-memory generated password and a fixed obviously invalid lab-only string. Review confirmed that it contains no reusable or environment credential, never prints the generated value, and clears it in `finally`.

This record is updated only with observed results; a tag or release is not treated as evidence that a failed gate passed.
