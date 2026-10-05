# Active Directory and Domain Configuration

## Overview

Windows Server 2025 was configured as the domain controller for the homelab. Active Directory Domain Services (AD DS) and DNS were deployed to provide centralized identity, authentication, name resolution, and policy management for the simulated corporate environment.

## Domain Controller

| Setting | Configuration |
|---|---|
| Hostname | `DC01` |
| Operating System | Windows Server 2025 |
| IP Address | `192.168.50.10` |
| Domain | `corp.homelab.test` |
| NetBIOS Domain | `CORP` |
| Roles | Active Directory Domain Services, DNS |

DC01 uses a static IP address so domain clients and other systems can reliably locate Active Directory and DNS services.

## Organizational Unit Structure

Organizational Units (OUs) were created to organize domain objects and provide locations where Group Policy can be applied.

```text
corp.homelab.test
|
└── CORP
    ├── Users
    └── Computers
        └── CLIENT01
