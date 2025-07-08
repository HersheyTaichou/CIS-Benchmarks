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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.48'
    $Level = 'L1'
        
    $Title= "Ensure 'Take ownership of files or other objects' is set to 'Administrators'"
    $Source = 'FixMe'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeTakeOwnershipPrivilege" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
