<# Base
.SYNOPSIS
The base function for all the tests under 2.2

.DESCRIPTION
This function provides the base test for all the CIS Benchmarks under 2.2. 
It will take the setting to check and what the setting should be, then 
compare the current setting to the benchmark and return true/false and the
current setting

.PARAMETER EntryName
This is the setting that should be evaluated, the name must be as it shows 
up in the GPResult XML file

.PARAMETER Definition
This is the CIS Benchmark definition for this setting

.EXAMPLE
Test-UserRightsAssignment -EntryName "SeMachineAccountPrivilege" -Definition @('Administrator')

Result: True
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
        [Parameter()][array]$OptionalDef
    )

    $Return = @()

    # Check the current value of the setting
    $Setting = @()
    $Entry = Get-GPOEntry -EntryName $EntryName -KeyName "Name"
    $Entry.Member | ForEach-Object {$Setting += $_.Name.'#text'}

    if (-not($setting)) {
        $Setting = @("")
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($OptionalDef) {
        $OptionalDef += $Definition
    } else {
        $OptionalDef = @("")
    }

    if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $setting)) {
        $Pass = $true
    } elseif (-not(Compare-Object -ReferenceObject $OptionalDef -DifferenceObject $setting)) {
        $Pass = $true
    } else {
        $Pass = $false
    }

    $Return = [PSCustomObject]@{
        'Pass'= $Pass
        'Setting' = $Setting -join ", "
        'Entry' = $Entry
    }

    Return $Return
}

<# 2.2.1
.SYNOPSIS
2.2.1 Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'

.DESCRIPTION
This security setting is used by Credential Manager during Backup and Restore. No accounts should have this user right, as it is only assigned to Winlogon. Users' saved credentials might be compromised if this user right is assigned to other entities.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.1'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeTrustedCredManAccessPrivilege" -Definition @("")

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
        'Entry' = $Pass.Entry
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.2 and 2.2.3
.SYNOPSIS
2.2.2 Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)
2.2.3 Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)

.DESCRIPTION
This policy setting allows other users on the network to connect to the computer and is required by various network protocols that include Server Message Block (SMB)-based protocols, NetBIOS, Common Internet File System (CIFS), and Component Object Model Plus (COM+).

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeNetworkLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Administrators','Authenticated Users','ENTERPRISE DOMAIN CONTROLLERS')
    $MemberServer = @('Administrators','Authenticated Users')

    
    if ($ProductType -eq 2) {
        $Pass = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $DomainController
        $RecommendationNumber = '2.2.2'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $Pass = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $MemberServer
        $RecommendationNumber = '2.2.3'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.3'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.4
.SYNOPSIS
2.2.4 Ensure 'Act as part of the operating system' is set to 'No One'

.DESCRIPTION
This policy setting allows a process to assume the identity of any user and thus gain access to the resources that the user is authorized to access.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTcbPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.4'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Act as part of the operating system' is set to 'No One'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeTcbPrivilege" -Definition @("")

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.5
.SYNOPSIS
2.2.5 Ensure 'Add workstations to domain' is set to 'Administrators' (DC only)

.DESCRIPTION
This policy setting specifies which users can add computer workstations to the domain. For this policy setting to take effect, it must be assigned to the user as part of the Default Domain Controller Policy for the domain. A user who has been assigned this right can add up to 10 workstations to the domain. Users who have been assigned the Create Computer Objects permission for an OU or the Computers container in Active Directory can add an unlimited number of computers to the domain, regardless of whether or not they have been assigned the Add workstations to domain user right.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeMachineAccountPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.5'
    $ProfileApplicability = @("Level 1 - Domain Controller")
    $RecommendationName = "(L1) Ensure 'Add workstations to domain' is set to 'Administrators' (DC only)"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeMachineAccountPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.6
.SYNOPSIS
2.2.6 Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'

.DESCRIPTION
This policy setting allows a user to adjust the maximum amount of memory that is available to a process. The ability to adjust memory quotas is useful for system tuning, but it can be abused. In the wrong hands, it could be used to launch a denial of service (DoS) attack.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeIncreaseQuotaPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.6'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeIncreaseQuotaPrivilege" -Definition @('Administrators','LOCAL SERVICE','NETWORK SERVICE')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.7
.SYNOPSIS
2.2.7 Ensure 'Allow log on locally' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users can interactively log on to computers in your environment. Logons that are initiated by pressing the CTRL+ALT+DEL key sequence on the client computer keyboard require this user right. Users who attempt to log on through Terminal Services / Remote Desktop Services or IIS also require this user right.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeInteractiveLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.7'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Allow log on locally' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeInteractiveLogonRight" -Definition @('Administrators') -OptionalDef @('Backup Operators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.8 and 2.2.9
.SYNOPSIS
2.2.8 Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators' (DC only)
2.2.9 Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only)

