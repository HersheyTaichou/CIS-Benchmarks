function Test-AdvancedAuditPolicyConfigurationAccountLogon {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    process {
        Test-AccountLogonAuditCredentialValidation -ProductType $ProductType -GPResult $GPResult
        if ($ProductType -eq 2) {
            Test-AccountLogonAuditKerberosAuthenticationService -ProductType $ProductType -GPResult $GPResult
            Test-AccountLogonAuditKerberosServiceTicketOperations -ProductType $ProductType -GPResult $GPResult
        }
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationAccountManagement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    process {
        Test-AccountManagementAuditApplicationGroupManagement -ProductType $ProductType -GPResult $GPResult
        if ($ProductType -eq 2) {
            Test-AccountManagementAuditComputerAccountManagement -ProductType $ProductType -GPResult $GPResult
            Test-AccountManagementAuditDistributionGroupManagement -ProductType $ProductType -GPResult $GPResult
            Test-AccountManagementAuditOtherAccountManagementEvents -ProductType $ProductType -GPResult $GPResult
        }
        Test-AccountManagementAuditSecurityGroupManagement -ProductType $ProductType -GPResult $GPResult
        Test-AccountManagementAuditUserAccountManagement -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationDetailedTracking {
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
        Test-DetailedTrackingAuditPNPActivity -ProductType $ProductType -GPResult $GPResult
        Test-DetailedTrackingAuditProcessCreation -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationDSAccess {
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
        Test-DSAccessAuditDirectoryServiceAccess -ProductType $ProductType -GPResult $GPResult
        Test-DSAccessAuditDirectoryServiceChanges -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationLogonLogoff {
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
        Test-LogonLogoffAuditAccountLockout -ProductType $ProductType -GPResult $GPResult
        Test-LogonLogoffAuditGroupMembership -ProductType $ProductType -GPResult $GPResult
        Test-LogonLogoffAuditLogoff -ProductType $ProductType -GPResult $GPResult
        Test-LogonLogoffAuditLogon -ProductType $ProductType -GPResult $GPResult
        Test-LogonLogoffAuditOtherLogonLogoffEvents -ProductType $ProductType -GPResult $GPResult
        Test-LogonLogoffAuditSpecialLogon -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationObjectAccess {
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
        Test-ObjectAccessAuditDetailedFileShare -ProductType $ProductType -GPResult $GPResult
        Test-ObjectAccessAuditFileShare -ProductType $ProductType -GPResult $GPResult
        Test-ObjectAccessAuditOtherObjectAccessEvents -ProductType $ProductType -GPResult $GPResult
        Test-ObjectAccessAuditRemovableStorage -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationPolicyChange {
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
        Test-PolicyChangeAuditAuditPolicyChange -ProductType $ProductType -GPResult $GPResult
        Test-PolicyChangeAuditAuthenticationPolicyChange -ProductType $ProductType -GPResult $GPResult
        Test-PolicyChangeAuditAuthorizationPolicyChange -ProductType $ProductType -GPResult $GPResult
        Test-PolicyChangeAuditMPSSVCRuleLevelPolicyChange -ProductType $ProductType -GPResult $GPResult
        Test-PolicyChangeAuditOtherPolicyChangeEvents -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationPrivilegeUse {
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
        Test-PrivilegeUseAuditSensitivePrivilegeUse -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-AdvancedAuditPolicyConfigurationSystem {
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
        Test-SystemAuditIPsecDriver -ProductType $ProductType -GPResult $GPResult
        Test-SystemAuditOtherSystemEvents -ProductType $ProductType -GPResult $GPResult
        Test-SystemAuditSecurityStateChange -ProductType $ProductType -GPResult $GPResult
        Test-SystemAuditSecuritySystemExtension -ProductType $ProductType -GPResult $GPResult
        Test-SystemAuditSystemIntegrity -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}

function Test-CISBenchmarkAdvancedAuditPolicyConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )
    
    
    
    process {
        Test-AdvancedAuditPolicyConfigurationAccountLogon -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdvancedAuditPolicyConfigurationAccountManagement -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdvancedAuditPolicyConfigurationDetailedTracking -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        if ($ProductType -eq 2) {
            Test-AdvancedAuditPolicyConfigurationDSAccess -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        }
        Test-AdvancedAuditPolicyConfigurationLogonLogoff -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdvancedAuditPolicyConfigurationObjectAccess -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdvancedAuditPolicyConfigurationPolicyChange -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdvancedAuditPolicyConfigurationPrivilegeUse -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
        Test-AdvancedAuditPolicyConfigurationSystem -Level $Level -NextGenerationWindowsSecurity $NextGenerationWindowsSecurity -ProductType $ProductType -GPResult $GPResult
    }
    
    end {}
}
