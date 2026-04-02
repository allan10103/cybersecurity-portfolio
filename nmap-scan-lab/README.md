# Nmap Scan Lab

## Overview
This lab demonstrates the use of Nmap for network reconnaissance and service enumeration.

## Tools Used
- Nmap

## Commands Used

Basic scan:
```bash
nmap scanme.nmap.org
```

Service/version detection:
```bash
nmap -sV scanme.nmap.org
```

Aggressive scan:
```bash
nmap -A scanme.nmap.org
```

## Findings
- Identified open ports such as 22 (SSH) and 80 (HTTP)
- Detected running services and versions
- Observed how exposed services provide useful information for attackers

## Security Relevance
This demonstrates how attackers perform reconnaissance to identify potential vulnerabilities.

## Key Takeaways
Understanding open ports and services is critical for both attackers and defenders in cybersecurity.

## Example Output

Below is an example of a scan performed using Nmap:

![Nmap Scan](screenshots/scan.png)
