<#
.SYNOPSIS
2.2.22 Ensure 'Deny log on as a batch job' to include 'Guests'

.DESCRIPTION
This policy setting determines which accounts will not be able to log on to the computer as a batch job. A batch job is not a batch (.bat) file, but rather a batch-queue facility. Accounts that use the Task Scheduler to schedule jobs need this user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyBatchLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.22     L1    Ensure 'Deny log on as a batch job' to include 'Guests'         Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyBatchLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
        $Result = [CISBenchmark]::new()
        $Result.Number = "2.2.22"
        $Result.Level = "L1"
        if ($ProductType.Number -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType.Number -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType.Number -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Deny log on as a batch job' to include 'Guests'"
		$Result.Source = "Group Policy Settings"

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyBatchLogonRight" -Definition @('Guests') -Include -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
