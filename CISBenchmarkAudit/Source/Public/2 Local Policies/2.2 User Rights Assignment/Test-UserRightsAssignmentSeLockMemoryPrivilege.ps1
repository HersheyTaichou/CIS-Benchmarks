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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Result.Number = '2.2.35'
    $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
    $Result.Title = "Ensure 'Lock pages in memory' is set to 'No One'"
    $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeLockMemoryPrivilege" -Definition @('') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
