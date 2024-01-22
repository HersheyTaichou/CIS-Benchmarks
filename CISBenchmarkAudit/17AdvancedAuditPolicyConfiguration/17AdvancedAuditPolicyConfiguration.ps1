function Test-AdvancedAuditPolicyConfigurationAccountLogon {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-AccountLogonAuditCredentialValidation @Parameters
        if ($ProductType -eq 2) {
            Test-AccountLogonAuditKerberosAuthenticationService @Parameters
            Test-AccountLogonAuditKerberosServiceTicketOperations @Parameters
        }
    }
}

function Test-AdvancedAuditPolicyConfigurationAccountManagement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-AccountManagementAuditApplicationGroupManagement @Parameters
        if ($ProductType -eq 2) {
            Test-AccountManagementAuditComputerAccountManagement @Parameters
            Test-AccountManagementAuditDistributionGroupManagement @Parameters
            Test-AccountManagementAuditOtherAccountManagementEvents @Parameters
        }
        Test-AccountManagementAuditSecurityGroupManagement @Parameters
        Test-AccountManagementAuditUserAccountManagement @Parameters
    }
}

function Test-AdvancedAuditPolicyConfigurationDetailedTracking {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-DetailedTrackingAuditPNPActivity @Parameters
        Test-DetailedTrackingAuditProcessCreation @Parameters
    }
}

function Test-AdvancedAuditPolicyConfigurationDSAccess {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-DSAccessAuditDirectoryServiceAccess @Parameters
        Test-DSAccessAuditDirectoryServiceChanges @Parameters
    }
}

function Test-AdvancedAuditPolicyConfigurationLogonLogoff {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-LogonLogoffAuditAccountLockout @Parameters
        Test-LogonLogoffAuditGroupMembership @Parameters
        Test-LogonLogoffAuditLogoff @Parameters
        Test-LogonLogoffAuditLogon @Parameters
        Test-LogonLogoffAuditOtherLogonLogoffEvents @Parameters
        Test-LogonLogoffAuditSpecialLogon @Parameters
    }
}

function Test-AdvancedAuditPolicyConfigurationObjectAccess {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-ObjectAccessAuditDetailedFileShare @Parameters
        Test-ObjectAccessAuditFileShare @Parameters
        Test-ObjectAccessAuditOtherObjectAccessEvents @Parameters
        Test-ObjectAccessAuditRemovableStorage @Parameters
    }
}

function Test-AdvancedAuditPolicyConfigurationPolicyChange {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-PolicyChangeAuditAuditPolicyChange @Parameters
        Test-PolicyChangeAuditAuthenticationPolicyChange @Parameters
        Test-PolicyChangeAuditAuthorizationPolicyChange @Parameters
        Test-PolicyChangeAuditMPSSVCRuleLevelPolicyChange @Parameters
        Test-PolicyChangeAuditOtherPolicyChangeEvents @Parameters
    }
}

function Test-AdvancedAuditPolicyConfigurationPrivilegeUse {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-PrivilegeUseAuditSensitivePrivilegeUse @Parameters
    }
}

function Test-AdvancedAuditPolicyConfigurationSystem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )
    
    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            "GPResult" = $GPResult
        }
    }
    
    process {
        Test-SystemAuditIPsecDriver @Parameters
        Test-SystemAuditOtherSystemEvents @Parameters
        Test-SystemAuditSecurityStateChange @Parameters
        Test-SystemAuditSecuritySystemExtension @Parameters
        Test-SystemAuditSystemIntegrity @Parameters
    }
}

function Test-CISBenchmarkAdvancedAuditPolicyConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
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
        Test-AdvancedAuditPolicyConfigurationAccountLogon @Parameters
        Test-AdvancedAuditPolicyConfigurationAccountManagement @Parameters
        Test-AdvancedAuditPolicyConfigurationDetailedTracking @Parameters
        if ($ProductType -eq 2) {
            Test-AdvancedAuditPolicyConfigurationDSAccess @Parameters
        }
        Test-AdvancedAuditPolicyConfigurationLogonLogoff @Parameters
        Test-AdvancedAuditPolicyConfigurationObjectAccess @Parameters
        Test-AdvancedAuditPolicyConfigurationPolicyChange @Parameters
        Test-AdvancedAuditPolicyConfigurationPrivilegeUse @Parameters
        Test-AdvancedAuditPolicyConfigurationSystem @Parameters
    }
}
