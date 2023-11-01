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

.EXAMPLE
Test-AdministrativeTemplatesComputerControlPanel -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerControlPanel {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
        Test-ControlPanelPersonalization
        Test-ControlPanelRegionalAndLanguageOptions
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

.EXAMPLE
Test-AdministrativeTemplatesComputerLAPS -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerLAPS {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
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

.EXAMPLE
Test-AdministrativeTemplatesComputerMSSecurityGuide -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerMSSecurityGuide {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
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

.EXAMPLE
Test-AdministrativeTemplatesComputerMSS -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerMSS {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
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

.EXAMPLE
Test-AdministrativeTemplatesComputerNetwork -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerNetwork {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
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

.EXAMPLE
Test-AdministrativeTemplatesComputerPrinters -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerPrinters {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
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

.EXAMPLE
Test-AdministrativeTemplatesComputerStartMenuAndTaskbar -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-AdministrativeTemplatesComputerStartMenuAndTaskbar {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
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

.EXAMPLE
Test-AdministrativeTemplatesComputerSystem -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
Function Test-AdministrativeTemplatesComputerSystem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
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

.EXAMPLE
Test-AdministrativeTemplatesComputerWindowsComponents -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
Function Test-AdministrativeTemplatesComputerWindowsComponents {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
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

.EXAMPLE
Test-CISBenchmarkAdministrativeTemplatesComputer -Level 1

Number                Name                                                                                                Source                    Pass    
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-CISBenchmarkAdministrativeTemplatesComputer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
        Test-AdministrativeTemplatesComputerControlPanel -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerLAPS -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerMSSecurityGuide -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerMSS -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerDNSClient -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerFonts -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerLanmanWorkstation -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerLinkLayerTopologyDiscovery -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerMicrosoftPeertoPeerNetworkingServices -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerNetworkConnections -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerNetworkProvider -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerTCPIPSettings -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerWindowsConnectNow -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerWindowsConnectionManager -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerNetwork -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerPrinters -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerNotifications -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerStartMenuAndTaskbar -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerSystem -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-AdministrativeTemplatesComputerWindowsComponents -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    }
    
    end {}
}
