#Requires -RunAsAdministrator

<#
.SYNOPSIS
CIS Microsoft Windows Server 2022 Benchmark v2.0.0

.DESCRIPTION
This command will test all the settings defined in the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level.

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, at the risk of breaking some functionality. This level requires and includes all the Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments that can support them.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-CISBenchmark -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Group Policy Settings     True    
1.1.1     (L1) Ensure 'Enforce password history' is set to '24 or more password(s)'                           Test Policy Fine Grain... True

.NOTES
General notes
#>
function Test-CISBenchmark {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    # 1 Account Policies
    Test-CISBenchmarkAccountPolicies -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    # 2 Local Policies
    Test-CISBenchmarkLocalPolicies -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    # 5 System Services
    Test-CISBenchmarkSystemServices -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    # 9 Windows Defender Firewall with Advanced Security
    Test-CISBenchmarkWindowsDefenderFirewallwithAdvancedSecurity -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    # 17 Advanced Audit Policy Configuration
    Test-CISBenchmarkAdvancedAuditPolicyConfiguration -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    # 18 Administrative Templates (Computer)
    Test-CISBenchmarkAdministrativeTemplatesComputer -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    # 19 Administrative Templates (User)
    Test-CISBenchmarkAdministrativeTemplatesUser -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
}

<#
.SYNOPSIS
Get the product type

.DESCRIPTION
Get and return the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Get-ProductType

2

.NOTES
General notes
#>
function Get-ProductType {
    [CmdletBinding()]
    param ()

    [int]$ProductType = (Get-CimInstance -ClassName Win32_OperatingSystem).ProductType
    return $ProductType
}

<#
.SYNOPSIS
Get and return the current GP Settings

.DESCRIPTION
Run gpresult.exe on the machine, then take the file output, and
import it as a variable

.PARAMETER Path
The full path to the XML file, if it already exists, or where to save the file

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Get-GPResult -Path "$(get-location)\GPResult.xml"

xml                             Rsop
---                             ----
version="1.0" encoding="utf-16" Rsop

.NOTES
General notes
#>
function Get-GPResult {
    [CmdletBinding()]
    param (
        [Parameter()][string]$Path = "$(get-location)\GPResult.xml",
        [Parameter()][switch]$Keep
    )
    
    begin {
        if (-not(Test-Path $Path )) {
            Write-Verbose "Updating the local group policy settings"
            gpupdate.exe /force | Out-Null
            Write-Verbose "Generating the resultant set of policies"
            gpresult.exe /x $Path /f | Out-Null
        } else {
            $Message = $Path + " found, testing the local file."
            Write-Verbose $Message
        }
    }
    
    process {
        Write-Verbose "Storing the resultant set of policies in a variable"
        [xml]$XMLgpresult = Get-Content $Path
    }
    
    end {
        if (-not($Keep)) {
            Remove-Item $Path
        }
        return $XMLgpresult
    }
}

<#
.SYNOPSIS
Get a specific GPO entry from an XML report

.DESCRIPTION
This takes some details and returns the GPO entry for those details.

.PARAMETER EntryName
This is the internal name for a GPO entry. Here are some examples:

'MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal' is the EntryName for 'Domain member: Digitally encrypt or sign secure channel data (always)' from 2.3.6.1

'Audit Credential Validation' is the EntryName for 'Audit Credential Validation' from 17.1.1

.PARAMETER Name
This is the ChildNodes name. For most entries, this is Name or KeyName. You can think of this as the name of the column where EntryName is found

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Get-GPOEntry -EntryName "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal" -Name "KeyName"

xml                             Rsop
---                             ----
version="1.0" encoding="utf-16" Rsop

.NOTES
General notes
#>
function Get-GPOEntry {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory)][string]$EntryName,
        [Parameter(Mandatory)][string]$Name,
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    process {
        foreach ($data in $GPResult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Node in $data.Extension.ChildNodes) {
                If ($Node.$Name -eq $EntryName) {
                    Return $Node
                }
            }
        }
    }
}

class CISBenchmark {
    [string]$Number # The number of the benchmark
    [string]$Level # Level 1, 2 or Next Generation Windows Security
    [string]$Profile # Domain Controller or Member Server
    [string]$Title # The title of the recommendation
    [string]$Source # Where the setting was checked from
    [bool]$SetCorrectly # if it is set correctly
    $Setting # The current setting
    hidden $Entry # The XML output of the setting
}