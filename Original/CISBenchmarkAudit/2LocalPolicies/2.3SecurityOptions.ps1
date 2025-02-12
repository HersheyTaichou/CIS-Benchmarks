<#
.SYNOPSIS
2.3.1 Accounts

.DESCRIPTION
This command will test all the settings defined in section 2.3.1 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsAccounts -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-AccountsNoConnectedUser @Parameters
        if ($ProductType.Number -eq 3) {
            Test-AccountsEnableGuestAccount @Parameters
        }
        Test-AccountsLimitBlankPasswordUse @Parameters
        Test-AccountsNewAdministratorName @Parameters
        Test-AccountsNewGuestName @Parameters
    }
}

<#
.SYNOPSIS
2.3.2 Audit

.DESCRIPTION
This command will test all the settings defined in section 2.3.2 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsAudit -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.2.1   (L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override... Group Policy Settings     True    
2.3.2.2   (L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Di... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsAudit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-AuditSCENoApplyLegacyAuditPolicy @Parameters
        Test-AuditCrashOnAuditFail @Parameters
    }
}

<#
.SYNOPSIS
2.3.4 Devices

.DESCRIPTION
This command will test all the settings defined in section 2.3.4 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsDevices -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.4.1   (L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'       Group Policy Settings     True    
2.3.4.2   (L1) Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'            Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsDevices {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-DevicesAllocateDASD @Parameters
        Test-DevicesAddPrinterDrivers @Parameters
    }
}

<#
.SYNOPSIS
2.3.5 Domain Controller

.DESCRIPTION
This command will test all the settings defined in section 2.3.5 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsDomainController -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-DomainControllerSubmitControl @Parameters
        Test-DomainControllerVulnerableChannelAllowList @Parameters
        Test-DomainControllerLdapEnforceChannelBinding @Parameters
        Test-DomainControllerLDAPServerIntegrity @Parameters
        Test-DomainControllerRefusePasswordChange @Parameters
    }
}

<#
.SYNOPSIS
2.3.6 Domain Member

.DESCRIPTION
This command will test all the settings defined in section 2.3.6 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsDomainMember -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-DomainMemberRequireSignOrSeal @Parameters
        Test-DomainMemberSealSecureChannel @Parameters
        Test-DomainMemberSignSecureChannel @Parameters
        Test-DomainMemberDisablePasswordChange @Parameters
        Test-DomainMemberMaximumPasswordAge @Parameters
        Test-DomainMemberRequireStrongKey @Parameters
    }
}

<#
.SYNOPSIS
2.3.7 Interactive Logon

.DESCRIPTION
This command will test all the settings defined in section 2.3.7 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsInteractiveLogin -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-InteractiveLogonDisableCAD @Parameters
        Test-InteractiveLogonDontDisplayLastUserName @Parameters
        Test-InteractiveLogonInactivityTimeoutSecs @Parameters
        Test-InteractiveLogonLegalNoticeText @Parameters
        Test-InteractiveLogonLegalNoticeCaption @Parameters
        if (($ProductType.Number -eq 3) -and ($Level -eq 2)) {
            Test-InteractiveLogonCachedLogonsCount @Parameters
        }
        Test-InteractiveLogonPasswordExpiryWarning @Parameters
        if ($ProductType.Number -eq 3) {
            Test-InteractiveLogonForceUnlockLogon @Parameters
        }
        Test-InteractiveLogonScRemoveOption @Parameters
    }
}

<#
.SYNOPSIS
2.3.8 Microsoft Network Client

.DESCRIPTION
This command will test all the settings defined in section 2.3.8 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsMicrosoftNetworkClient -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.8.1   (L1) Ensure 'Microsoft network client: Di
.NOTES
General notes
#>
function Test-SecurityOptionsMicrosoftNetworkClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-MicrosoftNetworkClientRequireSecuritySignature @Parameters
        Test-MicrosoftNetworkClientEnableSecuritySignature @Parameters
        Test-MicrosoftNetworkClientEnablePlainTextPassword @Parameters
    }
}

<#
.SYNOPSIS
2.3.9 Microsoft Network Server

