# Wazuh SIEM and Endpoint Monitoring

## Overview

Wazuh was deployed as the centralized Security Information and Event Management (SIEM) platform for the homelab. It collects and analyzes security telemetry from Windows systems in the Active Directory environment, providing a central location for alerting, threat hunting, and security investigations.

## Wazuh Server

The Wazuh server was deployed on Ubuntu Server as a dedicated virtual machine.

| Setting | Configuration |
|---|---|
| Hostname | `wazuh-siem` |
| Operating System | Ubuntu Server |
| IP Address | `192.168.50.20` |
| Network | `192.168.50.0/24` |
| Gateway | `192.168.50.1` |
| DNS Server | `192.168.50.10` |
| Role | Wazuh Manager, Indexer, Dashboard |

A static IP address was configured so endpoints could consistently communicate with the Wazuh server.

## Endpoint Agents

Wazuh agents were deployed to both Windows systems in the environment:

| Endpoint | Role | Wazuh Monitoring |
|---|---|---|
| `DC01` | Windows Server 2025 Domain Controller | Wazuh Agent |
| `CLIENT01` | Windows 11 Domain Workstation | Wazuh Agent |

The agents send Windows security telemetry to the Wazuh server over the private lab network.

Agent connectivity was validated to ensure both endpoints were actively communicating with the manager.

## Centralized Windows Event Monitoring

Windows event logs from DC01 and CLIENT01 are collected by Wazuh and made available through the dashboard for centralized investigation.

This allows security activity from multiple systems to be reviewed from a single interface rather than analyzing each endpoint individually.

Examples of monitored activity include:

- Successful and failed authentication
- Account lockouts
- Windows security events
- PowerShell activity
- System and service activity
- Wazuh security alerts

## Threat Hunting

The Wazuh Threat Hunting interface is used to search and filter endpoint telemetry.

Events can be investigated using fields such as:

- Agent name
- Windows Event ID
- Rule ID
- Rule level
- Event timestamp
- Computer name
- Process information
- User/account information
- MITRE ATT&CK mappings

This provides a workflow similar to a SOC analyst reviewing endpoint telemetry and investigating alerts within a SIEM.

## PowerShell Logging Integration

PowerShell Script Block Logging was enabled on DC01 to provide visibility into PowerShell activity.

The Wazuh agent was configured to collect the following Windows event channel:

```text
Microsoft-Windows-PowerShell/Operational
```

This allowed PowerShell Script Block Logging events, including Windows Event ID `4104`, to be collected and analyzed by Wazuh.

Successful collection was validated through the complete logging pipeline:

```text
PowerShell Activity
        |
        v
Windows Event Log (Event ID 4104)
        |
        v
Wazuh Agent
        |
        v
Wazuh Manager
        |
        v
Wazuh Detection Rule
        |
        v
Wazuh Indexer
        |
        v
Threat Hunting Dashboard
```

The PowerShell detection and troubleshooting process is documented separately as a SOC investigation.

## Skills Practiced

- Deploying and configuring a SIEM
- Configuring a Linux-based security monitoring server
- Deploying endpoint monitoring agents
- Centralizing Windows security logs
- Configuring Windows event channel collection
- Validating endpoint-to-SIEM connectivity
- Searching and filtering security telemetry
- Using SIEM alerts for threat hunting
- Working with MITRE ATT&CK mappings
- Troubleshooting an end-to-end security logging pipeline
