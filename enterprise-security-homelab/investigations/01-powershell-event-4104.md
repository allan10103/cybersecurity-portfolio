# SOC Investigation: PowerShell Script Block Logging - Event ID 4104

## Investigation Summary

PowerShell Script Block Logging was enabled on the Windows Server domain controller, `DC01`, to provide increased visibility into PowerShell activity.

During validation, Windows Event ID `4104` events were successfully generated on DC01. The investigation focused on verifying that these events were collected by the Wazuh agent, processed by the Wazuh manager, indexed correctly, and ultimately available for investigation through the Wazuh Threat Hunting dashboard.

The investigation also provided hands-on experience troubleshooting an end-to-end SIEM logging pipeline.

## Environment

| Component | Details |
|---|---|
| Endpoint | `DC01` |
| Operating System | Windows Server 2025 |
| Domain | `corp.homelab.test` |
| Endpoint IP | `192.168.50.10` |
| SIEM | Wazuh |
| Wazuh Server | `192.168.50.20` |
| Windows Event Channel | `Microsoft-Windows-PowerShell/Operational` |
| Event ID | `4104` |

## Detection

PowerShell Script Block Logging generated Event ID `4104` on DC01.

Local event generation was validated using PowerShell:

```powershell
Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-PowerShell/Operational'; Id=4104} -MaxEvents 3 | Select-Object TimeCreated,Id,Message
```

The command confirmed that recent Event ID 4104 records existed locally on the domain controller.

## Wazuh Agent Validation

The Wazuh agent on DC01 was configured to collect the PowerShell Operational event channel:

```xml
<localfile>
  <location>Microsoft-Windows-PowerShell/Operational</location>
  <log_format>eventchannel</log_format>
</localfile>
```

The Wazuh agent log confirmed that the channel was being monitored:

```text
Analyzing event log: 'Microsoft-Windows-PowerShell/Operational'
```

Connectivity between DC01 and the Wazuh server was also validated over TCP port `1514`.

## SIEM Pipeline Troubleshooting

Although Event ID 4104 existed locally, the events were not initially visible through the expected Threat Hunting search.

Rather than assuming the endpoint configuration was incorrect, each stage of the logging pipeline was validated individually.

```text
DC01 PowerShell Activity
        |
        v
Windows Event ID 4104
        |
        v
Wazuh Agent
        |
        v
Wazuh Manager
        |
        v
Wazuh Alert
        |
        v
Wazuh Indexer
        |
        v
Threat Hunting
```

### 1. Windows Event Log

Event ID `4104` was confirmed locally on DC01, proving that Windows Script Block Logging was functioning.

### 2. Wazuh Agent

The Wazuh agent service was confirmed running and monitoring the PowerShell Operational event channel.

### 3. Network Connectivity

Connectivity from DC01 to the Wazuh manager at `192.168.50.20` over TCP port `1514` was successfully validated.

### 4. Wazuh Manager Archives

Raw PowerShell 4104 events were located in the Wazuh manager archives, confirming that the manager was receiving the endpoint telemetry.

### 5. Wazuh Alerts

Event ID 4104 alerts were found in `alerts.json`.

An exact search for:

```text
"eventID":"4104"
```

confirmed that Wazuh had generated alerts from the PowerShell telemetry.

### 6. Wazuh Indexer

The Wazuh index was queried directly to determine whether the alerts had been indexed.

A count query returned:

```json
{
  "count": 10
}
```

This confirmed that 10 PowerShell Event ID 4104 alerts were stored in the searchable Wazuh index.

### 7. Threat Hunting

The final validation was performed through the Wazuh Threat Hunting interface using:

```text
agent.name: DC01
data.win.system.eventID: 4104
```

The search returned **10 events**, confirming successful end-to-end collection and indexing.

## Alert Analysis

The Wazuh alerts contained the following notable information:

| Field | Value |
|---|---|
| Agent | `DC01` |
| Event ID | `4104` |
| Wazuh Rule ID | `91816` |
| Rule Level | `4` |
| Rule Description | PowerShell script querying system environment variables |
| MITRE ATT&CK Tactic | Discovery |
| MITRE ATT&CK Technique | System Information Discovery |
| MITRE ATT&CK ID | `T1082` |

The associated PowerShell activity included Windows security-policy and system-information queries related to administrative work performed within the lab.

## Analyst Assessment

The PowerShell activity was determined to be **expected administrative activity** generated during security configuration and testing of the domain controller.

Although the activity matched a Wazuh detection rule associated with system discovery, the surrounding context did not indicate malicious behavior.

This demonstrates an important SOC principle: **an alert is not automatically an incident**. Detection rules identify activity that warrants investigation, but the analyst must evaluate the surrounding context before determining whether the activity is benign or malicious.

## Outcome

The investigation confirmed the complete telemetry path:

```text
PowerShell
→ Windows Event Logging
→ Wazuh Agent
→ Wazuh Manager
→ Detection Rule
→ Wazuh Indexer
→ Threat Hunting
```

The troubleshooting process also demonstrated how individual components of a SIEM pipeline can be validated when expected telemetry does not immediately appear in the analyst interface.

## Skills Demonstrated

- PowerShell Script Block Logging
- Windows Event Log analysis
- Wazuh agent configuration
- SIEM troubleshooting
- Log pipeline validation
- Threat hunting
- Alert triage
- MITRE ATT&CK interpretation
- Linux command-line investigation
- Windows-to-Linux log collection
- False-positive / benign-positive analysis
- SOC investigation methodology
