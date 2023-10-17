function Test-SecurityOptionsAccounts {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        $ServerType = Get-ProductType

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-AccountsNoConnectedUser
        if ($ServerType -eq 3) {
            Test-AccountsEnableGuestAccount
        }
        Test-AccountsLimitBlankPasswordUse
        Test-AccountsNewAdministratorName
        Test-AccountsNewGuestName
    }

    end {
    }
}

function Test-SecurityOptionsAudit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-AuditSCENoApplyLegacyAuditPolicy
        Test-AuditCrashOnAuditFail
    }

    end {
    }
}

function Test-SecurityOptionsDevices {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-DevicesAllocateDASD
        Test-DevicesAddPrinterDrivers
    }

    end {
    }
}

function Test-SecurityOptionsDomainController {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-DomainControllerSubmitControl
        Test-DomainControllerVulnerableChannelAllowList
        Test-DomainControllerLdapEnforceChannelBinding
        Test-DomainControllerLDAPServerIntegrity
        Test-DomainControllerRefusePasswordChange
    }

    end {
    }
}

function Test-SecurityOptionsDomainMember {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-DomainMemberRequireSignOrSeal
        Test-DomainMemberSealSecureChannel
        Test-DomainMemberSignSecureChannel
        Test-DomainMemberDisablePasswordChange
        Test-DomainMemberMaximumPasswordAge
        Test-DomainMemberRequireStrongKey
    }

    end {
    }
}

function Test-SecurityOptionsInteractiveLogin {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        $ServerType = Get-ProductType

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-InteractiveLogonDisableCAD
        Test-InteractiveLogonDontDisplayLastUserName
        Test-InteractiveLogonInactivityTimeoutSecs
        Test-InteractiveLogonLegalNoticeText
        Test-InteractiveLogonLegalNoticeCaption
        if (($ServerType -eq 3) -and ($Level -eq 2)) {
            Test-InteractiveLogonCachedLogonsCount
        }
        Test-InteractiveLogonPasswordExpiryWarning
        if ($ServerType -eq 3) {
            Test-InteractiveLogonForceUnlockLogon
        }
        Test-InteractiveLogonScRemoveOption
    }

    end {
    }
}

function Test-SecurityOptionsMicrosoftNetworkClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-MicrosoftNetworkClientRequireSecuritySignature
        Test-MicrosoftNetworkClientEnableSecuritySignature
        Test-MicrosoftNetworkClientEnablePlainTextPassword
    }

    end {
    }
}

function Test-SecurityOptionsMicrosoftNetworkServer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        $ServerType = Get-ProductType

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-MicrosoftNetworkServerAutoDisconnect
        Test-MicrosoftNetworkServerRequireSecuritySignature
        Test-MicrosoftNetworkServerEnableSecuritySignature
        Test-MicrosoftNetworkServerEnableForcedLogOff
        if ($ServerType -eq 3) {
            Test-MicrosoftNetworkServerSmbServerNameHardeningLevel
        }
    }

    end {
    }
}

function Test-SecurityOptionsNetworkAccess {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        $ServerType = Get-ProductType

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-NetworkAccessLSAAnonymousNameLookup
        if ($ServerType -eq 3) {
            Test-NetworkAccessRestrictAnonymousSAM
            Test-NetworkAccessRestrictAnonymous
        }
        if ($Level -eq 2) {
            Test-NetworkAccessDisableDomainCreds
        }
        Test-NetworkAccessEveryoneIncludesAnonymous
        Test-NetworkAccessNullSessionPipes
        Test-NetworkAccessAllowedExactPaths
        Test-NetworkAccessAllowedPaths
        Test-NetworkAccessRestrictNullSessAccess
        
        if ($ServerType -eq 3) {
            Test-NetworkAccessRestrictRemoteSAM
        }
        Test-NetworkAccessNullSessionShares
        Test-NetworkAccessForceGuest
    }

    end {
    }
}

function Test-SecurityOptionsNetworkSecurity {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-NetworkSecurityUseMachineId
        Test-NetworkSecurityAllowNullSessionFallback
        Test-NetworkSecurityAllowOnlineID
        Test-NetworkSecuritySupportedEncryptionTypes
        Test-NetworkSecurityNoLMHash
        Test-NetworkSecurityForceLogoffWhenHourExpire
        Test-NetworkSecurityLmCompatibilityLevel
        Test-NetworkSecurityLDAPClientIntegrity
        Test-NetworkSecurityNTLMMinClientSec
        Test-NetworkSecurityNTLMMinServerSec
    }

    end {
    }
}

function Test-SecurityOptionsShutdown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-ShutdownShutdownWithoutLogon
    }

    end {
    }
}

function Test-SecurityOptionsSystemObjects {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-SystemObjectsObCaseInsensitive
        Test-SystemObjectsProtectionMode
    }

    end {
    }
}

function Test-SecurityOptionsUserAccountControl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][switch]$NextGenerationWindowsSecurity
    )

    begin {
        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        Test-UserAccountControlFilterAdministratorToken
        Test-UserAccountControlConsentPromptBehaviorAdmin
        Test-UserAccountControlConsentPromptBehaviorUser
        Test-UserAccountControlEnableInstallerDetection
        Test-UserAccountControlEnableSecureUIAPaths
        Test-UserAccountControlEnableLUA
        Test-UserAccountControlPromptOnSecureDesktop
        Test-UserAccountControlEnableVirtualization
    }

    end {
    }
}
