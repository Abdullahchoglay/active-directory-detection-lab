# Custom Wazuh Rules

Custom rules will be added only when built-in Wazuh coverage is insufficient.

Before deployment:

1. Back up the active manager configuration.
2. Check the intended rule-ID range for collisions.
3. Validate XML syntax.
4. Test representative events with `wazuh-logtest`.
5. Restart only the required service.
6. Confirm manager, indexer and dashboard health.
7. Record rule-test and live-alert results separately.

No production credentials or raw sensitive events belong in this directory.
