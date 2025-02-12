<#
.SYNOPSIS
2.3.6.1 (L1) Ensure 'Domain member: Digitally encrypt or sign secure channel data (always)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether all secure channel traffic that is initiated by the domain member must be signed or encrypted.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberRequireSignOrSeal

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.1    L1    Ensure 'Domain member: Digitally encrypt or sign secure chan... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberRequireSignOrSeal {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.SetCorrectly = [int]$Result.Entry.SettingNumber
    }

    end {
        $Result.Number = '2.3.6.1'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Domain member: Digitally encrypt or sign secure channel data (always)' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

<#
.SYNOPSIS
2.3.6.2 (L1) Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether a domain member should attempt to negotiate encryption for all secure channel traffic that it initiates.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberSealSecureChannel

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.2    L1    Ensure 'Domain member: Digitally encrypt secure channel data... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberSealSecureChannel {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\SealSecureChannel"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.SetCorrectly = [int]$Result.Entry.SettingNumber
    }

    end {
        $Result.Number = '2.3.6.2'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'
        return $Result
    }
}

<#
.SYNOPSIS
2.3.6.3 (L1) Ensure 'Domain member: Digitally sign secure channel data (when possible)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether a domain member should attempt to negotiate whether all secure channel traffic that it initiates must be digitally signed.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberSignSecureChannel

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.3    L1    Ensure 'Domain member: Digitally sign secure channel data (w... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberSignSecureChannel {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\SignSecureChannel"
        $Result.Number = '2.3.6.3'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Domain member: Digitally sign secure channel data (when possible)' is set to 'Enabled'"
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
2.3.6.4 (L1) Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled'

.DESCRIPTION
This policy setting determines whether a domain member can periodically change its computer account password.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberDisablePasswordChange

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.4    L1    Ensure 'Domain member: Disable machine account password chan... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberDisablePasswordChange {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\DisablePasswordChange"
        $Result.Number = '2.3.6.4'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled'"
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

<#
.SYNOPSIS
2.3.6.5 (L1) Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'

.DESCRIPTION
This policy setting determines the maximum allowable age for a computer account password.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberMaximumPasswordAge

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.5    L1    Ensure 'Domain member: Maximum machine account password age'... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberMaximumPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\MaximumPasswordAge"
        $Result.Number = '2.3.6.5'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if (($Result.Setting -le 30) -and ($Result.Setting -gt 0)) {
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
2.3.6.6 (L1) Ensure 'Domain member: Require strong (Windows 2000 or later) session key' is set to 'Enabled'

.DESCRIPTION
When this policy setting is enabled, a secure channel can only be established with Domain Controllers that are capable of encrypting secure channel data with a strong (128-bit) session key.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberRequireStrongKey

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.6    L1    Ensure 'Domain member: Require strong (Windows 2000 or later... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberRequireStrongKey {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireStrongKey"
        $Result.Number = '2.3.6.6'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Domain member: Require strong (Windows 2000 or later) session key' is set to 'Enabled'"
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
