<#
.SYNOPSIS
19.7.4 Attachment Manager

.DESCRIPTION
This command will test all the settings defined in section 19.7.4 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerControlPanel -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-UserWindowsComponentsAttachmentManager {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    
    process {
        Test-UserAttachmentManagerSaveZoneInformation @Parameters
        Test-UserAttachmentManagerScanWithAntiVirus @Parameters
    }
}

<#
.SYNOPSIS
19.7.7 Cloud Content

.DESCRIPTION
This command will test all the settings defined in section 19.7.7 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerControlPanel -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-UserWindowsComponentsCloudContent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    
    process {
        Test-UserCloudContentConfigureWindowsSpotlight @Parameters
        Test-UserCloudContentDisableThirdPartySuggestions @Parameters
        if ($Level -eq 2) {
            Test-UserCloudContentDisableTailoredExperiencesWithDiagnosticData @Parameters
            Test-UserCloudContentDisableWindowsSpotlightFeatures @Parameters
        }
        Test-UserCloudContentDisableSpotlightCollectionOnDesktop @Parameters
    }
}

<#
.SYNOPSIS
19.7.25 Network Sharing

.DESCRIPTION
This command will test all the settings defined in section 19.7.25 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerControlPanel -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-UserWindowsComponentsNetworkSharing {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    
    process {
        Test-UserNetworkSharingNoInplaceSharing @Parameters
    }
}

<#
.SYNOPSIS
19.7.40 Windows Installer

.DESCRIPTION
This command will test all the settings defined in section 19.7.40 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerControlPanel -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-UserWindowsComponentsWindowsInstaller {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    
    process {
        Test-UserWindowsInstallerAlwaysInstallElevated @Parameters
    }
}

<#
.SYNOPSIS
19.7.42 Windows Media Player

.DESCRIPTION
This command will test all the settings defined in section 19.7.42 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerControlPanel -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-UserWindowsComponentsWindowsMediaPlayer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    
    process {
        if ($Level -eq 2) {
            Test-UserWindowsMediaPlayerPreventCodecDownload @Parameters
        }
    }
}
