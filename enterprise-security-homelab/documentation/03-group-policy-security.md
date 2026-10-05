# Group Policy and Windows Security Configuration

## Overview

Group Policy was used to centrally configure security settings for the Active Directory environment. The goal was to simulate how an organization can enforce security controls across domain-joined Windows systems and generate useful security telemetry for monitoring and investigation.

## CORP Security Baseline

A Group Policy Object (GPO) named `CORP Security Baseline` was created and linked to the CORP organizational structure.

The policy was used to configure security and auditing settings for domain systems.

Policy application on CLIENT01 was validated using:

```powershell
gpupdate /force
```

and:

```powershell
gpresult /scope computer /r
```

The results confirmed that CLIENT01 received both the `CORP Security Baseline` and the `Default Domain Policy`.

## Account Lockout Policy

A domain-wide account lockout policy was configured to help protect domain accounts from repeated password-guessing attempts.

| Setting | Configuration |
|---|---|
| Account lockout threshold | 5 invalid logon attempts |
| Account lockout duration | 10 minutes |
| Reset account lockout counter | 10 minutes |

Testing the policy provided hands-on experience with account lockouts, password resets, authentication troubleshooting, and Active Directory account management.

## Advanced Audit Policy

Windows auditing was configured to provide greater visibility into authentication activity.

The following Logon/Logoff audit settings were enabled:

| Audit Setting | Configuration |
|---|---|
| Audit Logon | Success and Failure |
| Audit Account Lockout | Success |
| Audit Other Logon/Logoff Events | Success and Failure |

Audit policy application was validated from the Windows command line using `auditpol`.

## Windows Security Event Investigation

Authentication activity generated during testing was investigated using Windows Event Viewer.

Important events observed included:

| Event ID | Description |
|---|---|
| 4624 | Successful account logon |
| 4625 | Failed account logon |
| 4648 | Logon attempt using explicit credentials |
| 4740 | User account locked out |

Rather than relying only on the Event ID, individual events were analyzed using additional fields such as the account name, logon type, source system, process, status code, and substatus code.

For example, an intentional failed workstation unlock generated Event ID `4625` for the domain user `omacias`.

The event included:

- **Logon Type:** 7
- **Status:** `0xC000006D`
- **Substatus:** `0xC000006A`
- **Process:** `C:\Windows\System32\svchost.exe`
- **Source Address:** `127.0.0.1`

This demonstrated how Windows authentication logs can be used to determine the context behind a failed authentication attempt.

## Skills Practiced

- Creating and applying Group Policy Objects
- Configuring domain account lockout policies
- Configuring Windows Advanced Audit Policy
- Validating Group Policy application
- Analyzing Windows Security Event Logs
- Investigating authentication failures and account lockouts
- Interpreting Windows logon types and status codes
- Distinguishing expected activity from potentially suspicious authentication behavior
