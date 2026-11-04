# LinkedIn Announcement Record

Published on 4 November 2026: [view the live LinkedIn post](https://www.linkedin.com/feed/update/urn:li:activity:7523706325982142464/).

I’ve completed my third cybersecurity portfolio project: an Active Directory Threat Detection and Incident Response Lab built on my Wazuh environment.

I designed an isolated Windows Server 2025 domain, forwarded Security, PowerShell and Sysmon telemetry to Wazuh, and investigated a controlled account-lockout sequence end to end.

What I built and verified:

- An isolated Active Directory domain and documented network boundaries
- Five failed network logons followed by a live level-9 account-lockout alert
- Account creation, group membership, unlock and disable monitoring
- Evidence-backed detection objectives and MITRE ATT&CK analysis
- Sanitized screenshots, reproduction guidance and cleanup documentation

One of the most useful lessons was knowing when not to add a custom rule. Wazuh’s built-in coverage already produced actionable alerts, so I focused on evidence quality, field-aware triage and honest limitations instead of duplicating effective logic.

Project: https://github.com/Abdullahchoglay/active-directory-detection-lab

I’d appreciate feedback from people working in SOC, Blue Team and detection-engineering roles.

#Cybersecurity #ActiveDirectory #Wazuh #BlueTeam #ThreatDetection #IncidentResponse #SOCAnalyst

