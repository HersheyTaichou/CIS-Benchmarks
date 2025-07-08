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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.47'
    $Level = 'L1'
        $Result.Profile = "Domain Controller"
    $Title= "Ensure 'Synchronize directory service data' is set to 'No One' (DC only)"
    $Source = 'FixMe'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeSyncAgentPrivilege" -Definition @('') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
