<#
.SYNOPSIS
18.1 Control Panel

.DESCRIPTION
This command will test all the settings defined in section 18.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
function Test-AdministrativeTemplatesComputerControlPanel {
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
        Test-ControlPanelPersonalization @Parameters
        Test-ControlPanelRegionalAndLanguageOptions @Parameters
    }
    
    end {}
}

<#
.SYNOPSIS
18.3 LAPS

.DESCRIPTION
This command will test all the settings defined in section 18.3 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerLAPS -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerLAPS {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-LAPSLocalAdministratorPasswordSolution @Parameters
        Test-LAPSDoNotAllowPasswordExpirationTimeLongerThanRequiredByPolicy @Parameters
        Test-LAPSEnableLocalAdminPasswordManagement @Parameters
        Test-LAPSPasswordComplexity @Parameters
        Test-LAPSPasswordLength @Parameters
        Test-LAPSPasswordAge @Parameters
    }
}

<#
.SYNOPSIS
18.4 MS Security Guide

.DESCRIPTION
This command will test all the settings defined in section 18.4 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerMSSecurityGuide -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerMSSecurityGuide {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        if ($ProductType -eq 3) {
            Test-MSSecurityGuideApplyUACRestrictionsToLocalAccountsOnNetworkLogons @Parameters
        }
        Test-MSSecurityGuideConfigureRPCPacketLevelPrivacySettingForIncomingConnections @Parameters
        Test-MSSecurityGuideConfigureSMBv1ClientDriver @Parameters
        Test-MSSecurityGuideConfigureSMBv1Server @Parameters
        Test-MSSecurityGuideEnableSEHOP @Parameters
        Test-MSSecurityGuideNetBTNodeTypeconfiguration @Parameters
        Test-MSSecurityGuideWDigestAuthentication @Parameters
    }
}

<#
.SYNOPSIS
18.5 MSS (Legacy)

.DESCRIPTION
This command will test all the settings defined in section 18.5 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerMSS -Level 1

--------------------  ------------------                                                                                  ------                    ----    


.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerMSS {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-MSSAutoAdminLogon @Parameters
        Test-MSSDisableIPSourceRoutingIPv6 @Parameters
        Test-MSSDisableIPSourceRouting @Parameters
        Test-MSSEnableICMPRedirect @Parameters
        if ($Level -eq 2) {
            Test-MSSKeepAliveTime @Parameters
        }
        Test-MSSNoNameReleaseOnDemand @Parameters
        if ($Level -eq 2) {
            Test-MSSPerformRouterDiscovery @Parameters
        }
        Test-MSSSafeDllSearchMode @Parameters
        Test-MSSScreenSaverGracePeriod @Parameters
        if ($Level -eq 2) {
            Test-MSSTcpMaxDataRetransmissionsIPv6 @Parameters
            Test-MSSTcpMaxDataRetransmissions @Parameters
        }
        Test-MSSWarningLevel @Parameters
    }
}

<#
.SYNOPSIS
18.6 Network

.DESCRIPTION
This command will test all the settings defined in section 18.6 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerNetwork -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerNetwork {
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
        Test-NetworkDNSClient @Parameters
        Test-NetworkFonts @Parameters
        Test-NetworkLanmanWorkstation @Parameters
        Test-NetworkLinkLayerTopologyDiscovery @Parameters
        Test-NetworkMsP2PNetworkingServices @Parameters
        Test-NetworkNetworkConnections @Parameters
        Test-NetworkNetworkProvider @Parameters
        Test-NetworkTCPIPSettings @Parameters
        Test-NetworkWindowsConnectNow @Parameters
        Test-NetworkWindowsConnectionManager @Parameters
    }
}

<#
.SYNOPSIS
18.7 Printers

.DESCRIPTION
This command will test all the settings defined in section 18.7 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerPrinters -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerPrinters {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        if ($ProductType -eq 2){
            Test-PrintersRegisterSpoolerRemoteRpcEndPoint @Parameters
        } elseif ($ProductType -eq 3 -and $Level -eq 2) {
            Test-PrintersRegisterSpoolerRemoteRpcEndPoint @Parameters
        }
        Test-PrintersRedirectionguardPolicy @Parameters
        Test-PrintersRpcUseNamedPipeProtocol @Parameters
        Test-PrintersRpcAuthentication @Parameters
        Test-PrintersRpcProtocols @Parameters
        Test-PrintersForceKerberosForRpc @Parameters
        Test-PrintersRpcTcpPort @Parameters
        Test-PrintersRestrictDriverInstallationToAdministrators @Parameters
        Test-PrintersCopyFilesPolicy @Parameters
        Test-PrintersNoWarningNoElevationOnInstall @Parameters
        Test-PrintersUpdatePromptSettings @Parameters
    }
}

<#
.SYNOPSIS
18.8 Start Menu and Taskbar

.DESCRIPTION
This command will test all the settings defined in section 18.8 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerStartMenuAndTaskbar -Level 1

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerStartMenuAndTaskbar {
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
        Test-StartMenuAndTaskbarNotifications @Parameters
    }
}

<#
.SYNOPSIS
18.9 System

.DESCRIPTION
This command will test all the settings defined in section 18.9 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerSystem -Level 1


.NOTES
General notes
#>
Function Test-AdministrativeTemplatesComputerSystem {
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
    }
}

<#
.SYNOPSIS
18.10 Windows Components

.DESCRIPTION
This command will test all the settings defined in section 18.10 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-AdministrativeTemplatesComputerWindowsComponents -Level 1


.NOTES
General notes
#>
Function Test-AdministrativeTemplatesComputerWindowsComponents {
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
    }
}

<#
.SYNOPSIS
18 Administrative Templates (Computer)

.DESCRIPTION
This command will test all the settings defined in section 18 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-CISBenchmarkAdministrativeTemplatesComputer -Level 1


.NOTES
General notes
#>
function Test-CISBenchmarkAdministrativeTemplatesComputer {
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
        Test-AdministrativeTemplatesComputerControlPanel @Parameters
        if ($ProductType -eq 3) {
            Test-AdministrativeTemplatesComputerLAPS @Parameters
        }
        Test-AdministrativeTemplatesComputerMSSecurityGuide @Parameters
        Test-AdministrativeTemplatesComputerMSS @Parameters
        Test-AdministrativeTemplatesComputerNetwork @Parameters
        Test-AdministrativeTemplatesComputerPrinters @Parameters
        Test-AdministrativeTemplatesComputerStartMenuAndTaskbar @Parameters
        Test-AdministrativeTemplatesComputerSystem @Parameters
        Test-AdministrativeTemplatesComputerWindowsComponents @Parameters
    }
}
