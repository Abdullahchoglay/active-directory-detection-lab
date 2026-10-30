# Scripts

This directory will contain only harmless, reviewable automation for lab setup, validation and controlled scenario generation.

Scripts must:

- Require explicit test targets
- Use unique markers
- Avoid embedded credentials
- Avoid persistence, destructive actions and uncontrolled loops
- Record timestamps and cleanup actions
- Support dry-run or validation modes where practical
- Include comments describing expected telemetry

No offensive tooling, credential dumping or malware simulation belongs here.
