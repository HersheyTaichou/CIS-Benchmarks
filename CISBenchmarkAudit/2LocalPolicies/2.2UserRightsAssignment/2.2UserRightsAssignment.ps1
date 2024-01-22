<#
.SYNOPSIS
The base function for all the tests under 2.2 User Rights Assignment

.DESCRIPTION
This function provides the base test for all the CIS Benchmarks under 2.2. It will take the setting to check and what the setting should be, then compare the current setting to the benchmark and return true/false and the current setting

.PARAMETER EntryName
This is the setting that should be evaluated, the name must be as it shows up in the GPResult XML file

.PARAMETER Definition
This is the CIS Benchmark definition for this setting

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignment -EntryName "SeMachineAccountPrivilege" -Definition @('Administrator')

SetCorrectly: True
Setting: Administrator

.NOTES
This is an internal only function, and should not be exported.
#>
function Test-UserRightsAssignment {
    [CmdletBinding()]
    param (
        # The name of the setting to check
        [Parameter(Mandatory)][string]$EntryName,
        # The CIS Benchmark definition
        [Parameter(Mandatory)][array]$Definition,
        [Parameter()][array]$OptionalDef,
        [Parameter()][switch]$Include,
        [Parameter()][xml]$GPResult
    )

    $Result = @()

    # Check the current value of the setting
    $Setting = @()
    $GPOEntry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    $GPOEntry.Member | ForEach-Object {$Setting += $_.Name.'#text'}

    if (-not($Setting)) {
        $Setting = @("")
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($GPOEntry) {
        if ($Include) {
            $Count = 0
            foreach ($item in $Setting) {
                if ($item -in $Definition) {
                    $count ++
                }
            }
            if ($Definition.count -eq $Count) {
                $SetCorrectly = $true
            } else {
                $SetCorrectly = $false
            }
        } else {
            if ($OptionalDef) {
                $OptionalDef += $Definition
            } else {
                $OptionalDef = @("")
            }
            if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $Setting)) {
                $SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $OptionalDef -DifferenceObject $Setting)) {
                $SetCorrectly = $true
            } else {
                $SetCorrectly = $false
            }
        }
    } else {
        $SetCorrectly = $false
    }

    $Result = [PSCustomObject]@{
        'SetCorrectly'= $SetCorrectly
        'Setting' = $Setting -join ", "
        'Entry' = $GPOEntry
    }
    return $Result
}

<#
.SYNOPSIS
2.2.1 Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'

.DESCRIPTION
This security setting is used by Credential Manager during Backup and Restore. No accounts should have this user right, as it is only assigned to Winlogon. Users' saved credentials might be compromised if this user right is assigned to other entities.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.1      L1    Ensure 'Access Credential Manager as a trusted caller' is se... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()
        $Result.Number = '2.2.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
        $Result.Source = 'Group Policy Settings'

        $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeTrustedCredManAccessPrivilege" -Definition @("")  -gpresult $GPResult
    }

    process {
        $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
        $Result.Setting = $UserRightsAssignment.Setting
        $Result.Entry = $UserRightsAssignment.Entry
    }
    
    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.2 Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)
2.2.3 Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)

