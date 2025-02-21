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
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
        $Result.Number = '2.2.30'
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
        $Result.Source = 'Group Policy Settings'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeAuditPrivilege" -Definition @('LOCAL SERVICE', 'NETWORK SERVICE') -gpresult $GPResult

    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
