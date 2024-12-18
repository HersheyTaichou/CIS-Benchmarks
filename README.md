# CIS Benchmark Scripts

## IMPORTANT

I had grand visions for this script, including support for auditing workstations and including different editions of the benchmark, as well as tying everything into the CIS Critical Security Controls. However, work and family have put this on hold. If you want to test your own environments against the CIS benchmarks, some of these projects may better serve your needs:

- [HardeningKitty](https://github.com/scipag/HardeningKitty)
- [Wazuh](https://wazuh.com/)

## Introduction

This module provides scripts designed to audit the CIS Benchmarks in a corporate environment. These scripts are based on the Microsoft Windows Server 2022 Benchmark version 2.0.0, released on 2023-04-14.

These scripts are VERY MUCH a work in progress, so take caution and review them carefully before running them, as they cannot consider every possible scenario. While I have done my best to account for various scenarios, this may return an incorrect result, and any passes or fails should be confirmed. These scripts were created as I went through the benchmark documentation and learned how to implement them in one test environment.

## Versioning

This project is using Semantic Versioning 2.0.0 and can be considered with the rules available at the [Semantic Versioning](https://semver.org/) site.

Version 1.0 was released once the entire Microsoft Windows Server 2022 Benchmark version 2.0.0 could be audited, and the major version number should only be incremented in the following scenarios:

- The names of the commands are changed
- The inputs to the commands are changed
- The outputs of the commands are changed

## Things to Note

- These commands require all settings to be explicitly set. If you rely on default behavior, it will show up as a failure.

   For example, if you were to run the test for "2.3.10.5 (L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'", without having explicitly set that policy in Group Policy, it would come back like this:

   ```PowerShell
   Test-NetworkAccessEveryoneIncludesAnonymous
   ```

   ```text
   Number     Level Title                                                           Source                    SetCorrectly
   ------     ----- -----                                                           ------                    ------------
   2.3.10.5   L1    Ensure 'Network access: Let Everyone permissions apply to an... Group Policy Settings     False       
   ```

   If you check the default for this entry, it will indicate that the default matches the benchmark, which should be a pass. I have chosen to consider this a failure because someone could change this setting in the local policy on a computer, and it would not get over-written or prevented by the GPO settings.

- The script will check the machine's type as it runs, and run checks specific to that type. A workstation is type 1, a domain controller (DC) is type 2 and a member server (MS) is type 3. This can be overridden by specifying -ProductType [1/2/3] at runtime
  - Running on a workstation will do all checks applicable to Domain Controllers (DC) and Member Servers (MS), but skip ones specific to DCs or MSs

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
Test-CISBenchmarkAccountPolicies -Level 1
```

```PowerShell
Test-CISBenchmarkLocalPolicies -Level 1
```

To run just one subsection, the command will be Test-SectionTitleSubsectionTitle.

As an example, this command will test against section "1 Account Policies\1.1 Password Policy".

```PowerShell
Test-AccountPoliciesPasswordPolicy -Level 1
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

### Test a different machine

> **WARNING**: When testing in this manner, it is recommended that you specify the product type the group policy file was exported from, otherwise it will use the product type of the machine it is running on.

I understand that some people may be hesitant to run a large script they found on the internet on a production server. In that case, it is possible to export a copy of the GPO settings on a server, then move that file to a separate machine with this script, and run it there.

1. Generate a GP report
   1. Connect to the server to be evaluated.
   2. Run the following command:

      ```PowerShell
      gpresult.exe /x "$(get-location)\GPResult.xml" /f
      ```

   3. Move that file to a separate machine
2. Git Clone or download this module on a separate machine
3. Open an Admin PowerShell prompt and import the module

   ```PowerShell
    Import-Module CISBnchmarkAudit.psd1
   ```

4. Browse to the folder you saved the GPResult file in
5. Run any of the above commands

   > **NOTE**: The module will hold on to the GPResult file contents until you close the PowerShell window or remove and re-import the module.

## Licenses

The CIS Benchmarks are, at last check, covered by a Create Commons "Attribution-NonCommercial-ShareAlike 4.0 International" License. The current license for the benchmarks and other CIS programs can be found at their site:

[Center for Internet Security Terms and Conditions](https://www.cisecurity.org/terms-and-conditions-table-of-contents)

Based on my understanding (I AM NOT A LAWYER!), anything based on a project with a CC BY-NC-SA 4.0 license has to also use a CC BY-NC-SA license, therefor this project is licensed under a CC BY-NC-SA 4.0 International license.
