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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.43'
    $Level = 'L1'
        
    $Title= "Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost'"
    $Source = 'FixMe'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSystemProfilePrivilege" -Definition @('Administrators', 'NT SERVICE\WdiServiceHost') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