.DESCRIPTION
This policy setting allows other users on the network to connect to the computer and is required by various network protocols that include Server Message Block (SMB)-based protocols, NetBIOS, Common Internet File System (CIFS), and Component Object Model Plus (COM+).

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeNetworkLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.2      L1    Ensure 'Access this computer from the network' is set to 'Ad... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeNetworkLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators','Authenticated Users','ENTERPRISE DOMAIN CONTROLLERS')
        $MemberServer = @('Administrators','Authenticated Users')
    }

    process {
        if ($ProductType -eq 2) {
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $DomainController -gpresult $GPResult
            $Result.Number = '2.2.2'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $MemberServer -gpresult $GPResult
            $Result.Number = '2.2.3'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.4 Ensure 'Act as part of the operating system' is set to 'No One'

.DESCRIPTION
This policy setting allows a process to assume the identity of any user and thus gain access to the resources that the user is authorized to access.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeTcbPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.4      L1    Ensure 'Act as part of the operating system' is set to 'No One' Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTcbPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()
        $Result.Number = '2.2.4'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Act as part of the operating system' is set to 'No One'"
        $Result.Source = 'Group Policy Settings'

        $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeTcbPrivilege" -Definition @("") -gpresult $GPResult
    }
    process {
        $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
        $Result.Setting = $UserRightsAssignment.Setting
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.5 Ensure 'Add workstations to domain' is set to 'Administrators' (DC only)

.DESCRIPTION
This policy setting specifies which users can add computer workstations to the domain. For this policy setting to take effect, it must be assigned to the user as part of the Default Domain Controller Policy for the domain. A user who has been assigned this right can add up to 10 workstations to the domain. Users who have been assigned the Create Computer Objects permission for an OU or the Computers container in Active Directory can add an unlimited number of computers to the domain, regardless of whether or not they have been assigned the Add workstations to domain user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeMachineAccountPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.5      L1    Ensure 'Add workstations to domain' is set to 'Administrator... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeMachineAccountPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.5'
    $Result.Level = "L1"
        $Result.Profile = "Domain Controller"
    $Result.Title = "Ensure 'Add workstations to domain' is set to 'Administrators' (DC only)"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeMachineAccountPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting

    return $Result
}

<#
.SYNOPSIS
2.2.6 Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'

.DESCRIPTION
This policy setting allows a user to adjust the maximum amount of memory that is available to a process. The ability to adjust memory quotas is useful for system tuning, but it can be abused. In the wrong hands, it could be used to launch a denial of service (DoS) attack.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeIncreaseQuotaPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.6      L1    Ensure 'Adjust memory quotas for a process' is set to 'Admin... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeIncreaseQuotaPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.6'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeIncreaseQuotaPrivilege" -Definition @('Administrators','LOCAL SERVICE','NETWORK SERVICE') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting

    return $Result
}

<#
.SYNOPSIS
2.2.7 Ensure 'Allow log on locally' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users can interactively log on to computers in your environment. Logons that are initiated by pressing the CTRL+ALT+DEL key sequence on the client computer keyboard require this user right. Users who attempt to log on through Terminal Services / Remote Desktop Services or IIS also require this user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeInteractiveLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.7      L1    Ensure 'Allow log on locally' is set to 'Administrators'        Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeInteractiveLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.7'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Allow log on locally' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeInteractiveLogonRight" -Definition @('Administrators') -OptionalDef @('Backup Operators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting

    return $Result
}

<#
.SYNOPSIS
2.2.8 Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators' (DC only)
2.2.9 Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only)