.DESCRIPTION
This command will test all the settings defined in section 2.3.9 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsMicrosoftNetworkServer -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-MicrosoftNetworkServerAutoDisconnect @Parameters
        Test-MicrosoftNetworkServerRequireSecuritySignature @Parameters
        Test-MicrosoftNetworkServerEnableSecuritySignature @Parameters
        Test-MicrosoftNetworkServerEnableForcedLogOff @Parameters
        if ($ProductType.Number -eq 3) {
            Test-MicrosoftNetworkServerSmbServerNameHardeningLevel @Parameters
        }
    }
}

<#
.SYNOPSIS
2.3.10 Network Access

.DESCRIPTION
This command will test all the settings defined in section 2.3.10 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsNetworkAccess -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-NetworkAccessLSAAnonymousNameLookup @Parameters
        if ($ProductType.Number -eq 3) {
            Test-NetworkAccessRestrictAnonymousSAM @Parameters
            Test-NetworkAccessRestrictAnonymous @Parameters
        }
        if ($Level -eq 2) {
            Test-NetworkAccessDisableDomainCreds @Parameters
        }
        Test-NetworkAccessEveryoneIncludesAnonymous @Parameters
        Test-NetworkAccessNullSessionPipes @Parameters
        Test-NetworkAccessAllowedExactPaths @Parameters
        Test-NetworkAccessAllowedPaths @Parameters
        Test-NetworkAccessRestrictNullSessAccess @Parameters
        
        if ($ProductType.Number -eq 3) {
            Test-NetworkAccessRestrictRemoteSAM @Parameters
        }
        Test-NetworkAccessNullSessionShares @Parameters
        Test-NetworkAccessForceGuest @Parameters
    }
}

<#
.SYNOPSIS
2.3.11 Network Security

.DESCRIPTION
This command will test all the settings defined in section 2.3.11 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsNetworkSecurity -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-NetworkSecurityUseMachineId @Parameters
        Test-NetworkSecurityAllowNullSessionFallback @Parameters
        Test-NetworkSecurityAllowOnlineID @Parameters
        Test-NetworkSecuritySupportedEncryptionTypes @Parameters
        Test-NetworkSecurityNoLMHash @Parameters
        Test-NetworkSecurityForceLogoffWhenHourExpire @Parameters
        Test-NetworkSecurityLmCompatibilityLevel @Parameters
        Test-NetworkSecurityLDAPClientIntegrity @Parameters
        Test-NetworkSecurityNTLMMinClientSec @Parameters
        Test-NetworkSecurityNTLMMinServerSec @Parameters
    }
}

<#
.SYNOPSIS
2.3.13 Shutdown

.DESCRIPTION
This command will test all the settings defined in section 2.3.13 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsShutdown -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.13.1  (L1) Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'  Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsShutdown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-ShutdownShutdownWithoutLogon @Parameters
    }
}

<#
.SYNOPSIS
2.3.15 System Objects

.DESCRIPTION
This command will test all the settings defined in section 2.3.15 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsSystemObjects -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.15.1  (L1) Ensure 'System objects: Require case insensitivity for non-Windows subsystems' is set to 'E... Group Policy Settings     True    
2.3.15.2  (L1) Ensure 'System objects: Strengthen default permissions of internal system objects (e.g. Sym... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-SecurityOptionsSystemObjects {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][ValidateSet(1,2)][int]$Level,
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-SystemObjectsObCaseInsensitive @Parameters
        Test-SystemObjectsProtectionMode @Parameters
    }
}

<#
.SYNOPSIS
2.3.17 User Account Control

.DESCRIPTION
This command will test all the settings defined in section 2.3.17 of the CIS Microsoft Windows Server 2022 Benchmark v2.0.0.

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
Test-SecurityOptionsUserAccountControl -Level 1

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
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
        [Parameter()][bool]$NextGenerationWindowsSecurity,
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Parameters = @{
            "ProductType" = $ProductType
            'SecEditReport' = $SecEditReport
        }
    }

    process {
        Test-UserAccountControlFilterAdministratorToken @Parameters
        Test-UserAccountControlConsentPromptBehaviorAdmin @Parameters
        Test-UserAccountControlConsentPromptBehaviorUser @Parameters
        Test-UserAccountControlEnableInstallerDetection @Parameters
        Test-UserAccountControlEnableSecureUIAPaths @Parameters
        Test-UserAccountControlEnableLUA @Parameters
        Test-UserAccountControlPromptOnSecureDesktop @Parameters
        Test-UserAccountControlEnableVirtualization @Parameters
    }
}
