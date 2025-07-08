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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.10'
    $Level = 'L1'
        
    $Title= "Ensure 'Allow log on locally' is set to 'Administrators'"
    $Source = 'FixMe'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeBackupPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
