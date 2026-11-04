# Screenshots

Every image in this directory was reviewed before commit. Screenshots are limited to evidence that materially supports a documented claim; text-first evidence is used when a screenshot adds no analytical value.

The review excludes credentials, personal data, notifications, unrelated applications, public IP addresses, MAC addresses, exact lab addresses, SIDs and unrestricted event payloads.

## Reviewed screenshots

- `sysmon-service-verified.png` — signed Sysmon installation result, running service and enabled Operational channel
- `wazuh-event-channels-verified.png` — Wazuh event-channel list, running service and benign local event counts
- `controlled-lockout-scenario.png` — bounded lockout result, event counts, cleanup state and scenario marker
- `wazuh-failed-logons-verified.png` — five live Event ID `4625` alerts under built-in rule `60122`, level `5`
- `wazuh-account-lockout-alert.png` — one live Event ID `4740` alert under built-in rule `60115`, level `9`
- `wazuh-account-lifecycle-alerts.png` — four live account-lifecycle alerts with rule IDs, levels and event IDs

The lifecycle capture intentionally omits the description column because the built-in Event ID `4728` description embedded the full member SID. Browser chrome and expanded raw records are not included.

## Integrity catalog

| File | Dimensions | Bytes | SHA-256 |
|---|---:|---:|---|
| `controlled-lockout-scenario.png` | 1024×768 | 92,172 | `CEDDDDB81BB85FC28A63E5881E6167C31BA8B6B5DAD8B2BA00321A15A96076A6` |
| `sysmon-service-verified.png` | 1024×768 | 72,740 | `2EAFF25942B90D7ABBAEC9178F2C01FE5CA6FE30114C80A501A0C2B02AEEDC5D` |
| `wazuh-account-lifecycle-alerts.png` | 1280×720 | 74,033 | `F920584A653746FB13750FD68BF610455826042CA3253770637551D8FB3E16FD` |
| `wazuh-account-lockout-alert.png` | 1280×720 | 62,464 | `34E344995AA82E579E49E145A9957BE34882A2A799C267D6D04528575618557A` |
| `wazuh-event-channels-verified.png` | 1024×768 | 83,203 | `3F8F8C342C02EFC832096835E389317E8A7E130EFB04D58D04B574D774F78E3E` |
| `wazuh-failed-logons-verified.png` | 1280×720 | 91,739 | `C37F232AF2E71127DFEDF4CE79C38740A67DF9E9C5E416BC96D1F4DCADE64F29` |

Hashes were recalculated during the final private release audit on 4 November 2026. Any later image edit requires a new review and catalog update.
