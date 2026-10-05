# pfSense Network and Firewall Configuration

## Overview

pfSense serves as the firewall, router, and default gateway for the enterprise security homelab. It separates the simulated corporate network from the external network and provides connectivity for the systems inside the lab.

The internal corporate network uses the `192.168.50.0/24` subnet.

## Virtual Network Configuration

The pfSense virtual machine contains two network interfaces:

- **WAN:** VMware NAT
- **LAN:** VMware Host-Only Network

The WAN interface provides external network connectivity through VMware, while the LAN interface connects pfSense to the private corporate network containing the domain controller, Windows workstation, and Wazuh SIEM.

## LAN Configuration

| Setting | Configuration |
|---|---|
| Network | `192.168.50.0/24` |
| pfSense LAN IP | `192.168.50.1` |
| DHCP Range | `192.168.50.100 - 192.168.50.199` |
| Domain Controller | `192.168.50.10` |
| Wazuh SIEM | `192.168.50.20` |

pfSense acts as the default gateway at `192.168.50.1`, allowing systems on the private network to communicate outside of the lab while keeping the corporate environment logically separated from the host network.

## Purpose

This configuration provides a realistic network boundary for the lab and allows security activity to be generated and monitored within an isolated environment.

Using pfSense also provides a platform for future firewall rule configuration, network monitoring, traffic analysis, and additional security testing as the lab expands.
