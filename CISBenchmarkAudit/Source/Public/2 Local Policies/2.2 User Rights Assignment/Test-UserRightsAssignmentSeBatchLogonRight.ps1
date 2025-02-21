<#
.SYNOPSIS
2.2.36 Ensure 'Log on as a batch job' is set to 'Administrators' (DC Only)

.DESCRIPTION
This policy setting allows accounts to log on using the task scheduler service. Because the task scheduler is often used for administrative purposes, it may be needed in enterprise environments. However, its use should be restricted in high security environments to prevent misuse of system resources or to prevent attackers from using the right to launch malicious code after gaining user level access to a computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeBatchLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.36     L2    Ensure 'Log on as a batch job' is set to 'Administrators' (D... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeBatchLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
    $Number = '2.2.36'
    $Level = 'L2'
    $Result.Profile = "Domain Controller"
    $Title= "Ensure 'Log on as a batch job' is set to 'Administrators' (DC Only)"
    $Source = 'FixMe'

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeBatchLogonRight" -Definition @('Administrators') -gpresult $GPResult
    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
