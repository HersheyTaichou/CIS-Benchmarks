function Get-WindowsFirewallSettings {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory)][string]$EntryName,
        [Parameter(Mandatory)][string]$GPResult
    )
    
    process {
        foreach ($data in $GPResult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Profile in $data.Extension.$EntryName) {
                $Return = $Profile
            }
        }
    }

    end {
        return $Return
    }
}

<#
.SYNOPSIS
9.1 Domain Profile

.DESCRIPTION
This command will test all the settings defined in section 9.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    
9.1.1     (L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'                 Group Policy Settings     True    
9.1.2     (L1) Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'             Group Policy Settings     True    
9.1.3     (L1) Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)'            Group Policy Settings     True    

.NOTES
General notes
#>
function Test-WindowsDefenderFirewallwithAdvancedSecurityDomainProfile {
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
        Test-DomainProfileEnableFirewall @Parameters
        Test-DomainProfileDefaultInboundAction @Parameters
        Test-DomainProfileDefaultOutboundAction @Parameters
        Test-DomainProfileDisableNotifications @Parameters
        Test-DomainProfileLogFilePath @Parameters
        Test-DomainProfileLogFileSize @Parameters
        Test-DomainProfileLogDroppedPackets @Parameters
        Test-DomainProfileLogSuccessfulConnections @Parameters
    }
    
    end {}
}

<#
.SYNOPSIS
9.2 Private Profile

.DESCRIPTION
This command will test all the settings defined in section 9.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-WindowsDefenderFirewallwithAdvancedSecurityPrivateProfile

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    
9.2.1     (L1) Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)'                Group Policy Settings     True    
9.2.2     (L1) Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)'            Group Policy Settings     True    
9.2.3     (L1) Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)'           Group Policy Settings     True    

.NOTES
General notes
#>
function Test-WindowsDefenderFirewallwithAdvancedSecurityPrivateProfile {
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
        Test-PrivateProfileEnableFirewall @Parameters
        Test-PrivateProfileDefaultInboundAction @Parameters
        Test-PrivateProfileDefaultOutboundAction @Parameters
        Test-PrivateProfileDisableNotifications @Parameters
        Test-PrivateProfileLogFilePath @Parameters
        Test-PrivateProfileLogFileSize @Parameters
        Test-PrivateProfileLogDroppedPackets @Parameters
        Test-PrivateProfileLogSuccessfulConnections @Parameters
    }
    
    end {}
}

<#
.SYNOPSIS
9.3 Public Profile

.DESCRIPTION
This command will test all the settings defined in section 9.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    
9.3.1     (L1) Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)'                 Group Policy Settings     True    
9.3.2     (L1) Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)'             Group Policy Settings     True    
9.3.3     (L1) Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)'            Group Policy Settings     True    

.NOTES
General notes
#>
function Test-WindowsDefenderFirewallwithAdvancedSecurityPublicProfile {
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
        Test-PublicProfileEnableFirewall @Parameters
        Test-PublicProfileDefaultInboundAction @Parameters
        Test-PublicProfileDefaultOutboundAction @Parameters
        Test-PublicProfileDisableNotifications @Parameters
        Test-PublicProfileAllowLocalPolicyMerge @Parameters
        Test-PublicProfileAllowLocalIPsecPolicyMerge @Parameters
        Test-PublicProfileLogFilePath @Parameters
        Test-PublicProfileLogFileSize @Parameters
        Test-PublicProfileLogDroppedPackets @Parameters
        Test-PublicProfileLogSuccessfulConnections @Parameters
    }
    
    end {}
}

<#
.SYNOPSIS
9 Windows Defender Firewall with Advanced Security (formerly Windows Firewall with Advanced Security)

.DESCRIPTION
This command will test all the settings defined in section 9 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-CISBenchmarkSystemServices

--------------------  ------------------                                                                                  ------                    ----    
--------------------  ------------------                                                                                  ------                    ----    
9.1.1     (L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'                 Group Policy Settings     True    
9.1.2     (L1) Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'             Group Policy Settings     True    
9.1.3     (L1) Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)'            Group Policy Settings     True    

.NOTES
General notes
#>
function Test-CISBenchmarkWindowsDefenderFirewallwithAdvancedSecurity {
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
        Test-WindowsDefenderFirewallwithAdvancedSecurityDomainProfile -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity @Parameters
        Test-WindowsDefenderFirewallwithAdvancedSecurityPrivateProfile -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity @Parameters
        Test-WindowsDefenderFirewallwithAdvancedSecurityPublicProfile -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity @Parameters
    }
    
    end {}
}