.DESCRIPTION
This policy setting determines which users or groups have the right to log on as a Remote Desktop Services client. If your organization uses Remote Assistance as part of its help desk strategy, create a group and assign it this user right through Group Policy. If the help desk in your organization does not use Remote Assistance, assign this user right only to the Administrators group or use the Restricted Groups feature to ensure that no user accounts are part of the Remote Desktop Users group.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRemoteInteractiveLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Administrators')
    $MemberServer = @('Administrators')
    $MSOptional = @('Remote Desktop Users')

    
    if ($ProductType -eq 2) {
        $RecommendationNumber = '2.2.8'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators' (DC only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeRemoteInteractiveLogonRight" -Definition $DomainController
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $RecommendationNumber = '2.2.9'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeRemoteInteractiveLogonRight" -Definition $MemberServer -OptionalDef $MSOptional
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.9'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.10
.SYNOPSIS
2.2.10 Ensure 'Back up files and directories' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to circumvent file and directory permissions to back up the system. This user right is enabled only when an application (such as NTBACKUP) attempts to access a file or directory through the NTFS file system backup application programming interface (API). Otherwise, the assigned file and directory permissions apply.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeBackupPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.7'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Allow log on locally' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeBackupPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.11
.SYNOPSIS
2.2.11 Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE'

.DESCRIPTION
This policy setting determines which users and groups can change the time and date on the internal clock of the computers in your environment. Users who are assigned this user right can affect the appearance of event logs. When a computer's time setting is changed, logged events reflect the new time, not the actual time that the events occurred.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSystemTimePrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.11'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeSystemTimePrivilege" -Definition @('Administrators','LOCAL SERVICE')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.12
.SYNOPSIS
2.2.12 Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE'

.DESCRIPTION
This setting determines which users can change the time zone of the computer. This ability holds no great danger for the computer and may be useful for mobile workers.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTimeZonePrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.12'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeTimeZonePrivilege" -Definition @('Administrators','LOCAL SERVICE')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.13
.SYNOPSIS
2.2.13 Ensure 'Create a pagefile' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to change the size of the pagefile. By making the pagefile extremely large or extremely small, an attacker could easily affect the performance of a compromised computer.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreatePagefilePrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.13'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Create a pagefile' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeCreatePagefilePrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.14
.SYNOPSIS
2.2.14 Ensure 'Create a token object' is set to 'No One'

.DESCRIPTION
This policy setting allows a process to create an access token, which may provide elevated rights to access sensitive data.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreateTokenPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.14'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Create a token object' is set to 'No One'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeCreateTokenPrivilege" -Definition @("")

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.15
.SYNOPSIS
2.2.15 Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'

.DESCRIPTION
This policy setting determines whether users can create global objects that are available to all sessions. Users can still create objects that are specific to their own session if they do not have this user right.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreateGlobalPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.15'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeCreateGlobalPrivilege" -Definition @('Administrators','LOCAL SERVICE','NETWORK SERVICE','SERVICE')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.16
.SYNOPSIS
2.2.16 Ensure 'Create permanent shared objects' is set to 'No One'

.DESCRIPTION
This user right is useful to kernel-mode components that extend the object namespace. However, components that run in kernel mode have this user right inherently. Therefore, it is typically not necessary to specifically assign this user right.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreatePermanentPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.16'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Create permanent shared objects' is set to 'No One'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeCreatePermanentPrivilege" -Definition @("")

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.17 and 2.2.18
.SYNOPSIS
2.2.17 Ensure 'Create symbolic links' is set to 'Administrators' (DC only)
2.2.18 Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only)

