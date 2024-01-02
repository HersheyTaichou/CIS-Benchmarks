<#
.SYNOPSIS
18.3.1 (L1) Ensure LAPS AdmPwd GPO Extension / CSE is installed (MS only)

.DESCRIPTION

In May 2015, Microsoft released the Local Administrator Password Solution (LAPS) tool, which is free and supported software that allows an organization to automatically set randomized and unique local Administrator account passwords on domain-attached workstations and Member Servers. The passwords are stored in a confidential attribute of the domain computer account and can be retrieved from Active Directory by approved Sysadmins when needed.
The LAPS tool requires a small Active Directory Schema update in order to implement, as well as installation of a Group Policy Client Side Extension (CSE) on targeted computers. Please see the LAPS documentation for details.
LAPS supports Windows Vista or newer workstation OSes, and Server 2003 or newer server OSes. LAPS does not support standalone computers - they must be joined to a domain.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-LAPSLocalAdministratorPasswordSolution

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
This test may not return accurate results based on your setup. This test checks to see if the software is being installed via Group Policy with the name "Local Administrator Password Solution"
#>
function Test-LAPSLocalAdministratorPasswordSolution {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Local Administrator Password Solution"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.3.1'
        $Result.Level = "L1"
        $Result.Profile = "Member Server"
        $Result.Title = "Ensure LAPS AdmPwd GPO Extension / CSE is installed (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        If ($Result.Entry) {
            $Result.Setting = $Result.Entry.Path
            $Result.SetCorrectly = $Result.Entry.AutoInstall
        } else {
            $Warning = [string]$Result.Number + " - " + $Result.Title + "`nThis test may not return accurate results based on your setup. This test checks to see if the software is being installed via Group Policy with the name `"" + $EntryName + "`""
            Write-Warning -Message $Warning 
            $Result.Setting = ""
            $Result.SetCorrectly = $false
        }

    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
18.3.2 (L1) Ensure 'Do not allow password expiration time longer than required by policy' is set to 'Enabled' (MS only)

.DESCRIPTION


.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-LAPSDoNotAllowPasswordExpirationTimeLongerThanRequiredByPolicy {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Do not allow password expiration time longer than required by policy"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.3.2'
        $Result.Level = "L1"
        $Result.Profile = "Member Server"
        $Result.Title = "Ensure 'Do not allow password expiration time longer than required by policy' is set to 'Enabled' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Entry.State -eq "Enabled") {
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
18.3.3 (L1) Ensure 'Enable Local Admin Password Management' is set to 'Enabled' (MS only)

.DESCRIPTION


.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-LAPSEnableLocalAdminPasswordManagement {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Enable local admin password management"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.3.3'
        $Result.Level = "L1"
        $Result.Profile = "Member Server"
        $Result.Title = "Ensure 'Enable Local Admin Password Management' is set to 'Enabled' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Entry.State -eq "Enabled") {
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
18.3.4 (L1) Ensure 'Password Settings: Password Complexity' is set to 'Enabled: Large letters + small letters + numbers + special characters' (MS only)

.DESCRIPTION


.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-LAPSPasswordComplexity {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Password Settings"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.3.4'
        $Result.Level = "L1"
        $Result.Profile = "Member Server"
        $Result.Title = "Ensure 'Password Settings: Password Complexity' is set to 'Enabled: Large letters + small letters + numbers + special characters' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        $Result.Setting = $Result.Entry.DropDownList.State
        if ($Result.Setting -eq "Enabled") {
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
18.3.5 (L1) Ensure 'Password Settings: Password Length' is set to 'Enabled: 15 or more' (MS only)

.DESCRIPTION


.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-LAPSPasswordLength {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Password Settings"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.3.5'
        $Result.Level = "L1"
        $Result.Profile = "Member Server"
        $Result.Title = "Ensure 'Password Settings: Password Length' is set to 'Enabled: 15 or more' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        if ($Result.Entry) {
            $Result.Entry.Numeric | Where-Object {$_.Name -eq "Password Length"} | ForEach-Object {
                if ([int]$_.Value -ge 15 -and $_.State -eq "Enabled") {
                    $Result.Setting = 'Enabled: 15 or more'
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
            }
            if (($Result.Entry.Numeric | Where-Object {$_.Name -eq "Password Length"}).Count -eq 0) {
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
18.3.6 (L1) Ensure 'Password Settings: Password Age (Days)' is set to 'Enabled: 30 or fewer' (MS only)

.DESCRIPTION


.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-LAPSPasswordAge {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Password Settings"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.3.6'
        $Result.Level = "L1"
        $Result.Profile = "Member Server"
        $Result.Title = "Ensure 'Password Settings: Password Age (Days)' is set to 'Enabled: 30 or fewer' (MS only)"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        if ($Result.Entry) {
            $Result.Entry.Numeric | Where-Object {$_.Name -eq "Password Age (Days)"} | ForEach-Object {
                if ([int]$_.Value -le 30 -and $_.State -eq "Enabled") {
                    $Result.Setting = 'Enabled: 15 or more'
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
            }
            if (($Result.Entry.Numeric | Where-Object {$_.Name -eq "Password Age (Days)"}).Count -eq 0) {
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
