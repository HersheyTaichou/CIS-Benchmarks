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
