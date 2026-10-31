# Wazuh VM migration handoff

Prepared: 31 October 2026 (Asia/Hebron)

## Verified source state

- VM name: `Wazuh`
- VirtualBox version: `7.2.14`
- VM state: fully powered off
- Source folder: `C:\Users\<source-user>\VirtualBox VMs\Wazuh`
- Main disk: `Wazuh.vdi`, approximately 40.23 GB
- Total VM folder: approximately 40.23 GB
- Saved-state file: none
- Source free space during preparation: approximately 8.38 GB

The source VM must remain powered off until the destination copy is validated. Never run the source and copied VM simultaneously.

## Prompt for the chat on the receiving laptop

> I am receiving a powered-off VirtualBox Wazuh VM from another Windows laptop over trusted Wi-Fi. Please start with a read-only assessment of this laptop: Windows edition, CPU, RAM, free storage, virtualization support, installed VirtualBox version and active network. The incoming VM uses VirtualBox 7.2.14, contains a 40.23 GB VDI, and needs enough space for a future Windows Server domain-controller VM. If the laptop is suitable, create a temporary password-protected SMB share at `C:\VM-Transfer` named `VM-Transfer`, restricted to my local Windows account, on the Private network profile only. Do not enable guest access, network bridging, Internet Connection Sharing, or public-network file sharing. Give me the receiving laptop's IPv4 address and wait for the source transfer. After the copy, verify file sizes and SHA-256 hashes before registering `Wazuh.vbox`. Do not start the copied VM until verification is complete, and do not delete or modify the source copy.

## Receiving-laptop checklist

1. Confirm at least 120 GB free; more is preferable.
2. Confirm at least 16 GB RAM and hardware virtualization.
3. Install the same or a newer compatible VirtualBox version if needed.
4. Connect both laptops to the same trusted Wi-Fi or temporary hotspot.
5. Ensure the Wi-Fi network is Private, not Public.
6. Create `C:\VM-Transfer` and share it as `VM-Transfer`.
7. Grant read/write access only to the authenticated local account.
8. Keep password-protected sharing enabled.
9. Report the receiving laptop's IPv4 address.

Do not use public Wi-Fi, SMB guest access, Internet Connection Sharing, or an entire-drive share.

## Transfer

The source-side helper is `Send-WazuhVm.ps1` in the local project outputs folder. It refuses to run unless Wazuh is powered off, uses restartable `robocopy`, avoids destructive mirroring, and checks file presence and sizes.

Open and authenticate to the share first:

```text
\\RECEIVING-IP\VM-Transfer
```

Then run:

```powershell
.\Send-WazuhVm.ps1 -DestinationHost 'RECEIVING-IP'
```

If Wi-Fi disconnects, run the same command again.

## SHA-256 verification

Source:

```powershell
Get-FileHash 'C:\Users\<source-user>\VirtualBox VMs\Wazuh\Wazuh.vdi' -Algorithm SHA256
```

Destination:

```powershell
Get-FileHash 'C:\VM-Transfer\Wazuh\Wazuh.vdi' -Algorithm SHA256
```

The hashes must match exactly. Repeat for `Wazuh.vbox`.

## Destination validation

After hashes match:

1. Add `C:\VM-Transfer\Wazuh\Wazuh.vbox` to VirtualBox.
2. Review resources and network settings.
3. Start only the destination copy.
4. Confirm manager, indexer, dashboard and SSH health.
5. Send and verify a marked endpoint event.
6. Remove the temporary SMB share.
7. Keep the original powered-off VM until end-to-end ingestion passes.

The existing endpoint agent currently uses localhost NAT forwarding. After migration, its backed-up and validated `ossec.conf` must be updated by an administrator to use the manager's isolated lab address.
