function Test-SecurityOptionsAccounts {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()
        $ServerType = Get-ProductType

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += Test-AccountsNoConnectedUser
        if ($ServerType -eq 3) {
            $Result += Test-AccountsEnableGuestAccount
        }
        $Result += Test-AccountsLimitBlankPasswordUse
        $Result += Test-AccountsNewAdministratorName
        $Result += Test-AccountsNewGuestName
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsAudit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += Test-AuditSCENoApplyLegacyAuditPolicy
        $Result += Test-AuditCrashOnAuditFail
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsDevices {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += Test-DevicesAllocateDASD
        $Result += Test-DevicesAddPrinterDrivers
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsDomainController {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += Test-DomainControllerSubmitControl
        $Result += Test-DomainControllerVulnerableChannelAllowList
        $Result += Test-DomainControllerLdapEnforceChannelBinding
        $Result += Test-DomainControllerLDAPServerIntegrity
        $Result += Test-DomainControllerRefusePasswordChange
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsDomainMember {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += Test-DomainMemberRequireSignOrSeal
        $Result += Test-DomainMemberSealSecureChannel
        $Result += Test-DomainMemberSignSecureChannel
        $Result += Test-DomainMemberDisablePasswordChange
        $Result += Test-DomainMemberMaximumPasswordAge
        $Result += Test-DomainMemberRequireStrongKey
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsInteractiveLogin {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()
        $ServerType = Get-ProductType

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += Test-InteractiveLogonDisableCAD
        $Result += Test-InteractiveLogonDontDisplayLastUserName
        $Result += Test-InteractiveLogonInactivityTimeoutSecs
        $Result += Test-InteractiveLogonLegalNoticeText
        $Result += Test-InteractiveLogonLegalNoticeCaption
        if (($ServerType -eq 3) -and ($Level -eq 2)) {
            $Result += Test-InteractiveLogonCachedLogonsCount
        }
        $Result += Test-InteractiveLogonPasswordExpiryWarning
        if ($ServerType -eq 3) {
            $Result += Test-InteractiveLogonForceUnlockLogon
        }
        $Result += Test-InteractiveLogonScRemoveOption
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsMicrosoftNetworkClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += Test-MicrosoftNetworkClientRequireSecuritySignature
        $Result += Test-MicrosoftNetworkClientEnableSecuritySignature
        $Result += Test-MicrosoftNetworkClientEnablePlainTextPassword
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsMicrosoftNetworkServer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += $null
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsNetworkAccess {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += $null
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsNetworkSecurity {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += $null
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsShutdown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += $null
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsSystemObjects {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += $null
    }

    end {
        return $Result
    }
}

function Test-SecurityOptionsUserAccountControl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )

    begin {
        $Result = @()

        # If not already present, run GPResult.exe and store the result in a variable
        if (-not($script:gpresult)) {
            $script:gpresult = Get-GPResult
        }
    }

    process {
        $Result += $null
    }

    end {
        return $Result
    }
}
