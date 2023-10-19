function Test-AdvancedAuditPolicyConfigurationAccountLogon {
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
        $ProductType = Get-ProductType
    }
    
    process {
        Test-AccountLogonAuditCredentialValidation
        if ($ProductType -eq 2) {
            Test-AccountLogonAuditKerberosAuthenticationService
            Test-AccountLogonAuditKerberosServiceTicketOperations
        }
    }
    
    end {}
}
function Test-AdvancedAuditPolicyConfigurationAccountManagement {
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
        $ProductType = Get-ProductType
    }
    
    process {
        Test-AccountManagementAuditApplicationGroupManagement
        if ($ProductType -eq 2) {
            Test-AccountManagementAuditComputerAccountManagement
            Test-AccountManagementAuditDistributionGroupManagement
            Test-AccountManagementAuditOtherAccountManagementEvents
        }
        Test-AccountManagementAuditSecurityGroupManagement
        Test-AccountManagementAuditUserAccountManagement
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationDetailedTracking {
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
        Test-DetailedTrackingAuditPNPActivity
        Test-DetailedTrackingAuditProcessCreation
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationDSAccess {
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
        Test-DSAccessAuditDirectoryServiceAccess
        Test-DSAccessAuditDirectoryServiceChanges
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationLogonLogoff {
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
        Test-LogonLogoffAuditAccountLockout
        Test-LogonLogoffAuditGroupMembership
        Test-LogonLogoffAuditLogoff
        Test-LogonLogoffAuditLogon
        Test-LogonLogoffAuditOtherLogonLogoffEvents
        Test-LogonLogoffAuditSpecialLogon
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationObjectAccess {
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
        Test-ObjectAccessAuditDetailedFileShare
        Test-ObjectAccessAuditFileShare
        Test-ObjectAccessAuditOtherObjectAccessEvents
        Test-ObjectAccessAuditRemovableStorage
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationPolicyChange {
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
        Test-PolicyChangeAuditAuditPolicyChange
        Test-PolicyChangeAuditAuthenticationPolicyChange
        Test-PolicyChangeAuditAuthorizationPolicyChange
        Test-PolicyChangeAuditMPSSVCRuleLevelPolicyChange
        Test-PolicyChangeAuditOtherPolicyChangeEvents
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationPrivilegeUse {
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
        Test-PrivilegeUseAuditSensitivePrivilegeUse
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationSystem {
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
        Test-SystemAuditIPsecDriver
        Test-SystemAuditOtherSystemEvents
        Test-SystemAuditSecurityStateChange
        Test-SystemAuditSecuritySystemExtension
        Test-SystemAuditSystemIntegrity
    }
    
    end {}
}

function Test-CISBenchmarkAdvancedAuditPolicyConfiguration {
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
        $ProductType = Get-ProductType
    }
    
    process {
        Test-AdvancedAuditPolicyConfigurationAccountLogon
        Test-AdvancedAuditPolicyConfigurationAccountManagement
        Test-AdvancedAuditPolicyConfigurationDetailedTracking
        if ($ProductType -eq 2) {
            Test-AdvancedAuditPolicyConfigurationDSAccess
        }
        Test-AdvancedAuditPolicyConfigurationLogonLogoff
        Test-AdvancedAuditPolicyConfigurationObjectAccess
        Test-AdvancedAuditPolicyConfigurationPolicyChange
        Test-AdvancedAuditPolicyConfigurationPrivilegeUse
        Test-AdvancedAuditPolicyConfigurationSystem
    }
    
    end {}
}
