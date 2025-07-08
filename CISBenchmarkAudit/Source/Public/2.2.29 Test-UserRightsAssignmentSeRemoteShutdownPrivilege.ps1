<#
.SYNOPSIS
2.2.29 Ensure 'Force shutdown from a remote system' is set to 'Administrators'

.DESCRIPTION
This policy setting allows users to shut down Windows Vista-based or newer computers from remote locations on the network. Anyone who has been assigned this user right can cause a denial of service (DoS) condition, which would make the computer unavailable to service user requests. Therefore, it is recommended that only highly trusted administrators be assigned this user right.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeRemoteShutdownPrivilege

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.29     L1    Ensure 'Force shutdown from a remote system' is set to 'Admi... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRemoteShutdownPrivilege {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    $Result = [CISBenchmark]::new()
        $Result = [CISBenchmark]::new()
        $Number = '2.2.29'
        $Level = 'L1'
        
        $Title= "Ensure 'Force shutdown from a remote system' is set to 'Administrators'"
		$Result.Source = "Group Policy Settings"

    $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRemoteShutdownPrivilege" -Definition @('Administrators') -gpresult $GPResult

    $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
    $Result.Setting = $UserRightsAssignment.Setting
    return $Result
}
