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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.12'
    $Level = 'L1'
        
    $Title= "Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE'"
    $Source = 'FixMe'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeTimeZonePrivilege" -Definition @('Administrators','LOCAL SERVICE') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
