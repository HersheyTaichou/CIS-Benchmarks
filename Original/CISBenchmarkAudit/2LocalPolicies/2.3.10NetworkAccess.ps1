<#
.SYNOPSIS
2.3.10.1 (L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether an anonymous user can request security identifier (SID) attributes for another user, or use a SID to obtain its corresponding user name.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessLSAAnonymousNameLookup

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.1   L1    Ensure 'Network access: Allow anonymous SID/Name translation... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessLSAAnonymousNameLookup {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "LSAAnonymousNameLookup"
        $Result.Number = '2.3.10.1'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "SystemAccessPolicyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.2 (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled' (MS only)

.DESCRIPTION
This policy setting controls the ability of anonymous users to enumerate the accounts in the Security Accounts Manager (SAM).

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessRestrictAnonymousSAM

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.2   L1    Ensure 'Network access: Do not allow anonymous enumeration o... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessRestrictAnonymousSAM {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM"
        $Result.Number = '2.3.10.2'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.3 (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled' (MS only)

.DESCRIPTION
This policy setting controls the ability of anonymous users to enumerate SAM accounts as well as shares.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessRestrictAnonymous

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.3   L1    Ensure 'Network access: Do not allow anonymous enumeration o... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessRestrictAnonymous {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymous"
        $Result.Number = '2.3.10.3'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.4 (L2) Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether Credential Manager (formerly called Stored User Names and Passwords) saves passwords or credentials for later use when it gains domain authentication.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessDisableDomainCreds

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.4   L2    Ensure 'Network access: Do not allow storage of passwords an... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessDisableDomainCreds {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\DisableDomainCreds"
        $Result.Number = '2.3.10.4'
        $Result.Level = "L2"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.5 (L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'

.DESCRIPTION
This policy setting determines what additional permissions are assigned for anonymous connections to the computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessEveryoneIncludesAnonymous

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.5   L1    Ensure 'Network access: Let Everyone permissions apply to an... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessEveryoneIncludesAnonymous {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\EveryoneIncludesAnonymous"
        $Result.Number = '2.3.10.5'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

# 2.3.10.6 and 2.3.10.7
<#
.SYNOPSIS
2.3.10.6 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)
2.3.10.7 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only)

.DESCRIPTION
This policy setting determines which communication sessions, or pipes, will have attributes and permissions that allow anonymous access.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessNullSessionPipes

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.6   L1    Configure 'Network access: Named Pipes that can be accessed ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessNullSessionPipes {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes"
        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
        $Result.Source = 'Group Policy Settings'
    }

    process {
        $Result.Setting = @()
        $Result.Entry.SettingStrings.Value | ForEach-Object {$Result.Setting += $_}
        if (-not($Result.Setting)) {
            $Result.Setting = @("")
        }
        $DomainController = @("LSARPC","NETLOGON","SAMR")
        $DCBrowser = @("LSARPC", "NETLOGON", "SAMR","BROWSER")
        $MemberServer = @('')
        $MSBrowser = @("BROWSER")
        $MSRDS = @("HydraLSPipe","TermServLicensing")
        $MSRDSBrowser = @("HydraLSPipe","TermServLicensing","BROWSER")

        if ($ProductType.Number -eq 2) {
            $Result.Number = '2.3.10.6'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)"
            if ($Result.Entry) {
                if (-not(Compare-Object -ReferenceObject $DomainController -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $DCBrowser -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
            } else {
                $Result.SetCorrectly = $false
            }
        } elseif ($ProductType.Number -eq 3) {
            $Result.Number = '2.3.10.7'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only)"
            if ($Result.Entry) {
                if (-not(Compare-Object -ReferenceObject $MemberServer -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSBrowser -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSRDS -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSRDSBrowser -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
            } else {
                $Result.SetCorrectly = $false
            }
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.8 (L1) Configure 'Network access: Remotely accessible registry paths' is configured

.DESCRIPTION
This policy setting determines which registry paths will be accessible over the network, regardless of the users or groups listed in the access control list (ACL) of the winreg registry key.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessAllowedExactPaths

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.8   L1    Configure 'Network access: Remotely accessible registry path... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessAllowedExactPaths {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths\Machine"
        $Result.Number = '2.3.10.8'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Configure 'Network access: Remotely accessible registry paths' is configured"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.SettingStrings.Value
        $Definition = @('System\CurrentControlSet\Control\ProductOptions','System\CurrentControlSet\Control\Server Applications','Software\Microsoft\Windows NT\CurrentVersion')
        if ($Result.Entry) {
            if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } else {
                $Result.SetCorrectly = $false
            }
        } else  {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.9 (L1) Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured

.DESCRIPTION
This policy setting determines which registry paths and sub-paths will be accessible over the network, regardless of the users or groups listed in the access control list (ACL) of the winreg registry key.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessAllowedPaths

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.9   L1    Configure 'Network access: Remotely accessible registry path... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessAllowedPaths {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths\Machine"
        $Result.Number = '2.3.10.9'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Configure 'Network access: Remotely accessible registry paths and sub-paths' is configured"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.SettingStrings.Value
        $definition = @('System\CurrentControlSet\Control\Print\Printers','System\CurrentControlSet\Services\Eventlog','Software\Microsoft\OLAP Server','Software\Microsoft\Windows NT\CurrentVersion\Print','Software\Microsoft\Windows NT\CurrentVersion\Windows','System\CurrentControlSet\Control\ContentIndex','System\CurrentControlSet\Control\Terminal Server','System\CurrentControlSet\Control\Terminal Server\UserConfig','System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration','Software\Microsoft\Windows NT\CurrentVersion\Perflib','System\CurrentControlSet\Services\SysmonLog')
        $ADCS = $definition + 'System\CurrentControlSet\Services\CertSvc'
        $WINS = $definition + 'System\CurrentControlSet\Services\WINS'
        $ADCSWins = $ADCS + 'System\CurrentControlSet\Services\WINS'

        if ($Result.Entry) {
            if (-not(Compare-Object -ReferenceObject $definition -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $ADCS -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $WINS -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $ADCSWins -DifferenceObject $Result.Setting)) {
                $Result.SetCorrectly = $true
            } else {
                $Result.SetCorrectly = $false
            }
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.10 (L1) Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'

.DESCRIPTION
When enabled, this policy setting restricts anonymous access to only those shares and pipes that are named in the "Network access: Named pipes that can be accessed anonymously" and "Network access: Shares that can be accessed anonymously" settings.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessRestrictNullSessAccess

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.10  L1    Ensure 'Network access: Restrict anonymous access to Named P... Group Policy Settings     True        


.NOTES
General notes
#>
function Test-NetworkAccessRestrictNullSessAccess {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RestrictNullSessAccess"
        $Result.Number = '2.3.10.10'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = $Result.Setting
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.11 (L1) Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow' (MS only)

.DESCRIPTION
This policy setting allows you to restrict remote RPC connections to SAM.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessRestrictRemoteSAM

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.11  L1    Ensure 'Network access: Restrict clients allowed to make rem... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessRestrictRemoteSAM {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictRemoteSAM"
        $Result.Number = '2.3.10.11'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.SettingString
        $Definition = "O:BAG:BAD:(A;;RC;;;BA)"
        if ($Result.Setting -eq $Definition) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.12 (L1) Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'

.DESCRIPTION
This policy setting determines which network shares can be accessed by anonymous users. The default configuration for this policy setting has little effect because all users have to be authenticated before they can access shared resources on the server.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessNullSessionShares

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.12  L1    Ensure 'Network access: Shares that can be accessed anonymou... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessNullSessionShares {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionShares"
        $Result.Number = '2.3.10.12'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'$cisb"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.SettingStrings.Value
        if ($Result.Entry.KeyName) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.3.10.13 (L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'

.DESCRIPTION
This policy setting determines how network logons that use local accounts are authenticated.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessForceGuest

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.13  L1    Ensure 'Network access: Sharing and security model for local... Group Policy Settings     True        


.NOTES
General notes
#>
function Test-NetworkAccessForceGuest {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\ForceGuest"
        $Result.Number = '2.3.10.13'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry) {
            if ($Result.Setting -eq 0) {
                $Result.SetCorrectly = $true
            } else {
                $Result.SetCorrectly = $false
            }
        } else {
            $Result.SetCorrectly = $false
        }
        
    }

    end {
        return $Result
    }
}
