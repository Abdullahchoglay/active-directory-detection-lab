# Known Limitations

- **Two-VM scope:** v1.0 uses Wazuh and one domain controller. With both running, the 16 GB host had only about 1.4 GB free during the final audit; adding the planned 4 GB Windows client would be unsafe. A client is explicitly deferred, not claimed.
- **Single controlled investigation:** the lockout, failure and lifecycle alerts come from one bounded scenario. They demonstrate end-to-end telemetry and analysis but not production detection performance.
- **Unprivileged group test:** Event ID `4728` was verified for `GG-Employees`. No privileged-group add/remove scenario is claimed.
- **Lifecycle subset:** creation, unlock and disable were verified. Separate account enable and delete actions were not tested.
- **Kerberos and endpoint scenarios:** no standalone Kerberos, scheduled-task, service-creation or additional PowerShell investigation is claimed in this repository. Earlier endpoint work remains in the first two portfolio projects.
- **Built-in rules:** no custom Wazuh rules were deployed because the reviewed built-in rules already produced useful alerts. Multi-event correlation and environment-specific tuning remain future enhancements.
- **Clock quality:** saved-state resume caused clock drift during the first scenario. Original Windows timestamps were preserved, time was corrected, and the limitation is documented rather than hidden.
- **Post-validation availability:** during final screenshot capture, the endpoint overview reported zero active and two disconnected agents while the domain controller remained in a live-snapshot operation. A later cold Wazuh boot exposed SSH but the dashboard remained at `503` and the API did not become ready during a 24-minute observation window. The portfolio relies on the already verified live alert sequence and does not claim later agent or dashboard health.
- **Release snapshot attempt:** a post-validation live snapshot did not converge while the domain controller continued executing. VirtualBox rejected the final memory state with `VERR_VM_UNEXPECTED_UNSTABLE_STATE` and left an internal `SUSPENDED_EXT_LS` state mismatch. After normal recovery controls failed, the frozen VM process was terminated, the current disk was cold-booted successfully to the normal domain logon screen, and the idle VM was powered off. The incomplete snapshot is not represented as a usable backup; the known-good powered-off baseline remains intact.
- **Evaluation software:** Windows Server is an evaluation edition and this is not a production architecture.
- **Evidence sanitization:** raw packet captures, EVTX, unrestricted Wazuh JSON, exact internal addresses, SIDs and credentials remain outside Git.

These limitations constrain the claims but do not invalidate the verified v1.0 outcomes.

