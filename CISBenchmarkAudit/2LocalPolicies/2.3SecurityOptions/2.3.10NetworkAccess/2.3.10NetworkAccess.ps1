<#
.SYNOPSIS
2.3.10.1 (L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether an anonymous user can request security identifier (SID) attributes for another user, or use a SID to obtain its corresponding user name.

.EXAMPLE
Test-NetworkAccessLSAAnonymousNameLookup

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.1  (L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessLSAAnonymousNameLookup {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "LSAAnonymousNameLookup"
        $RecommendationNumber = '2.3.10.1'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry) {
            if ($Setting) {
                $Pass = $false
            } elseif ($setting -eq $false) {
                $Pass = $true
            } else {
                $Pass = $false
            }
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.2 (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled' (MS only)

.DESCRIPTION
This policy setting controls the ability of anonymous users to enumerate the accounts in the Security Accounts Manager (SAM).

.EXAMPLE
Test-NetworkAccessRestrictAnonymousSAM

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.2  (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enab... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessRestrictAnonymousSAM {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM"
        $RecommendationNumber = '2.3.10.2'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.3 (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled' (MS only)

.DESCRIPTION
This policy setting controls the ability of anonymous users to enumerate SAM accounts as well as shares.

.EXAMPLE
Test-NetworkAccessRestrictAnonymous

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.3  (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is s... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessRestrictAnonymous {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymous"
        $RecommendationNumber = '2.3.10.3'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.4 (L2) Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether Credential Manager (formerly called Stored User Names and Passwords) saves passwords or credentials for later use when it gains domain authentication.

.EXAMPLE
Test-NetworkAccessDisableDomainCreds

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.4  (L2) Ensure 'Network access: Do not allow storage of passwords and credentials for network authe... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessDisableDomainCreds {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\DisableDomainCreds"
        $RecommendationNumber = '2.3.10.4'
        $ProfileApplicability = @("Level 2 - Domain Controller","Level 2 - Member Server")
        $RecommendationName = "(L2) Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.5 (L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'

.DESCRIPTION
This policy setting determines what additional permissions are assigned for anonymous connections to the computer.

.EXAMPLE
Test-NetworkAccessEveryoneIncludesAnonymous

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.5  (L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disab... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessEveryoneIncludesAnonymous {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\EveryoneIncludesAnonymous"
        $RecommendationNumber = '2.3.10.5'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry) {
            if ($Setting) {
                $Pass = $false
            } elseif ($setting -eq $false) {
                $Pass = $true
            } else {
                $Pass = $false
            }
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

# 2.3.10.6 and 2.3.10.7
<#
.SYNOPSIS
2.3.10.6 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)
2.3.10.7 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only)

.DESCRIPTION
This policy setting determines which communication sessions, or pipes, will have attributes and permissions that allow anonymous access.

.EXAMPLE
Test-NetworkAccessNullSessionPipes

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.6  (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)             Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessNullSessionPipes {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $ServerType = Get-ProductType
        $Source = 'Group Policy Settings'
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes"
        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $Setting = @()
        $Entry.SettingStrings.Value | ForEach-Object {$Setting += $_}
        if (-not($Setting)) {
            $Setting = @("")
        }
        $DomainController = @("LSARPC","NETLOGON","SAMR")
        $DCBrowser = @("LSARPC", "NETLOGON", "SAMR","BROWSER")
        $MemberServer = @('')
        $MSBrowser = @("BROWSER")
        $MSRDS = @("HydraLSPipe","TermServLicensing")
        $MSRDSBrowser = @("HydraLSPipe","TermServLicensing","BROWSER")

        if ($ServerType -eq 2) {
            $RecommendationNumber = '2.3.10.6'
            $ProfileApplicability = @("Level 1 - Domain Controller")
            $RecommendationName = "(L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)"
            if ($entry) {
                if (-not(Compare-Object -ReferenceObject $DomainController -DifferenceObject $setting)) {
                    $Pass = $true
                } elseif (-not(Compare-Object -ReferenceObject $DCBrowser -DifferenceObject $setting)) {
                    $Pass = $true
                } else {
                    $Pass = $false
                }
            } else {
                $Pass = $false
            }
        } elseif ($ServerType -eq 3) {
            $RecommendationNumber = '2.3.10.7'
            $ProfileApplicability = @("Level 1 - Member Server")
            $RecommendationName = "(L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only)"
            if ($entry) {
                if (-not(Compare-Object -ReferenceObject $MemberServer -DifferenceObject $setting)) {
                    $Pass = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSBrowser -DifferenceObject $setting)) {
                    $Pass = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSRDS -DifferenceObject $setting)) {
                    $Pass = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSRDSBrowser -DifferenceObject $setting)) {
                    $Pass = $true
                } else {
                    $Pass = $false
                }
            } else {
                $Pass = $false
            }
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.8 (L1) Configure 'Network access: Remotely accessible registry paths' is configured

.DESCRIPTION
This policy setting determines which registry paths will be accessible over the network, regardless of the users or groups listed in the access control list (ACL) of the winreg registry key.

.EXAMPLE
Test-NetworkAccessAllowedExactPaths

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.8  (L1) Configure 'Network access: Remotely accessible registry paths' is configured                   Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessAllowedExactPaths {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths\Machine"
        $RecommendationNumber = '2.3.10.8'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Network access: Remotely accessible registry paths' is configured"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $Setting = $Entry.SettingStrings.Value
        $Definition = @('System\CurrentControlSet\Control\ProductOptions','System\CurrentControlSet\Control\Server Applications','Software\Microsoft\Windows NT\CurrentVersion')
        if ($Entry) {
            if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $setting)) {
                $Pass = $true
            } else {
                $Pass = $false
            }
        } else  {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.9 (L1) Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured

.DESCRIPTION
This policy setting determines which registry paths and sub-paths will be accessible over the network, regardless of the users or groups listed in the access control list (ACL) of the winreg registry key.

.EXAMPLE
Test-NetworkAccessAllowedPaths

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.9  (L1) Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured     Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessAllowedPaths {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths\Machine"
        $RecommendationNumber = '2.3.10.9'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $Setting = $Entry.SettingStrings.Value
        $definition = @('System\CurrentControlSet\Control\Print\Printers','System\CurrentControlSet\Services\Eventlog','Software\Microsoft\OLAP Server','Software\Microsoft\Windows NT\CurrentVersion\Print','Software\Microsoft\Windows NT\CurrentVersion\Windows','System\CurrentControlSet\Control\ContentIndex','System\CurrentControlSet\Control\Terminal Server','System\CurrentControlSet\Control\Terminal Server\UserConfig','System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration','Software\Microsoft\Windows NT\CurrentVersion\Perflib','System\CurrentControlSet\Services\SysmonLog')
        $ADCS = $definition + 'System\CurrentControlSet\Services\CertSvc'
        $WINS = $definition + 'System\CurrentControlSet\Services\WINS'
        $ADCSWins = $ADCS + 'System\CurrentControlSet\Services\WINS'

        if ($Entry) {
            if (-not(Compare-Object -ReferenceObject $definition -DifferenceObject $setting)) {
                $Pass = $true
            } elseif (-not(Compare-Object -ReferenceObject $ADCS -DifferenceObject $setting)) {
                $Pass = $true
            } elseif (-not(Compare-Object -ReferenceObject $WINS -DifferenceObject $setting)) {
                $Pass = $true
            } elseif (-not(Compare-Object -ReferenceObject $ADCSWins -DifferenceObject $setting)) {
                $Pass = $true
            } else {
                $Pass = $false
            }
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.10 (L1) Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'

.DESCRIPTION
When enabled, this policy setting restricts anonymous access to only those shares and pipes that are named in the "Network access: Named pipes that can be accessed anonymously" and "Network access: Shares that can be accessed anonymously" settings.

.EXAMPLE
Test-NetworkAccessRestrictNullSessAccess

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.10 (L1) Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Ena... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessRestrictNullSessAccess {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RestrictNullSessAccess"
        $RecommendationNumber = '2.3.10.10'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        [bool]$Setting = [int]$Entry.SettingNumber
        if ($Entry.KeyName) {
            $Pass = $Setting
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.11 (L1) Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow' (MS only)

.DESCRIPTION
This policy setting allows you to restrict remote RPC connections to SAM.

.EXAMPLE
Test-NetworkAccessRestrictRemoteSAM

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.10 (L1) Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Ad... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessRestrictRemoteSAM {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictRemoteSAM"
        $RecommendationNumber = '2.3.10.11'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow' (MS only)"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $Setting = $Entry.SettingString
        $Definition = "O:BAG:BAD:(A;;RC;;;BA)"
        if ($Setting -eq $Definition) {
            $Pass = $true
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.12 (L1) Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'

.DESCRIPTION
This policy setting determines which network shares can be accessed by anonymous users. The default configuration for this policy setting has little effect because all users have to be authenticated before they can access shared resources on the server.

.EXAMPLE
Test-NetworkAccessNullSessionShares

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.12 (L1) Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'              Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessNullSessionShares {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionShares"
        $RecommendationNumber = '2.3.10.12'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'$cisb"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $setting = $Entry.SettingStrings.Value
        if ($Entry.KeyName) {
            $Pass = -not($setting)
        } else {
            $Pass = $false
        }
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}

<#
.SYNOPSIS
2.3.10.13 (L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'

.DESCRIPTION
This policy setting determines how network logons that use local accounts are authenticated.

.EXAMPLE
Test-NetworkAccessForceGuest

Number    Name                                                                                                Source                    Pass    
--------- ------------------                                                                                  ------                    ----    
2.3.10.13 (L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic -... Group Policy Settings     True    

.NOTES
General notes
#>
function Test-NetworkAccessForceGuest {
    [CmdletBinding()]
    param ()

    begin {
        $Return = @()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\ForceGuest"
        $RecommendationNumber = '2.3.10.13'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'"
        $Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName"
    }

    process {
        $Setting = [int]$Entry.SettingNumber
        if ($Entry) {
            if ($Setting -eq 0) {
                $Pass = $true
            } else {
                $Pass = $false
            }
        } else {
            $Pass = $false
        }
        
    }

    end {
        $Properties = [PSCustomObject]@{
            'Number' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'Name'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass
            'Setting' = $Setting
            'Entry' = $Entry
        }
        $Properties.PSTypeNames.Add('psCISBenchmark')
        $Return += $Properties

        Return $Return
    }
}
