<#
.SYNOPSIS
19.1 Control Panel

.DESCRIPTION
This command will test all the settings defined in section 19.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesUser -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesUserControlPanel {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
        if ($NextGenerationWindowsSecurity) {
            $Parameters += @{
                "NextGenerationWindowsSecurity" = $NextGenerationWindowsSecurity
            }
        }
    }
    
    process {
        Test-UserControlPanelPersonalization @Parameters
    }
}

<#
.SYNOPSIS
19.5 Start Menu and Taskbar

.DESCRIPTION
This command will test all the settings defined in section 19.5 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesUser -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesUserStartMenuAndTaskbar {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
        if ($NextGenerationWindowsSecurity) {
            $Parameters += @{
                "NextGenerationWindowsSecurity" = $NextGenerationWindowsSecurity
            }
        }
    }
    
    process {
        Test-UserStartMenuAndTaskbarNotifications @Parameters
    }
}

<#
.SYNOPSIS
19.6 System

.DESCRIPTION
This command will test all the settings defined in section 19.6 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesUser -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesUserSystem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
        if ($NextGenerationWindowsSecurity) {
            $Parameters += @{
                "NextGenerationWindowsSecurity" = $NextGenerationWindowsSecurity
            }
        }
    }
    
    process {
        Test-UserSystemInternetCommunicationManagement @Parameters
    }
}

<#
.SYNOPSIS
19.7 Windows Components

.DESCRIPTION
This command will test all the settings defined in section 19.7 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesUser -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesUserWindowsComponents {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
        if ($NextGenerationWindowsSecurity) {
            $Parameters += @{
                "NextGenerationWindowsSecurity" = $NextGenerationWindowsSecurity
            }
        }
    }
    
    process {
        Test-UserWindowsComponentsAttachmentManager @Parameters
        Test-UserWindowsComponentsCloudContent @Parameters
        Test-UserWindowsComponentsNetworkSharing @Parameters
        Test-UserWindowsComponentsWindowsInstaller @Parameters
        Test-UserWindowsComponentsWindowsMediaPlayer @Parameters
    }
}

<#
.SYNOPSIS
19 Administrative Templates (User)

.DESCRIPTION
This command will test all the settings defined in section 19 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesUser -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-CISBenchmarkAdministrativeTemplatesUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        $Parameters = @{
            "Level" = $Level
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
        if ($NextGenerationWindowsSecurity) {
            $Parameters += @{
                "NextGenerationWindowsSecurity" = $NextGenerationWindowsSecurity
            }
        }
    }
    
    process {
        Test-AdministrativeTemplatesUserControlPanel @Parameters
        Test-AdministrativeTemplatesUserStartMenuAndTaskbar @Parameters
        Test-AdministrativeTemplatesUserSystem @Parameters
        Test-AdministrativeTemplatesUserWindowsComponents @Parameters
    }
}
