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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.14'
    $Level = 'L1'
        
    $Title= "Ensure 'Create a token object' is set to 'No One'"
    $Source = 'FixMe'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeCreateTokenPrivilege" -Definition @("") -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
