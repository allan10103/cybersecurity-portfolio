# Enterprise Security Homelab

A hands-on enterprise cybersecurity homelab built to simulate a small corporate Windows environment and practice system administration, network security, centralized logging, detection, and SOC investigation.

## Project Overview

This lab uses a Windows Active Directory environment protected by a pfSense firewall and monitored through a Wazuh SIEM. The environment was built in VMware Workstation and includes a Windows Server domain controller, a domain-joined Windows 11 workstation, centralized DNS and Group Policy, Windows security auditing, and endpoint monitoring.

The lab is used to generate and investigate security events in a controlled environment, providing hands-on experience with technologies and workflows commonly encountered in enterprise IT and Security Operations Center (SOC) environments.

## Technologies Used

- VMware Workstation Pro
- pfSense
- Windows Server 2025
- Active Directory Domain Services (AD DS)
- DNS
- Group Policy
- Windows 11
- Wazuh SIEM
- Ubuntu Server
- Windows Event Logs
- PowerShell
- MITRE ATT&CK


## Lab Architecture

The homelab is built on a private `192.168.50.0/24` network with pfSense acting as the firewall and gateway. Active Directory and DNS services are provided by DC01, while Wazuh provides centralized security monitoring for the Windows systems.

```text
Internet
   |
   v
pfSense Firewall
LAN: 192.168.50.1
   |
   +--------------------- CORP Network (192.168.50.0/24) ---------------------+
   |                                                                          |
   v                                                                          v
DC01                                                                    WAZUH-SIEM
Windows Server 2025                                                     Ubuntu Server
192.168.50.10                                                          192.168.50.20
AD DS / DNS                                                             Wazuh Manager
Group Policy                                                            SIEM / Monitoring
   |
   v
CLIENT01
Windows 11
Domain Joined
Wazuh Agent
```

**Domain:** `corp.homelab.test`

### System Roles

| System | Operating System | IP Address | Role |
|---|---|---|---|
| pfSense | pfSense CE | 192.168.50.1 | Firewall, router, and network gateway |
| DC01 | Windows Server 2025 | 192.168.50.10 | Domain Controller, Active Directory, DNS, Group Policy |
| WAZUH-SIEM | Ubuntu Server | 192.168.50.20 | Wazuh Manager, SIEM, centralized security monitoring |
| CLIENT01 | Windows 11 | DHCP | Domain-joined employee workstation monitored by Wazuh |

## SOC Investigations

### PowerShell Script Block Logging — Event ID 4104

Investigated PowerShell Script Block Logging activity generated on the Windows Server domain controller and traced the telemetry through the complete Wazuh SIEM pipeline.

The investigation included validating Windows Event ID 4104 locally, confirming Wazuh agent collection, verifying manager ingestion and alert generation, querying the Wazuh index, analyzing MITRE ATT&CK context, and determining the activity was expected administrative behavior.

**Key skills:** SIEM troubleshooting, threat hunting, Windows Event Log analysis, PowerShell logging, alert triage, MITRE ATT&CK, and benign-positive analysis.

[View the full SOC investigation →](investigations/01-powershell-event-4104.md)
