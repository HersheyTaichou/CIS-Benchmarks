<#
.SYNOPSIS
18.10.57.3.2 Connections

.DESCRIPTION
This command will test all the settings defined in section 18.10.57.3.2 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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


--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-RemoteDesktopSessionHostConnections {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
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
            Test-ConnectionsfSingleSessionPerUser @Parameters
        }
    }
}

<#
.SYNOPSIS
18.10.57.3.3 Device and Resource Redirection

.DESCRIPTION
This command will test all the settings defined in section 18.10.57.3.3 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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


--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-RemoteDesktopSessionHostDeviceandResourceRedirection {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
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
            Test-DeviceandResourceRedirectionEnableUiaRedirection @Parameters
            Test-DeviceandResourceRedirectionfDisableCcm @Parameters
        }
        Test-DeviceandResourceRedirectionfDisableCdm @Parameters
        if ($Level -eq 2) {
            Test-DeviceandResourceRedirectionfDisableLocationRedir @Parameters
            Test-DeviceandResourceRedirectionfDisableLPT @Parameters
            Test-DeviceandResourceRedirectionfDisablePNPRedir @Parameters
            Test-DeviceandResourceRedirectionfDisableWebAuthn @Parameters
        }
    }
}

<#
.SYNOPSIS
18.10.57.3.9 Security

.DESCRIPTION
This command will test all the settings defined in section 18.10.57.3.9 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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


--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-RemoteDesktopSessionHostSecurity {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    
    process {
        Test-SecurityfPromptForPassword @Parameters
        Test-SecurityfEncryptRPCTraffic @Parameters
        Test-SecuritySecurityLayer @Parameters
        Test-SecurityUserAuthentication @Parameters
        Test-SecurityMinEncryptionLevel @Parameters
    }
}

<#
.SYNOPSIS
18.10.57.3.10 Session Time Limits

.DESCRIPTION
This command will test all the settings defined in section 18.10.57.3.10 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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


--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-RemoteDesktopSessionHostSessionTimeLimits {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
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
            Test-SessionTimeLimitsMaxIdleTime @Parameters
            Test-SessionTimeLimitsMaxDisconnectionTime @Parameters
        }
    }
}

<#
.SYNOPSIS
18.10.57.3.11 Temporary folders

.DESCRIPTION
This command will test all the settings defined in section 18.10.57.3.11 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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


--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-RemoteDesktopSessionHostTemporaryfolders {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }
    
    process {
        Test-TemporaryFoldersDeleteTempDirsOnExit @Parameters
        Test-TemporaryFoldersPerSessionTempDir  @Parameters
    }
}
