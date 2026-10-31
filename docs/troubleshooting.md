# Troubleshooting Record

## Dashboard returned 503 after boot

Immediately after the migrated clone booted, the dashboard listener returned:

```text
503 Service Unavailable
Wazuh dashboard server is not ready yet
```

The VM remained running and its guest network was responsive. The API became available first and returned the expected unauthenticated `401`. After approximately three minutes, the dashboard returned a `302` redirect to its login page. The condition was recorded as service initialization rather than a failed migration.

## Host memory pressure

With the transferred VM configured for 8 GB RAM, host free memory dropped below 1 GB and VirtualBox logged short guest heartbeat stalls. The permanent clone was set to 6 GB, nonessential VM features were disabled, and unrelated workloads should be closed before running additional lab VMs.

## VirtualBox console rejected synthetic keyboard input

Mouse interaction worked, but programmatic guest keystrokes were unreliable. No untrusted pasted text was executed. Service readiness was verified through localhost-only network probes instead of depending on console automation.

## Cryptographic transfer limitation

The receiving laptop did not contain the sender's original checksum manifest. A SHA-256 hash was therefore recorded after a normal shutdown as a post-transfer baseline. The successful boot and service checks provide operational validation, but the repository does not claim an independent source-to-destination checksum comparison.
