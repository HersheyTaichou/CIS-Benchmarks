<#
.SYNOPSIS
2.2.24 Ensure 'Deny log on locally' to include 'Guests'

.DESCRIPTION
This security setting determines which users are prevented from logging on at the computer. This policy setting supersedes the "Allow log on locally" policy setting if an account is subject to both policies.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyInteractiveLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.24     L1    Ensure 'Deny log on locally' to include 'Guests'                Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyInteractiveLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
        $Result = [CISBenchmark]::new()
        $Number = '2.2.24'
        $Level = 'L1'
        
        $Title= "Ensure 'Deny log on locally' to include 'Guests'"
		$Result.Source = "Group Policy Settings"

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyInteractiveLogonRight" -Definition @('Guests') -Include -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
