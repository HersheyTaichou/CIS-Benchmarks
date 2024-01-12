<#
.SYNOPSIS
18.10.3 App Package Deployment

.DESCRIPTION
This command will test all the settings defined in section 18.10.3 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsAppPackageDeployment

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsAppPackageDeployment {
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
        if ($Level -eq 2) {
            Test-AppPackageDeploymentAllowSharedLocalAppData @Parameters
        }
    }
}

<#
.SYNOPSIS
18.10.5 App runtime

.DESCRIPTION
This command will test all the settings defined in section 18.10.5 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsAppruntime

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsAppruntime {
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
        Test-AppRuntimeAllowMicrosoftAccountsToBeOptional @Parameters
    }
}

<#
.SYNOPSIS
18.10.7 AutoPlay Policies

.DESCRIPTION
This command will test all the settings defined in section 18.10.7 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsAutoPlayPolicies

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsAutoPlayPolicies {
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
        Test-AutoPlayPoliciesNoAutoplayfornonVolume @Parameters
        Test-AutoPlayPoliciesNoAutorun @Parameters
        Test-AutoPlayPoliciesNoDriveTypeAutoRun @Parameters
    }
}

<#
.SYNOPSIS
18.10.8 Biometrics

.DESCRIPTION
This command will test all the settings defined in section 18.10.8 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsBiometrics

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsBiometrics {
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
        Test-BiometricsEnhancedAntiSpoofing @Parameters
    }
}

<#
.SYNOPSIS
18.10.10 Camera

.DESCRIPTION
This command will test all the settings defined in section 18.10.10 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsCamera

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsCamera {
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
        if ($Level -eq 2) {
            Test-CameraAllowCamera @Parameters
        }
    }
}

<#
.SYNOPSIS
18.10.12 Cloud Content

.DESCRIPTION
This command will test all the settings defined in section 18.10.12 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsCloudContent

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsCloudContent {
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
        Test-CloudContentDisableConsumerAccountStateContent @Parameters
        if ($Level -eq 2) {
            Test-CloudContentDisableCloudOptimizedContent @Parameters
        }
        Test-CloudContentDisableWindowsConsumerFeatures @Parameters
    }
}

<#
.SYNOPSIS
18.10.13 Connect

.DESCRIPTION
This command will test all the settings defined in section 18.10.13 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsConnect

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsConnect {
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
        Test-ConnectRequirePinForPairing @Parameters
    }
}

<#
.SYNOPSIS
18.10.14 Credential User Interface

.DESCRIPTION
This command will test all the settings defined in section 18.10.14 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsCredentialUserInterface

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsCredentialUserInterface {
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
        Test-CredentialUserInterfaceDisablePasswordReveal @Parameters
        Test-CredentialUserInterfaceEnumerateAdministrators @Parameters
    }
}

<#
.SYNOPSIS
18.10.15 Data Collection and Preview Builds

.DESCRIPTION
This command will test all the settings defined in section 18.10.15 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsDataCollectionandPreviewBuilds

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsDataCollectionandPreviewBuilds {
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
        Test-DataCollectionandPreviewBuildsAllowTelemetry @Parameters
        if ($Level -eq 2) {
            Test-DataCollectionandPreviewBuildsDisableEnterpriseAuthProxy @Parameters
        }
        Test-DataCollectionandPreviewBuildsDisableOneSettingsDownloads @Parameters
        Test-DataCollectionandPreviewBuildsDoNotShowFeedbackNotifications @Parameters
        Test-DataCollectionandPreviewBuildsEnableOneSettingsAuditing @Parameters
        Test-DataCollectionandPreviewBuildsLimitDiagnosticLogCollection @Parameters
        Test-DataCollectionandPreviewBuildsLimitDumpCollection @Parameters
        Test-DataCollectionandPreviewBuildsAllowBuildPreview @Parameters
    }
}

<#
.SYNOPSIS
18.10.17 Desktop App Installer

.DESCRIPTION
This command will test all the settings defined in section 18.10.17 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsDesktopAppInstaller

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsDesktopAppInstaller {
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
        Test-DesktopAppInstallerEnableAppInstaller @Parameters
        Test-DesktopAppInstallerEnableExperimentalFeatures @Parameters
        Test-DesktopAppInstallerEnableHashOverride @Parameters
        Test-DesktopAppInstallerEnableMSAppInstallerProtocol @Parameters
    }
}

<#
.SYNOPSIS
18.10.26 Event Log Service

.DESCRIPTION
This command will test all the settings defined in section 18.10.26 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsEventLogService

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsEventLogService {
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
        Test-EventLogServiceApplicationRetention @Parameters
        Test-EventLogServiceApplicationMaxSize @Parameters
        Test-EventLogServiceSecurityRetention @Parameters
        Test-EventLogServiceSecurityMaxSize @Parameters
        Test-EventLogServiceSetupRetention @Parameters
        Test-EventLogServiceSetupMaxSize @Parameters
        Test-EventLogServiceSystemRetention @Parameters
        Test-EventLogServiceSystemMaxSize @Parameters
    }
}

