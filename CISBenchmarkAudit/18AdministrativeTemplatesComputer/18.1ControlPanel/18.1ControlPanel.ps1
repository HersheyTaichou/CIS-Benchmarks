<#
.SYNOPSIS
18.1.1 Personalization

.DESCRIPTION
This command will test all the settings defined in section 18.1.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsDefenderFirewallwithAdvancedSecurityDomainProfile


.NOTES
General notes
#>
function Test-ControlPanelPersonalization {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-PersonalizationPreventEnablingLockScreenCamera @Parameters
        Test-PersonalizationPreventEnablingLockScreenSlideshow @Parameters
    }
}

<#
.SYNOPSIS
18.1.2 Regional and Language Options

.DESCRIPTION
This command will test all the settings defined in section 18.1.2 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsDefenderFirewallwithAdvancedSecurityDomainProfile


.NOTES
General notes
#>
function Test-ControlPanelRegionalAndLanguageOptions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-RegionalAndLanguageOptionsAllowUsersToEnableOnlineSpeechRecognitionServices @Parameters
    }
}
