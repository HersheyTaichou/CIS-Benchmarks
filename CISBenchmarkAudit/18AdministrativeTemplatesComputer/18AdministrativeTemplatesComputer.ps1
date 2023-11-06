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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
    }
    
    process {
        Test-ControlPanelPersonalization -ProductType $ProductType -GPResult $GPResult
        Test-ControlPanelRegionalAndLanguageOptions -ProductType $ProductType -GPResult $GPResult
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    begin {
        
    }
    
    process {
        Test-AdministrativeTemplatesComputerControlPanel -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerLAPS -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerMSSecurityGuide -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerMSS -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerDNSClient -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerFonts -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerLanmanWorkstation -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerLinkLayerTopologyDiscovery -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerMicrosoftPeertoPeerNetworkingServices -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerNetworkConnections -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerNetworkProvider -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerTCPIPSettings -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerWindowsConnectNow -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerWindowsConnectionManager -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerNetwork -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerPrinters -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerNotifications -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerStartMenuAndTaskbar -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerSystem -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdministrativeTemplatesComputerWindowsComponents -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}
