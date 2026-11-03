# LinkedIn Post Draft — Do Not Publish Automatically

I’ve completed my third cybersecurity portfolio project: an Active Directory Threat Detection and Incident Response Lab.

I built an isolated Windows Server 2025 domain, integrated its Security, PowerShell and Sysmon telemetry with Wazuh, and investigated a controlled account-lockout sequence from the original Windows events through live Wazuh alerts.

The project validates five failed network logons, the resulting account lockout, and related account creation, group membership, unlock and disable activity. I documented the exact Wazuh rules and severity levels, preserved the distinction between observed alert metadata and analyst ATT&CK interpretation, and avoided adding custom rules where the built-in coverage was already effective.

A major part of the work was evidence discipline: unique scenario markers, timestamps, local event counts, live alert correlation, false-positive considerations, limitations, cleanup, and a full privacy review before release.

The lab is intentionally resource-aware. I kept the finished v1.0 design to Wazuh plus one domain controller instead of overcommitting a 16 GB laptop with an additional client VM.

Repository: [add the public repository link after release]

#ActiveDirectory #Wazuh #SOC #CyberSecurity #ThreatDetection #IncidentResponse #Sysmon #BlueTeam #HomeLab

