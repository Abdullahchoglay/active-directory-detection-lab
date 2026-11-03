# Scripts

This directory contains only harmless, reviewable automation for controlled scenario reproduction.

Scripts must:

- Require explicit test targets
- Use unique markers
- Avoid embedded credentials
- Avoid persistence, destructive actions and uncontrolled loops
- Record timestamps and cleanup actions
- Support dry-run or validation modes where practical
- Include comments describing expected telemetry

No offensive tooling, credential dumping or malware simulation belongs here.

## Included helper

- [`Invoke-ControlledLockoutLab.ps1`](Invoke-ControlledLockoutLab.ps1) — creates one fictional account, performs exactly five invalid credential checks, verifies lockout and unlock, and leaves the account disabled. It contains hard safety gates for `AD-DC01`, `bluevale.test`, the five-attempt policy and the unprivileged `GG-Employees` group.

Read the [safe reproduction guide](../docs/reproduction-guide.md) before use. The existing `IR-001` evidence came from an equivalent one-off launcher; this committed helper is the reviewed reproducibility artifact and has not been used to replace or manufacture historical evidence.
