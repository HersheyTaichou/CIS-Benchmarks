# CIS Benchmark Scripts

## Introduction

This module provides scripts designed to audit the CIS Benchmarks on a single machine. These scripts are based on the Microsoft Windows Server 2022 Benchmark version 3.0.0, released on 2024-03-19.

These scripts are VERY MUCH a work in progress, so take caution and review them carefully before running them, as they cannot consider every possible scenario. While I have done my best to account for most situations, it may not always return accurate results, and any passes or fails should be confirmed. These scripts were created as I went through the benchmark documentation and implemented them in a test environment.

If you find any commands that return inaccurate results, please open an issue.

## Similar Projects

Here are some other projects that I have found that also allow auditing against the CIS Benchmarks:

- [HardeningKitty](https://github.com/scipag/HardeningKitty)
- [Wazuh](https://wazuh.com/)

## Versions

This project is using Semantic Versioning 2.0.0 and can be considered with the rules available at the [Semantic Versioning](https://semver.org/) site.

### Version 1.0

v1 was released once the entire Microsoft Windows Server 2022 Benchmark version 2.0.0 could be audited, and is stored in a dedicted branch. v1 was also written while I was still learning how to make PowerShell modules, and does not follow all best practices.

### Version 2.0

v2 removes the requirement for a GPO export and leverages other tools. While this will allow you to run the script without being connected to a domain or have a GPO export, it removes the ability to export files from one computer and test it on another.

Tools used:

- SecEdit
- AuditPol
- The local registry

#### Progress

- [x] 1 Audit Policy
  - [x] 1.1 Password Policy
  - [x] 1.2 Account Lockout Policy
- [ ] 2 Local Policies
  - [ ] 2.2 User Rights Assignment
  - [ ] 2.3 Security Options
    - [ ] 2.3.1 Accounts
    - [ ] 2.3.2 Audit
    - [ ] 2.3.4 Devices
    - [ ] 2.3.5 Domain Controller
    - [ ] 2.3.6 Domain Member
    - [ ] 2.3.7 Interactive Logon
    - [ ] 2.3.8 Microsoft Network Client
    - [ ] 2.3.9 Microsoft Network Server
    - [ ] 2.3.10 Network Access
    - [ ] 2.3.11 Network Security
    - [ ] 2.3.13 Shutdown
    - [ ] 2.3.15 System Objects
    - [ ] 2.3.17 User Account Control
- [ ] 5 System Services
- [ ] 9 Windows Defender Firewall with Advanced Security
  - [ ] 9.1 Domain Profile
  - [ ] 9.2 Private Profile
  - [ ] 9.3 Public Profile
- [ ] 17 Advanced Audit Policy Configuration
  - [ ] 17.1 Account Logon
  - [ ] 17.2 Account Management
  - [ ] 17.3 Detailed Tracking
  - [ ] 17.4 DS Access
  - [ ] 17.5 Logon\Logoff
  - [ ] 17.6 Object Access
  - [ ] 17.7 Policy Change
  - [ ] 17.8 Privilege Use
  - [ ] 17.9 System
- [ ] 18 Administrative Templates (Computer)
- [ ] 19 Administrative Templates (User)

## Getting Started

Before starting, it is advised that you carefully review the CIS Benchmarks. You can download the latest copy of the [CIS Benchmarks](https://learn.cisecurity.org/benchmarks) for review by filling out the form on their site.

### Import the Module

To run an audit on a machine, you have multiple options based on the end goal. First, you will need to import the module:

```PowerShell
Import-Module .\CISBenchmarkAudit.psd1
```

Then, depending on what you want to do, there are a variety of commands.

### Run the Entire CIS Benchmark

To test the machine against the entire benchmark, run the following command, setting the level:

```PowerShell
Test-CISBenchmark -Level 1
```

### Test a Specific Section

To test against just one section of the benchmark, the command format is Test-CISBenchmarkSectionTitle.

Here are two examples:

```PowerShell
Test-CISBenchmarkAccountPolicy -Level 1
```

```PowerShell
Test-CISBenchmarkLocalPolicies -Level 1
```

To run just one subsection, the command will be Test-SectionTitleSubsectionTitle.

As an example, this command will test against section "1 Account Policies\1.1 Password Policy".

```PowerShell
Test-AccountPolicyPasswordPolicy -Level 1
```

As another example, this will test against "2 Local Policies\2.3 Security Options\2.3.1 Accounts". Notice that the command is always based on the lowest two levels.

```PowerShell
Test-SecurityOptionsAccounts -Level 1
```

### Test a Recommendation

You can also test just one specific recommendation, and the command will be in the format Test-SectionTitleRecommendation

This command will run the recommendation found at "1 Account Policies\1.1 Password Policy\1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)' (Automated)"

```PowerShell
Test-PasswordPolicyPasswordHistory
```

## Licenses

The CIS Benchmarks are, at last check, covered by a Create Commons "Attribution-NonCommercial-ShareAlike 4.0 International" License. The current license for the benchmarks and other CIS programs can be found at their site:

[Center for Internet Security Terms and Conditions](https://www.cisecurity.org/terms-and-conditions-table-of-contents)

Based on my understanding (I AM NOT A LAWYER!), anything based on a project with a CC BY-NC-SA 4.0 license has to also use a CC BY-NC-SA license, therefor this project is licensed under a CC BY-NC-SA 4.0 International license.