<#
.SYNOPSIS
18.10.29 File Explorer (formerly Windows Explorer)

.DESCRIPTION
This command will test all the settings defined in section 18.10.29 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsFileExplorer

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsFileExplorer {
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
        Test-FileExplorerNoDataExecutionPrevention @Parameters
        Test-FileExplorerNoHeapTerminationOnCorruption @Parameters
        Test-FileExplorerPreXPSP2ShellProtocolBehavior @Parameters
    }
}

<#
.SYNOPSIS
18.10.37 Location and Sensors

.DESCRIPTION
This command will test all the settings defined in section 18.10.37 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsLocationandSensors

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsLocationandSensors {
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
        if ($Level -eq 2) {
            Test-LocationandSensorsDisableLocation @Parameters
        }
    }
}

<#
.SYNOPSIS
18.10.41 Messaging

.DESCRIPTION
This command will test all the settings defined in section 18.10.41 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsMessaging

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsMessaging {
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
        if ($Level -eq 2) {
            Test-MessagingAllowMessageSync @Parameters
        }
    }
}

<#
.SYNOPSIS
18.10.42 Microsoft account

.DESCRIPTION
This command will test all the settings defined in section 18.10.42 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsMicrosoftaccount

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsMicrosoftaccount {
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
        Test-MicrosoftaccountDisableUserAuth @Parameters
    }
}

<#
.SYNOPSIS
18.10.43 Microsoft Defender Antivirus (formerly Windows Defender and Windows Defender Antivirus)

.DESCRIPTION
This command will test all the settings defined in section 18.10.43 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsMicrosoftDefenderAntivirus

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsMicrosoftDefenderAntivirus {
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
18.10.51 OneDrive (formerly SkyDrive)

.DESCRIPTION
This command will test all the settings defined in section 18.10.51 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsOneDrive

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsOneDrive {
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
        
    }
}

<#
.SYNOPSIS
18.10.56 Push To Install

.DESCRIPTION
This command will test all the settings defined in section 18.10.56 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsPushToInstall

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsPushToInstall {
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
        
    }
}

<#
.SYNOPSIS
18.10.57 Remote Desktop Services (formerly Terminal Services)

.DESCRIPTION
This command will test all the settings defined in section 18.10.57 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsRemoteDesktopServices

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsRemoteDesktopServices {
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
        
    }
}

<#
.SYNOPSIS
18.10.58 RSS Feeds

.DESCRIPTION
This command will test all the settings defined in section 18.10.58 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsRSSFeeds

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsRSSFeeds {
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
        
    }
}
<#
.SYNOPSIS
18.10.59 Search

.DESCRIPTION
This command will test all the settings defined in section 18.10.59 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsSearch

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsSearch {
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
        
    }
}

<#
.SYNOPSIS
18.10.63 Software Protection Platform

.DESCRIPTION
This command will test all the settings defined in section 18.10.63 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsSoftwareProtectionPlatform

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsSoftwareProtectionPlatform {
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
        
    }
}

<#
.SYNOPSIS
18.10.76 Windows Defender SmartScreen

.DESCRIPTION
This command will test all the settings defined in section 18.10.76 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsDefenderSmartScreen

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsDefenderSmartScreen {
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
        
    }
}

<#
.SYNOPSIS
18.10.80 Windows Ink Workspace

.DESCRIPTION
This command will test all the settings defined in section 18.10.80 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsInkWorkspace

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsInkWorkspace {
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
        
    }
}

<#
.SYNOPSIS
18.10.81 Windows Installer

.DESCRIPTION
This command will test all the settings defined in section 18.10.81 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsInstaller

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsInstaller {
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
        
    }
}

<#
.SYNOPSIS
18.10.82 Windows Logon Options

.DESCRIPTION
This command will test all the settings defined in section 18.10.82 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsLogonOptions

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsLogonOptions {
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
        
    }
}

<#
.SYNOPSIS
18.10.87 Windows PowerShell

.DESCRIPTION
This command will test all the settings defined in section 18.10.87 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsPowerShell

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsPowerShell {
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
        
    }
}

<#
.SYNOPSIS
18.10.89 Windows Remote Management (WinRM)

.DESCRIPTION
This command will test all the settings defined in section 18.10.89 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsRemoteManagement

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsRemoteManagement {
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
        
    }
}

<#
.SYNOPSIS
18.10.90 Windows Remote Shell

.DESCRIPTION
This command will test all the settings defined in section 18.10.90 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsRemoteShell

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsRemoteShell {
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
        
    }
}

<#
.SYNOPSIS
18.10.92 Windows Security (formerly Windows Defender Security Center)

.DESCRIPTION
This command will test all the settings defined in section 18.10.92 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsSecurity

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsSecurity {
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
        
    }
}

<#
.SYNOPSIS
18.10.93 Windows Update

.DESCRIPTION
This command will test all the settings defined in section 18.10.93 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsComponentsWindowsUpdate

--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-WindowsComponentsWindowsUpdate {
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
        
    }
}
