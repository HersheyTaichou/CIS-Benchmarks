<#
.SYNOPSIS
18.6.4 DNS Client

.DESCRIPTION
This command will test all the settings defined in section 18.6.4.4 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
function Test-NetworkDNSClient {
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
        Test-DNSClientDoHPolicy @Parameters
        Test-DNSClientEnableNetbios @Parameters
        Test-DNSClientEnableMulticast @Parameters
    }
}

<#
.SYNOPSIS
18.6.5 Fonts

.DESCRIPTION
This command will test all the settings defined in section 18.6.5 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkFonts {
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
        Test-FontsEnableFontProviders @Parameters
    }
}

<#
.SYNOPSIS
18.6.8 Lanman Workstation

.DESCRIPTION
This command will test all the settings defined in section 18.6.8 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkLanmanWorkstation {
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
        Test-LanmanWorkstationAllowInsecureGuestAuth @Parameters
    }
}

<#
.SYNOPSIS
18.6.9 Link-Layer Topology Discovery

.DESCRIPTION
This command will test all the settings defined in section 18.6.9 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkLinkLayerTopologyDiscovery {
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
            Test-LinkLayerTopologyDiscoveryEnableLLTDIO @Parameters
            Test-LinkLayerTopologyDiscoveryEnableRspndr @Parameters
        }
    }
}

<#
.SYNOPSIS
18.6.10 Microsoft Peer-to-Peer Networking Services

.DESCRIPTION
This command will test all the settings defined in section 18.6.10 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkMicrosoftPeertoPeerNetworkingServices {
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
            Test-MicrosoftP2PNetworkingServicesPeernet @Parameters
        }
    }
}

<#
.SYNOPSIS
18.6.11 Network Connections

.DESCRIPTION
This command will test all the settings defined in section 18.6.11 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkNetworkConnections {
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
        Test-NetworkConnectionsNCAllowNetBridgeNLA @Parameters
        Test-NetworkConnectionsNCShowSharedAccessUI @Parameters
        Test-NetworkConnections @Parameters
    }
}

<#
.SYNOPSIS
18.6.14 Network Provider

.DESCRIPTION
This command will test all the settings defined in section 18.6.14 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkNetworkProvider {
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
18.6.19 TCPIP Settings

.DESCRIPTION
This command will test all the settings defined in section 18.6.19 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkTCPIPSettings {
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
18.6.20 Windows Connect Now

.DESCRIPTION
This command will test all the settings defined in section 18.6.20 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkWindowsConnectNow {
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
18.6.21 Windows Connection Manager

.DESCRIPTION
This command will test all the settings defined in section 18.6.21 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
--------------------  ------------------                                                                                  ------                    ----    

.NOTES
General notes
#>
function Test-NetworkWindowsConnectionManager {
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