.DESCRIPTION
This policy setting determines which users can create symbolic links. In Windows Vista, existing NTFS file system objects, such as files and folders, can be accessed by referring to a new kind of file system object called a symbolic link. A symbolic link is a pointer (much like a shortcut or .lnk file) to another file system object, which can be a file, folder, shortcut or another symbolic link. The difference between a shortcut and a symbolic link is that a shortcut only works from within the Windows shell. To other programs and applications, shortcuts are just another file, whereas with symbolic links, the concept of a shortcut is implemented as a feature of the NTFS file system.

The recommended state for this setting is: Administrators and (when the Hyper-V Role is installed) NT VIRTUAL MACHINE\Virtual Machines.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeCreateSymbolicLinkPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Administrators')
    $MemberServer = @('Administrators')
    $MSOptional = @('NT VIRTUAL MACHINE\Virtual Machines')

    
    if ($ProductType -eq 2) {
        $RecommendationNumber = '2.2.17'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Create symbolic links' is set to 'Administrators' (DC only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeCreateSymbolicLinkPrivilege" -Definition $DomainController
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $RecommendationNumber = '2.2.18'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeCreateSymbolicLinkPrivilege" -Definition $MemberServer -OptionalDef $MSOptional
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.18'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.19
.SYNOPSIS
2.2.19 Ensure 'Debug programs' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which user accounts will have the right to attach a debugger to any process or to the kernel, which provides complete access to sensitive and critical operating system components. Developers who are debugging their own applications do not need to be assigned this user right; however, developers who are debugging new system components will need it.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDebugPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.19'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Debug programs' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeDebugPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.20 and 2.2.21
.SYNOPSIS
2.2.20 Ensure 'Deny access to this computer from the network' to include 'Guests' (DC only)
2.2.21 Ensure 'Deny access to this computer from the network' to include 'Guests, Local account and member of Administrators group' (MS only)

.DESCRIPTION
This policy setting prohibits users from connecting to a computer from across the network, which would allow users to access and potentially modify data remotely. In high security environments, there should be no need for remote users to access data on a computer. Instead, file sharing should be accomplished through the use of network servers. This user right supersedes the "Access this computer from the network" user right if an account is subject to both policies.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyNetworkLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Guests')
    $MemberServer = @('Guests')
    $MSOptional = @('Local account and member of Administrators group')

    
    if ($ProductType -eq 2) {
        $RecommendationNumber = '2.2.20'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Deny access to this computer from the network' to include 'Guests' (DC only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeDenyNetworkLogonRight" -Definition $DomainController
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $RecommendationNumber = '2.2.21'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Deny access to this computer from the network' to include 'Guests, Local account and member of Administrators group' (MS only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeDenyNetworkLogonRight" -Definition $MemberServer -OptionalDef $MSOptional
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.21'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Deny access to this computer from the network' to include 'Guests, Local account and member of Administrators group' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.22
.SYNOPSIS
2.2.22 Ensure 'Deny log on as a batch job' to include 'Guests'

.DESCRIPTION
This policy setting determines which accounts will not be able to log on to the computer as a batch job. A batch job is not a batch (.bat) file, but rather a batch-queue facility. Accounts that use the Task Scheduler to schedule jobs need this user right.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyBatchLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()
        $RecommendationNumber = '2.2.22'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Deny log on as a batch job' to include 'Guests'"
        $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeDenyBatchLogonRight" -Definition @('Guests')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.23
.SYNOPSIS
2.2.23 Ensure 'Deny log on as a service' to include 'Guests'

.DESCRIPTION
This security setting determines which service accounts are prevented from registering a process as a service. This user right supersedes the "Log on as a service" user right if an account is subject to both policies.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyServiceLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()
        $RecommendationNumber = '2.2.23'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Deny log on as a service' to include 'Guests'"
        $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeDenyServiceLogonRight" -Definition @('Guests')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.24
.SYNOPSIS
2.2.24 Ensure 'Deny log on locally' to include 'Guests'

.DESCRIPTION
This security setting determines which users are prevented from logging on at the computer. This policy setting supersedes the "Allow log on locally" policy setting if an account is subject to both policies.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyInteractiveLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()
        $RecommendationNumber = '2.2.24'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Deny log on locally' to include 'Guests'"
        $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeDenyInteractiveLogonRight" -Definition @('Guests')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.25 and 2.2.26
.SYNOPSIS
2.2.25 Ensure 'Deny log on through Remote Desktop Services' to include 'Guests' (DC only)
2.2.26 Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests, Local account' (MS only)

.DESCRIPTION
This policy setting determines whether users can log on as Remote Desktop clients. After the baseline Member Server is joined to a domain environment, there is no need to use local accounts to access the server from the network. Domain accounts can access the server for administration and end-user processing. This user right supersedes the "Allow log on through Remote Desktop Services" user right if an account is subject to both policies.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Guests')
    $MemberServer = @('Guests','Local account')

    
    if ($ProductType -eq 2) {
        $RecommendationNumber = '2.2.25'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Deny log on through Remote Desktop Services' to include 'Guests' (DC only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeDenyRemoteInteractiveLogonRight" -Definition $DomainController
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $RecommendationNumber = '2.2.26'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests, Local account' (MS only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeDenyRemoteInteractiveLogonRight" -Definition $MemberServer
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.26'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests, Local account' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.27 and 2.2.28
.SYNOPSIS
2.2.27 Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'Administrators' (DC only)
2.2.28 Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only)

.DESCRIPTION
This policy setting allows users to change the Trusted for Delegation setting on a computer object in Active Directory. Abuse of this privilege could allow unauthorized users to impersonate other users on the network.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeEnableDelegationPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Administrators')
    $MemberServer = @("")

    
    if ($ProductType -eq 2) {
        $RecommendationNumber = '2.2.27'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'Administrators' (DC only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeEnableDelegationPrivilege" -Definition $DomainController
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $RecommendationNumber = '2.2.28'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeEnableDelegationPrivilege" -Definition $MemberServer
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.28'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.29
.SYNOPSIS
2.2.29 Ensure 'Force shutdown from a remote system' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to shut down Windows Vista-based or newer computers from remote locations on the network. Anyone who has been assigned this user right can cause a denial of service (DoS) condition, which would make the computer unavailable to service user requests. Therefore, it is recommended that only highly trusted administrators be assigned this user right.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRemoteShutdownPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
        $RecommendationNumber = '2.2.29'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Force shutdown from a remote system' is set to 'Administrators'"
        $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeRemoteShutdownPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.30
.SYNOPSIS
2.2.30 Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'

.DESCRIPTION
This policy setting determines which users or processes can generate audit records in the Security log.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeAuditPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
        $RecommendationNumber = '2.2.30'
        $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
        $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeAuditPrivilege" -Definition @('LOCAL SERVICE', 'NETWORK SERVICE')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.31 and 2.2.32
.SYNOPSIS
2.2.31 Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (DC only)
2.2.32 Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only)

.DESCRIPTION
The policy setting allows programs that run on behalf of a user to impersonate that user (or another specified account) so that they can act on behalf of the user. If this user right is required for this kind of impersonation, an unauthorized user will not be able to convince a client to connect—for example, by remote procedure call (RPC) or named pipes—to a service that they have created to impersonate that client, which could elevate the unauthorized user's permissions to administrative or system levels.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeImpersonatePrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE', 'SERVICE')
    $MemberServer = @('Administrators', 'LOCAL SERVICE', 'NETWORK SERVICE', 'SERVICE')
    $MSOptional = @('IIS_IUSRS')

    if ($ProductType -eq 2) {
        $RecommendationNumber = '2.2.31'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (DC only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeImpersonatePrivilege" -Definition $DomainController
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $RecommendationNumber = '2.2.32'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeImpersonatePrivilege" -Definition $MemberServer -OptionalDef $MSOptional
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.32'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' and (when the Web Server (IIS) Role with Web Services Role Service is installed) 'IIS_IUSRS' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.33
.SYNOPSIS
2.2.33 Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group'

.DESCRIPTION
This policy setting determines whether users can increase the base priority class of a process. (It is not a privileged operation to increase relative priority within a priority class.) This user right is not required by administrative tools that are supplied with the operating system but might be required by software development tools.

.EXAMPLE
An example

.NOTES
The benchmark specifies 'Administrators' and 'Window Manager\Window Manager Group' for 2019 and newer, but on a fresh install of Server 2022 promoted to a DC, 'Window Manager\Window Manager Group' does not come up in any searches. It was moved to be considered optional by the script.
#>
function Test-UserRightsAssignmentSeIncreaseBasePriorityPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.33'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeIncreaseBasePriorityPrivilege" -Definition @('Administrators') -OptionalDef @('Window Manager\Window Manager Group')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.34
.SYNOPSIS
2.2.34 Ensure 'Load and unload device drivers' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to dynamically load a new device driver on a system. An attacker could potentially use this capability to install malicious code that appears to be a device driver. This user right is required for users to add local printers or printer drivers in Windows Vista.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeLoadDriverPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.34'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Load and unload device drivers' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeLoadDriverPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.35
.SYNOPSIS
2.2.35 Ensure 'Lock pages in memory' is set to 'No One'

.DESCRIPTION
This policy setting allows a process to keep data in physical memory, which prevents the system from paging the data to virtual memory on disk. If this user right is assigned, significant degradation of system performance can occur.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeLockMemoryPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.35'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Lock pages in memory' is set to 'No One'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeLockMemoryPrivilege" -Definition @('')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.36
.SYNOPSIS
2.2.36 Ensure 'Log on as a batch job' is set to 'Administrators' (DC Only)

.DESCRIPTION
This policy setting allows accounts to log on using the task scheduler service. Because the task scheduler is often used for administrative purposes, it may be needed in enterprise environments. However, its use should be restricted in high security environments to prevent misuse of system resources or to prevent attackers from using the right to launch malicious code after gaining user level access to a computer.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeBatchLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.36'
    $ProfileApplicability = @("Level 2 - Domain Controller")
    $RecommendationName = "(L1) (L2) Ensure 'Log on as a batch job' is set to 'Administrators' (DC Only)"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeBatchLogonRight" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.37 and 2.2.38
.SYNOPSIS
2.2.37 Ensure 'Manage auditing and security log' is set to 'Administrators' and (when Exchange is running in the environment) 'Exchange Servers' (DC only)
2.2.38 Ensure 'Manage auditing and security log' is set to 'Administrators' (MS only)

.DESCRIPTION
This policy setting determines which users can change the auditing options for files and directories and clear the Security log.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSecurityPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Administrators')
    $DCOptional = @('Exchange Servers')
    $MemberServer = @('Administrators')

    if ($ProductType -eq 2) {
        $RecommendationNumber = '2.2.37'
        $ProfileApplicability = @("Level 1 - Domain Controller")
        $RecommendationName = "(L1) Ensure 'Manage auditing and security log' is set to 'Administrators' and (when Exchange is running in the environment) 'Exchange Servers' (DC only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeSecurityPrivilege" -Definition $DomainController -OptionalDef $DCOptional
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } elseif ($ProductType -eq 3) {
        $RecommendationNumber = '2.2.38'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Manage auditing and security log' is set to 'Administrators' (MS only)"
        $Source = 'Group Policy Settings'
        $Pass = Test-UserRightsAssignment -EntryName "SeSecurityPrivilege" -Definition $MemberServer
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $Pass.Pass
            'Setting' = $Pass.Setting
            'Entry' = $Pass.Entry
        }
    } else {
        $RecommendationNumber = '2.2.38'
        $ProfileApplicability = @("Level 1 - Member Server")
        $RecommendationName = "(L1) Ensure 'Manage auditing and security log' is set to 'Administrators' (MS only)"
        $Source = 'Group Policy Settings'
        $Properties = [PSCustomObject]@{
            'RecommendationNumber' = $RecommendationNumber
            'ProfileApplicability' = $ProfileApplicability
            'RecommendationName'= $RecommendationName
            'Source' = $Source
            'Pass'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.39
.SYNOPSIS
2.2.39 Ensure 'Modify an object label' is set to 'No One'

.DESCRIPTION
This privilege determines which user accounts can modify the integrity label of objects, such as files, registry keys, or processes owned by other users. Processes running under a user account can modify the label of an object owned by that user to a lower level without this privilege.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRelabelPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.39'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Modify an object label' is set to 'No One'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeRelabelPrivilege" -Definition @('')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.40
.SYNOPSIS
2.2.40 Ensure 'Modify firmware environment values' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to configure the system-wide environment variables that affect hardware configuration. This information is typically stored in the Last Known Good Configuration. Modification of these values and could lead to a hardware failure that would result in a denial of service condition.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSystemEnvironmentPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.40'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Modify firmware environment values' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeSystemEnvironmentPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.41
.SYNOPSIS
2.2.41 Ensure 'Perform volume maintenance tasks' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to manage the system's volume or disk configuration, which could allow a user to delete a volume and cause data loss as well as a denial-of-service condition.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeManageVolumePrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.41'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Perform volume maintenance tasks' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeManageVolumePrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.42
.SYNOPSIS
2.2.42 Ensure 'Profile single process' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users can use tools to monitor the performance of non-system processes. Typically, you do not need to configure this user right to use the Microsoft Management Console (MMC) Performance snap-in. However, you do need this user right if System Monitor is configured to collect data using Windows Management Instrumentation (WMI). Restricting the Profile single process user right prevents intruders from gaining additional information that could be used to mount an attack on the system.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeProfileSingleProcessPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.42'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Profile single process' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeProfileSingleProcessPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.43
.SYNOPSIS
2.2.43 Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost'

.DESCRIPTION
This policy setting allows users to use tools to view the performance of different system processes, which could be abused to allow attackers to determine a system's active processes and provide insight into the potential attack surface of the computer.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSystemProfilePrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.43'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeSystemProfilePrivilege" -Definition @('Administrators', 'NT SERVICE\WdiServiceHost')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.44
.SYNOPSIS
2.2.44 Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'

.DESCRIPTION
This policy setting allows one process or service to start another service or process with a different security access token, which can be used to modify the security access token of that sub-process and result in the escalation of privileges.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeAssignPrimaryTokenPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.44'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeAssignPrimaryTokenPrivilege" -Definition @('LOCAL SERVICE', 'NETWORK SERVICE')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.45
.SYNOPSIS
2.2.45 Ensure 'Restore files and directories' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users can bypass file, directory, registry, and other persistent object permissions when restoring backed up files and directories on computers that run Windows Vista (or newer) in your environment. This user right also determines which users can set valid security principals as object owners; it is similar to the Back up files and directories user right.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRestorePrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.45'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Restore files and directories' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeRestorePrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.46
.SYNOPSIS
2.2.46 Ensure 'Shut down the system' is set to 'Administrators'

.DESCRIPTION
This policy setting determines which users who are logged on locally to the computers in your environment can shut down the operating system with the Shut Down command. Misuse of this user right can result in a denial of service condition.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeShutdownPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.46'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Shut down the system' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeShutdownPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.47
.SYNOPSIS
2.2.47 Ensure 'Synchronize directory service data' is set to 'No One' (DC only)

.DESCRIPTION
This security setting determines which users and groups have the authority to synchronize all directory service data. This is also known as Active Directory synchronization.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeSyncAgentPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.47'
    $ProfileApplicability = @("Level 1 - Domain Controller")
    $RecommendationName = "(L1) Ensure 'Synchronize directory service data' is set to 'No One' (DC only)"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeSyncAgentPrivilege" -Definition @('')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

<# 2.2.48
.SYNOPSIS
2.2.48 Ensure 'Take ownership of files or other objects' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to take ownership of files, folders, registry keys, processes, or threads. This user right bypasses any permissions that are in place to protect objects to give ownership to the specified user.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTakeOwnershipPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()
    $RecommendationNumber = '2.2.48'
    $ProfileApplicability = @("Level 1 - Domain Controller","Level 1 - Member Server")
    $RecommendationName = "(L1) Ensure 'Take ownership of files or other objects' is set to 'Administrators'"
    $Source = 'Group Policy Settings'

    $Pass = Test-UserRightsAssignment -EntryName "SeTakeOwnershipPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber' = $RecommendationNumber
        'ProfileApplicability' = $ProfileApplicability
        'RecommendationName'= $RecommendationName
        'Source' = $Source
        'Pass'= $Pass.Pass
        'Setting' = $Pass.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}