.DESCRIPTION
This policy setting determines which users or groups have the right to log on as a Remote Desktop Services client. If your organization uses Remote Assistance as part of its help desk strategy, create a group and assign it this user right through Group Policy. If the help desk in your organization does not use Remote Assistance, assign this user right only to the Administrators group or use the Restricted Groups feature to ensure that no user accounts are part of the Remote Desktop Users group.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeRemoteInteractiveLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.8      L1    Ensure 'Allow log on through Remote Desktop Services' is set... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRemoteInteractiveLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators')
        $MemberServer = @('Administrators')
        $MSOptional = @('Remote Desktop Users')
    }

    process {
        if ($ProductType -eq 2) {
            $Result = [CISBenchmark]::new()
            $Result.Number = "2.2.8"
            $Result.Level = "L1"
            if ($ProductType -eq 1) {
                $Result.Profile = "Corporate/Enterprise Environment"
            } elseif ($ProductType -eq 2) {
                $Result.Profile = "Domain Controller"
            } elseif ($ProductType -eq 3) {
                $Result.Profile = "Member Server"
            }
            $Result.Title = "Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators' (DC only)"
            $Result.Source = "Group Policy Settings"
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRemoteInteractiveLogonRight" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $Result.Number = '2.2.9'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRemoteInteractiveLogonRight" -Definition $MemberServer -OptionalDef $MSOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
            }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.10 Ensure 'Back up files and directories' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to circumvent file and directory permissions to back up the system. This user right is enabled only when an application (such as NTBACKUP) attempts to access a file or directory through the NTFS file system backup application programming interface (API). Otherwise, the assigned file and directory permissions apply.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeBackupPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.10     L1    Ensure 'Allow log on locally' is set to 'Administrators'        Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeBackupPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.10'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Allow log on locally' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeBackupPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.11 Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE'

.DESCRIPTION
This policy setting determines which users and groups can change the time and date on the internal clock of the computers in your environment. Users who are assigned this user right can affect the appearance of event logs. When a computer's time setting is changed, logged events reflect the new time, not the actual time that the events occurred.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeSystemTimePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.11     L1    Ensure 'Change the system time' is set to 'Administrators, L... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSystemTimePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.11'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSystemTimePrivilege" -Definition @('Administrators','LOCAL SERVICE') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.12 Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE'

.DESCRIPTION
This setting determines which users can change the time zone of the computer. This ability holds no great danger for the computer and may be useful for mobile workers.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeTimeZonePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.12     L1    Ensure 'Change the time zone' is set to 'Administrators, LOC... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTimeZonePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.12'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeTimeZonePrivilege" -Definition @('Administrators','LOCAL SERVICE') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.13 Ensure 'Create a pagefile' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to change the size of the pagefile. By making the pagefile extremely large or extremely small, an attacker could easily affect the performance of a compromised computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeCreatePagefilePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.13     L1    Ensure 'Create a pagefile' is set to 'Administrators'           Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreatePagefilePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.13'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Create a pagefile' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreatePagefilePrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.14 Ensure 'Create a token object' is set to 'No One'

.DESCRIPTION
This policy setting allows a process to create an access token, which may provide elevated rights to access sensitive data.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeCreateTokenPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.14     L1    Ensure 'Create a token object' is set to 'No One'               Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreateTokenPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.14'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Create a token object' is set to 'No One'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreateTokenPrivilege" -Definition @("") -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.15 Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'

.DESCRIPTION
This policy setting determines whether users can create global objects that are available to all sessions. Users can still create objects that are specific to their own session if they do not have this user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeCreateGlobalPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.15     L1    Ensure 'Create global objects' is set to 'Administrators, LO... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreateGlobalPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.15'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreateGlobalPrivilege" -Definition @('Administrators','LOCAL SERVICE','NETWORK SERVICE','SERVICE') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.16 Ensure 'Create permanent shared objects' is set to 'No One'

.DESCRIPTION
This user right is useful to kernel-mode components that extend the object namespace. However, components that run in kernel mode have this user right inherently. Therefore, it is typically not necessary to specifically assign this user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeCreatePermanentPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.16     L1    Ensure 'Create permanent shared objects' is set to 'No One'     Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreatePermanentPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.16'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Create permanent shared objects' is set to 'No One'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreatePermanentPrivilege" -Definition @("") -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.17 Ensure 'Create symbolic links' is set to 'Administrators' (DC only)
2.2.18 Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only)

.DESCRIPTION
This policy setting determines which users can create symbolic links. In Windows Vista, existing NTFS file system objects, such as files and folders, can be accessed by referring to a new kind of file system object called a symbolic link. A symbolic link is a pointer (much like a shortcut or .lnk file) to another file system object, which can be a file, folder, shortcut or another symbolic link. The difference between a shortcut and a symbolic link is that a shortcut only works from within the Windows shell. To other programs and applications, shortcuts are just another file, whereas with symbolic links, the concept of a shortcut is implemented as a feature of the NTFS file system.

