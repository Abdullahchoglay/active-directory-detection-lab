# Custom Wazuh Rules

No custom Wazuh rule is included in v1.0. Live validation showed that built-in rules `60122`, `60115`, `60109`, `60141`, `60133` and `60111` already provided reliable component alerts with useful severity, groups and ATT&CK metadata.

Duplicating those rules would add maintenance without improving detection. A future custom rule is justified only if it adds multi-event correlation, source attribution, privileged-group prioritization or environment-specific exclusions.

If future work adds a custom rule, it must:

Before deployment:

1. Back up the active manager configuration.
2. Check the intended rule-ID range for collisions.
3. Validate XML syntax.
4. Test representative events with `wazuh-logtest`.
5. Restart only the required service.
6. Confirm manager, indexer and dashboard health.
7. Record rule-test and live-alert results separately.

No production credentials or raw sensitive events belong in this directory. The absence of XML here is therefore an evidence-backed engineering decision, not unfinished work.
