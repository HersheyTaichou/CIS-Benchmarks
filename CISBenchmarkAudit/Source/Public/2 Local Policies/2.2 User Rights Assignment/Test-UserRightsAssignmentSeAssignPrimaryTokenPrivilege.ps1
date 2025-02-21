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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.44'
    $Level = 'L1'
    $Title= "Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
    $Source = 'SecEdit'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeAssignPrimaryTokenPrivilege" -Definition @('LOCAL SERVICE', 'NETWORK SERVICE') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
