<#
.SYNOPSIS
2.3.1 Accounts

.DESCRIPTION
This command will test all the settings defined in section 2.3.1 of the 
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
Test-SecurityOptionsAccounts -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.1.1   (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Micro... Group Policy Settings     True    
2.3.1.3   (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set ... Group Policy Settings     True    
2.3.1.4   (L1) Configure 'Accounts: Rename administrator account'                                             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsAccounts {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
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

<#
.SYNOPSIS
2.3.2 Audit

.DESCRIPTION
This command will test all the settings defined in section 2.3.2 of the 
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
Test-SecurityOptionsAudit -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.2.1   (L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override... Group Policy Settings     True    
2.3.2.2   (L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Di... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsAudit {
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
        Test-AuditSCENoApplyLegacyAuditPolicy
        Test-AuditCrashOnAuditFail
    }

    end {
    }
}

<#
.SYNOPSIS
2.3.4 Devices

.DESCRIPTION
This command will test all the settings defined in section 2.3.4 of the 
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
Test-SecurityOptionsDevices -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.4.1   (L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'       Group Policy Settings     True    
2.3.4.2   (L1) Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'            Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsDevices {
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
        Test-DevicesAllocateDASD
        Test-DevicesAddPrinterDrivers
    }

    end {
    }
}

<#
.SYNOPSIS
2.3.5 Domain Controller

.DESCRIPTION
This command will test all the settings defined in section 2.3.5 of the 
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
Test-SecurityOptionsDomainController -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.5.1   (L1) Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (... Group Policy Settings     True    
2.3.5.2   (L1) Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to ... Group Policy Settings     True    
2.3.5.3   (L1) Ensure 'Domain controller: LDAP server channel binding token requirements' is set to 'Always'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsDomainController {
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
        Test-DomainControllerSubmitControl
        Test-DomainControllerVulnerableChannelAllowList
        Test-DomainControllerLdapEnforceChannelBinding
        Test-DomainControllerLDAPServerIntegrity
        Test-DomainControllerRefusePasswordChange
    }

    end {
    }
}

<#
.SYNOPSIS
2.3.6 Domain Member

.DESCRIPTION
This command will test all the settings defined in section 2.3.6 of the 
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
Test-SecurityOptionsDomainMember -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.6.1   (L1) Ensure 'Domain member: Digitally encrypt or sign secure channel data (always)' is set to 'E... Group Policy Settings     True    
2.3.6.2   (L1) Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'En... Group Policy Settings     True    
2.3.6.3   (L1) Ensure 'Domain member: Digitally sign secure channel data (when possible)' is set to 'Enabled' Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsDomainMember {
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

<#
.SYNOPSIS
2.3.7 Interactive Logon

.DESCRIPTION
This command will test all the settings defined in section 2.3.7 of the 
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
Test-SecurityOptionsInteractiveLogin -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.7.1   (L1) Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'                   Group Policy Settings     True    
2.3.7.2   (L1) Ensure 'Interactive logon: Don't display last signed-in' is set to 'Enabled'                   Group Policy Settings     True    
2.3.7.3   (L1) Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsInteractiveLogin {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
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

<#
.SYNOPSIS
2.3.8 Microsoft Network Client

.DESCRIPTION
This command will test all the settings defined in section 2.3.8 of the 
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
Test-SecurityOptionsMicrosoftNetworkClient -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.8.1   (L1) Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'  Group Policy Settings     True    
2.3.8.2   (L1) Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set ... Group Policy Settings     True    
2.3.8.3   (L1) Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsMicrosoftNetworkClient {
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
        Test-MicrosoftNetworkClientRequireSecuritySignature
        Test-MicrosoftNetworkClientEnableSecuritySignature
        Test-MicrosoftNetworkClientEnablePlainTextPassword
    }

    end {
    }
}

<#
.SYNOPSIS
2.3.9 Microsoft Network Server

.DESCRIPTION
This command will test all the settings defined in section 2.3.9 of the 
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
Test-SecurityOptionsMicrosoftNetworkServer -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.9.1   (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' i... Group Policy Settings     True    
2.3.9.2   (L1) Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'  Group Policy Settings     True    
2.3.9.3   (L1) Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set ... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsMicrosoftNetworkServer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
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

<#
.SYNOPSIS
2.3.10 Network Access

.DESCRIPTION
This command will test all the settings defined in section 2.3.10 of the 
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
Test-SecurityOptionsNetworkAccess -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.1  (L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'             Group Policy Settings     True    
2.3.10.5  (L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disab... Group Policy Settings     True    
2.3.10.6  (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsNetworkAccess {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity
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

<#
.SYNOPSIS
2.3.11 Network Security

.DESCRIPTION
This command will test all the settings defined in section 2.3.11 of the 
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
Test-SecurityOptionsNetworkSecurity -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.11.1  (L1) Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to '... Group Policy Settings     True    
2.3.11.2  (L1) Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'        Group Policy Settings     True    
2.3.11.3  (L1) Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use onlin... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsNetworkSecurity {
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

<#
.SYNOPSIS
2.3.13 Shutdown

.DESCRIPTION
This command will test all the settings defined in section 2.3.13 of the 
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
Test-SecurityOptionsShutdown -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.13.1  (L1) Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsShutdown {
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
        Test-ShutdownShutdownWithoutLogon
    }

    end {
    }
}

<#
.SYNOPSIS
2.3.15 System Objects

.DESCRIPTION
This command will test all the settings defined in section 2.3.15 of the 
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
Test-SecurityOptionsSystemObjects -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.15.1  (L1) Ensure 'System objects: Require case insensitivity for non-Windows subsystems' is set to 'E... Group Policy Settings     True    
2.3.15.2  (L1) Ensure 'System objects: Strengthen default permissions of internal system objects (e.g. Sym... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsSystemObjects {
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
        Test-SystemObjectsObCaseInsensitive
        Test-SystemObjectsProtectionMode
    }

    end {
    }
}

<#
.SYNOPSIS
2.3.17 User Account Control

.DESCRIPTION
This command will test all the settings defined in section 2.3.17 of the 
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
Test-SecurityOptionsUserAccountControl -Level 1

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.17.1  (L1) Ensure 'User Account Control: Admin Approval Mode for the Built-in Administrator account' i... Group Policy Settings     True    
2.3.17.2  (L1) Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin ... Group Policy Settings     True    
2.3.17.3  (L1) Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set t... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsUserAccountControl {
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