The recommended state for this setting is: Administrators and (when the Hyper-V Role is installed) NT VIRTUAL MACHINE\Virtual Machines.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.17     L1    Ensure 'Create symbolic links' is set to 'Administrators' (D... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators')
        $MemberServer = @('Administrators')
        $MSOptional = @('NT VIRTUAL MACHINE\Virtual Machines')
    }

    process {
        if ($ProductType -eq 2) {
            $Result = [CISBenchmark]::new()
            $Result.Number = "2.2.17"
            $Result.Level = "L1"
            if ($ProductType -eq 1) {
                $Result.Profile = "Corporate/Enterprise Environment"
            } elseif ($ProductType -eq 2) {
                $Result.Profile = "Domain Controller"
            } elseif ($ProductType -eq 3) {
                $Result.Profile = "Member Server"
            }
            $Result.Title = "Ensure 'Create symbolic links' is set to 'Administrators' (DC only)"
            $Result.Source = "Group Policy Settings"
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreateSymbolicLinkPrivilege" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $Result.Number = '2.2.18'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreateSymbolicLinkPrivilege" -Definition $MemberServer -OptionalDef $MSOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }

    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.19 Ensure 'Debug programs' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which user accounts will have the right to attach a debugger to any process or to the kernel, which provides complete access to sensitive and critical operating system components. Developers who are debugging their own applications do not need to be assigned this user right; however, developers who are debugging new system components will need it.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDebugPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.19     L1    Ensure 'Debug programs' is set to 'Administrators'              Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDebugPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.19'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Debug programs' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDebugPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.20 Ensure 'Deny access to this computer from the network' to include 'Guests' (DC only)
2.2.21 Ensure 'Deny access to this computer from the network' to include 'Guests, Local account and member of Administrators group' (MS only)

.DESCRIPTION
This policy setting prohibits users from connecting to a computer from across the network, which would allow users to access and potentially modify data remotely. In high security environments, there should be no need for remote users to access data on a computer. Instead, file sharing should be accomplished through the use of network servers. This user right supersedes the "Access this computer from the network" user right if an account is subject to both policies.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyNetworkLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.20     L1    Ensure 'Deny access to this computer from the network' to in... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyNetworkLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Guests')
        $MemberServer = @('Guests','Local account and member of Administrators group')
    }

    process {
        if ($ProductType -eq 2) {
            $Result.Number = '2.2.20'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Deny access to this computer from the network' to include 'Guests' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyNetworkLogonRight" -Definition $DomainController -Include -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $Result.Number = '2.2.21'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Deny access to this computer from the network' to include 'Guests, Local account and member of Administrators group' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyNetworkLogonRight" -Definition $MemberServer -Include -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.22 Ensure 'Deny log on as a batch job' to include 'Guests'

.DESCRIPTION
This policy setting determines which accounts will not be able to log on to the computer as a batch job. A batch job is not a batch (.bat) file, but rather a batch-queue facility. Accounts that use the Task Scheduler to schedule jobs need this user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyBatchLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.22     L1    Ensure 'Deny log on as a batch job' to include 'Guests'         Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyBatchLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
        $Result = [CISBenchmark]::new()
        $Result.Number = "2.2.22"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Deny log on as a batch job' to include 'Guests'"
		$Result.Source = "Group Policy Settings"

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyBatchLogonRight" -Definition @('Guests') -Include -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.23 Ensure 'Deny log on as a service' to include 'Guests'

.DESCRIPTION
This security setting determines which service accounts are prevented from registering a process as a service. This user right supersedes the "Log on as a service" user right if an account is subject to both policies.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyServiceLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.23     L1    Ensure 'Deny log on as a service' to include 'Guests'           Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyServiceLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
        $Result = [CISBenchmark]::new()
        $Result.Number = "2.2.23"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Deny log on as a service' to include 'Guests'"
		$Result.Source = "Group Policy Settings"

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyServiceLogonRight" -Definition @('Guests') -Include -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.24 Ensure 'Deny log on locally' to include 'Guests'

.DESCRIPTION
This security setting determines which users are prevented from logging on at the computer. This policy setting supersedes the "Allow log on locally" policy setting if an account is subject to both policies.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyInteractiveLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.24     L1    Ensure 'Deny log on locally' to include 'Guests'                Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyInteractiveLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
        $Result = [CISBenchmark]::new()
        $Result.Number = "2.2.24"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Deny log on locally' to include 'Guests'"
		$Result.Source = "Group Policy Settings"

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyInteractiveLogonRight" -Definition @('Guests') -Include -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.25 Ensure 'Deny log on through Remote Desktop Services' to include 'Guests' (DC only)
2.2.26 Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests, Local account' (MS only)

.DESCRIPTION
This policy setting determines whether users can log on as Remote Desktop clients. After the baseline Member Server is joined to a domain environment, there is no need to use local accounts to access the server from the network. Domain accounts can access the server for administration and end-user processing. This user right supersedes the "Allow log on through Remote Desktop Services" user right if an account is subject to both policies.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.25     L1    Ensure 'Deny log on through Remote Desktop Services' to incl... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Guests')
        $MemberServer = @('Guests','Local account')
    }

    process {
        if ($ProductType -eq 2) {
            $Result = [CISBenchmark]::new()
            $Result.Number = "2.2.25"
            $Result.Level = "L1"
            if ($ProductType -eq 1) {
                $Result.Profile = "Corporate/Enterprise Environment"
            } elseif ($ProductType -eq 2) {
                $Result.Profile = "Domain Controller"
            } elseif ($ProductType -eq 3) {
                $Result.Profile = "Member Server"
            }
            $Result.Title = "Ensure 'Deny log on through Remote Desktop Services' to include 'Guests' (DC only)"
            $Result.Source = "Group Policy Settings"
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyRemoteInteractiveLogonRight" -Definition $DomainController -Include -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $Result.Number = '2.2.26'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests, Local account' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyRemoteInteractiveLogonRight" -Definition $MemberServer -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.27 Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'Administrators' (DC only)
2.2.28 Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only)

.DESCRIPTION
This policy setting allows users to change the Trusted for Delegation setting on a computer object in Active Directory. Abuse of this privilege could allow unauthorized users to impersonate other users on the network.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeEnableDelegationPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.27     L1    Ensure 'Enable computer and user accounts to be trusted for ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeEnableDelegationPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators')
        $MemberServer = @("")
    }

    process {
        if ($ProductType -eq 2) {
            $Result.Number = '2.2.27'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'Administrators' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeEnableDelegationPrivilege" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $Result.Number = '2.2.28'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeEnableDelegationPrivilege" -Definition $MemberServer -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.29 Ensure 'Force shutdown from a remote system' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to shut down Windows Vista-based or newer computers from remote locations on the network. Anyone who has been assigned this user right can cause a denial of service (DoS) condition, which would make the computer unavailable to service user requests. Therefore, it is recommended that only highly trusted administrators be assigned this user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeRemoteShutdownPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.29     L1    Ensure 'Force shutdown from a remote system' is set to 'Admi... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRemoteShutdownPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
        $Result = [CISBenchmark]::new()
        $Result.Number = "2.2.29"
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Force shutdown from a remote system' is set to 'Administrators'"
		$Result.Source = "Group Policy Settings"

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRemoteShutdownPrivilege" -Definition @('Administrators') -gpresult $GPResult

    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.30 Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'

.DESCRIPTION
This policy setting determines which users or processes can generate audit records in the Security log.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeAuditPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.30     L1    Ensure 'Generate security audits' is set to 'LOCAL SERVICE, ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeAuditPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
        $Result.Number = '2.2.30'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
        $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeAuditPrivilege" -Definition @('LOCAL SERVICE', 'NETWORK SERVICE') -gpresult $GPResult

    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.31 Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (DC only)
2.2.32 Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only)

.DESCRIPTION
The policy setting allows programs that run on behalf of a user to impersonate that user (or another specified account) so that they can act on behalf of the user. If this user right is required for this kind of impersonation, an unauthorized user will not be able to convince a client to connect—for example, by remote procedure call (RPC) or named pipes—to a service that they have created to impersonate that client, which could elevate the unauthorized user's permissions to administrative or system levels.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeImpersonatePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.31     L1    Ensure 'Impersonate a client after authentication' is set to... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeImpersonatePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE', 'SERVICE')
        $MemberServer = @('Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE', 'SERVICE')
        $MSOptional = @('IIS_IUSRS')
    }

    process {
        if ($ProductType -eq 2) {
            $Result.Number = '2.2.31'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeImpersonatePrivilege" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $Result.Number = '2.2.32'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeImpersonatePrivilege" -Definition $MemberServer -OptionalDef $MSOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.33 Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group'

.DESCRIPTION
This policy setting determines whether users can increase the base priority class of a process. (It is not a privileged operation to increase relative priority within a priority class.) This user right is not required by administrative tools that are supplied with the operating system but might be required by software development tools.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.33     L1    Ensure 'Increase scheduling priority' is set to 'Administrat... Group Policy Settings     True        

.NOTES
The benchmark specifies 'Administrators' and 'Window Manager\Window Manager Group' for 2019 and newer, but on a fresh install of Server 2022 promoted to a DC, 'Window Manager\Window Manager Group' does not come up in any searches. It was moved to be considered optional by the script.
#>
function Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.33'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeIncreaseBasePriorityPrivilege" -Definition @('Administrators') -OptionalDef @('Window Manager\Window Manager Group') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.34 Ensure 'Load and unload device drivers' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to dynamically load a new device driver on a system. An attacker could potentially use this capability to install malicious code that appears to be a device driver. This user right is required for users to add local printers or printer drivers in Windows Vista.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeLoadDriverPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.34     L1    Ensure 'Load and unload device drivers' is set to 'Administr... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeLoadDriverPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.34'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Load and unload device drivers' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeLoadDriverPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.35 Ensure 'Lock pages in memory' is set to 'No One'

.DESCRIPTION
This policy setting allows a process to keep data in physical memory, which prevents the system from paging the data to virtual memory on disk. If this user right is assigned, significant degradation of system performance can occur.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeLockMemoryPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.35     L1    Ensure 'Lock pages in memory' is set to 'No One'                Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeLockMemoryPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.35'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Lock pages in memory' is set to 'No One'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeLockMemoryPrivilege" -Definition @('') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.36 Ensure 'Log on as a batch job' is set to 'Administrators' (DC Only)

.DESCRIPTION
This policy setting allows accounts to log on using the task scheduler service. Because the task scheduler is often used for administrative purposes, it may be needed in enterprise environments. However, its use should be restricted in high security environments to prevent misuse of system resources or to prevent attackers from using the right to launch malicious code after gaining user level access to a computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeBatchLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.36     L2    Ensure 'Log on as a batch job' is set to 'Administrators' (D... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeBatchLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.36'
    $Result.Level = "L2"
    $Result.Profile = "Domain Controller"
    $Result.Title = "Ensure 'Log on as a batch job' is set to 'Administrators' (DC Only)"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeBatchLogonRight" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.37 Ensure 'Manage auditing and security log' is set to 'Administrators' and (when Exchange is running in the environment) 'Exchange Servers' (DC only)
2.2.38 Ensure 'Manage auditing and security log' is set to 'Administrators' (MS only)

.DESCRIPTION
This policy setting determines which users can change the auditing options for files and directories and clear the Security log.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeSecurityPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.37     L1    Ensure 'Manage auditing and security log' is set to 'Adminis... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSecurityPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators')
        $DCOptional = @('Exchange Servers')
        $MemberServer = @('Administrators')
    }

    process {
        if ($ProductType -eq 2) {
            $Result.Number = '2.2.37'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Manage auditing and security log' is set to 'Administrators' and (when Exchange is running in the environment) 'Exchange Servers' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSecurityPrivilege" -Definition $DomainController -OptionalDef $DCOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType -eq 3) {
            $Result.Number = '2.2.38'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Manage auditing and security log' is set to 'Administrators' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSecurityPrivilege" -Definition $MemberServer -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}

<#
.SYNOPSIS
2.2.39 Ensure 'Modify an object label' is set to 'No One'

.DESCRIPTION
This privilege determines which user accounts can modify the integrity label of objects, such as files, registry keys, or processes owned by other users. Processes running under a user account can modify the label of an object owned by that user to a lower level without this privilege.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeRelabelPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.39     L1    Ensure 'Modify an object label' is set to 'No One'              Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRelabelPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.39'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Modify an object label' is set to 'No One'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRelabelPrivilege" -Definition @('') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.40 Ensure 'Modify firmware environment values' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to configure the system-wide environment variables that affect hardware configuration. This information is typically stored in the Last Known Good Configuration. Modification of these values and could lead to a hardware failure that would result in a denial of service condition.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeSystemEnvironmentPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.40     L1    Ensure 'Modify firmware environment values' is set to 'Admin... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSystemEnvironmentPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.40'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Modify firmware environment values' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSystemEnvironmentPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.41 Ensure 'Perform volume maintenance tasks' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to manage the system's volume or disk configuration, which could allow a user to delete a volume and cause data loss as well as a denial-of-service condition.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeManageVolumePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.41     L1    Ensure 'Perform volume maintenance tasks' is set to 'Adminis... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeManageVolumePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.41'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Perform volume maintenance tasks' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeManageVolumePrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.42 Ensure 'Profile single process' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users can use tools to monitor the performance of non-system processes. Typically, you do not need to configure this user right to use the Microsoft Management Console (MMC) Performance snap-in. However, you do need this user right if System Monitor is configured to collect data using Windows Management Instrumentation (WMI). Restricting the Profile single process user right prevents intruders from gaining additional information that could be used to mount an attack on the system.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeProfileSingleProcessPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.42     L1    Ensure 'Profile single process' is set to 'Administrators'      Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeProfileSingleProcessPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.42'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Profile single process' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeProfileSingleProcessPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.43 Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost'

.DESCRIPTION
This policy setting allows users to use tools to view the performance of different system processes, which could be abused to allow attackers to determine a system's active processes and provide insight into the potential attack surface of the computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeSystemProfilePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.43     L1    Ensure 'Profile system performance' is set to 'Administrator... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSystemProfilePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.43'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSystemProfilePrivilege" -Definition @('Administrators', 'NT SERVICE\WdiServiceHost') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.44 Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'

.DESCRIPTION
This policy setting allows one process or service to start another service or process with a different security access token, which can be used to modify the security access token of that sub-process and result in the escalation of privileges.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeAssignPrimaryTokenPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.44     L1    Ensure 'Replace a process level token' is set to 'LOCAL SERV... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeAssignPrimaryTokenPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.44'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeAssignPrimaryTokenPrivilege" -Definition @('LOCAL SERVICE', 'NETWORK SERVICE') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.45 Ensure 'Restore files and directories' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users can bypass file, directory, registry, and other persistent object permissions when restoring backed up files and directories on computers that run Windows Vista (or newer) in your environment. This user right also determines which users can set valid security principals as object owners; it is similar to the Back up files and directories user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeRestorePrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.45     L1    Ensure 'Restore files and directories' is set to 'Administra... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRestorePrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.45'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Restore files and directories' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRestorePrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.46 Ensure 'Shut down the system' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users who are logged on locally to the computers in your environment can shut down the operating system with the Shut Down command. Misuse of this user right can result in a denial of service condition.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeShutdownPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.46     L1    Ensure 'Shut down the system' is set to 'Administrators'        Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeShutdownPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.46'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Shut down the system' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeShutdownPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.47 Ensure 'Synchronize directory service data' is set to 'No One' (DC only)

.DESCRIPTION
This security setting determines which users and groups have the authority to synchronize all directory service data. This is also known as Active Directory synchronization.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeSyncAgentPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.47     L1    Ensure 'Synchronize directory service data' is set to 'No On... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSyncAgentPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.47'
    $Result.Level = "L1"
        $Result.Profile = "Domain Controller"
    $Result.Title = "Ensure 'Synchronize directory service data' is set to 'No One' (DC only)"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSyncAgentPrivilege" -Definition @('') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}

<#
.SYNOPSIS
2.2.48 Ensure 'Take ownership of files or other objects' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to take ownership of files, folders, registry keys, processes, or threads. This user right bypasses any permissions that are in place to protect objects to give ownership to the specified user.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeTakeOwnershipPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.48     L1    Ensure 'Take ownership of files or other objects' is set to ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTakeOwnershipPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.48'
    $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Take ownership of files or other objects' is set to 'Administrators'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeTakeOwnershipPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
