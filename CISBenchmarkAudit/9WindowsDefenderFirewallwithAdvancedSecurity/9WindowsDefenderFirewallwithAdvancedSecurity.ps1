function Get-WindowsFirewallSettings {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory)][string]$EntryName
    )
    
    begin {
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
        foreach ($data in $script:gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Profile in $data.Extension.$EntryName) {
                return $Profile
            }
        }
    }
    
    end {}
}

<#
.SYNOPSIS
9.1 Domain Profile

.DESCRIPTION
This command will test all the settings defined in section 9.1 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
Test-WindowsDefenderFirewallwithAdvancedSecurityDomainProfile

Number                Name                                                                                                Source                    Pass    
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
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
        Test-DomainProfileEnableFirewall
        Test-DomainProfileDefaultInboundAction
        Test-DomainProfileDefaultOutboundAction
        Test-DomainProfileDisableNotifications
        Test-DomainProfileLogFilePath
        Test-DomainProfileLogFileSize
        Test-DomainProfileLogDroppedPackets
        Test-DomainProfileLogSuccessfulConnections
    }
    
    end {}
}

<#
.SYNOPSIS
9.2 Private Profile

.DESCRIPTION
This command will test all the settings defined in section 9.1 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
Test-WindowsDefenderFirewallwithAdvancedSecurityPrivateProfile

Number                Name                                                                                                Source                    Pass    
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
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
        Test-PrivateProfileEnableFirewall
        Test-PrivateProfileDefaultInboundAction
        Test-PrivateProfileDefaultOutboundAction
        Test-PrivateProfileDisableNotifications
        Test-PrivateProfileLogFilePath
        Test-PrivateProfileLogFileSize
        Test-PrivateProfileLogDroppedPackets
        Test-PrivateProfileLogSuccessfulConnections
    }
    
    end {}
}

<#
.SYNOPSIS
9.3 Public Profile

.DESCRIPTION
This command will test all the settings defined in section 9.1 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
Test-WindowsDefenderFirewallwithAdvancedSecurityDomainProfile

Number                Name                                                                                                Source                    Pass    
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
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
        Test-PublicProfileEnableFirewall
        Test-PublicProfileDefaultInboundAction
        Test-PublicProfileDefaultOutboundAction
        Test-PublicProfileDisableNotifications
        Test-PublicProfileAllowLocalPolicyMerge
        Test-PublicProfileAllowLocalIPsecPolicyMerge
        Test-PublicProfileLogFilePath
        Test-PublicProfileLogFileSize
        Test-PublicProfileLogDroppedPackets
        Test-PublicProfileLogSuccessfulConnections
    }
    
    end {}
}

<#
.SYNOPSIS
9 Windows Defender Firewall with Advanced Security (formerly Windows Firewall with Advanced Security)

.DESCRIPTION
This command will test all the settings defined in section 9 of the 
CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

.PARAMETER Level
This parameter is used to filter by the benchmark level. 

The valid options are:

1 = Level 1 of the benchmark. This is intended to provide a solid baseline for security.

2 = Level 2 of the benchmark. This is intended to provide a higher level of security, 
at the risk of breaking some functionality. This level requires and includes all the
Level 1 benchmarks

.PARAMETER NextGenerationWindowsSecurity
This parameter is used to enable the Next Generation Windows Security optional add-on to the CIS Benchmark.

These settings are recommended in environments taht can support them.

.EXAMPLE
Test-CISBenchmarkSystemServices

Number                Name                                                                                                Source                    Pass    
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
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    
    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }
    
    process {
        Test-WindowsDefenderFirewallwithAdvancedSecurityDomainProfile -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-WindowsDefenderFirewallwithAdvancedSecurityPrivateProfile -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
        Test-WindowsDefenderFirewallwithAdvancedSecurityPublicProfile -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity
    }
    
    end {}
}
