<#
.SYNOPSIS
2.2.8 Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators' (DC only)
2.2.9 Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only)

.DESCRIPTION
This policy setting determines which users or groups have the right to log on as a Remote Desktop Services client. If your organization uses Remote Assistance as part of its help desk strategy, create a group and assign it this user right through Group Policy. If the help desk in your organization does not use Remote Assistance, assign this user right only to the Administrators group or use the Restricted Groups feature to ensure that no user accounts are part of the Remote Desktop Users group.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeRemoteInteractiveLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.8      L1    Ensure 'Allow log on through Remote Desktop Services' is set... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeRemoteInteractiveLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators')
        $MemberServer = @('Administrators')
        $MSOptional = @('Remote Desktop Users')
    }

    process {
        if ($ProductType.Number -eq 2) {
            $Result = [CISBenchmark]::new()
            $Number = '2.2.8'
            $Level = 'L1'
            if ($ProductType.Number -eq 1) {
                $Result.Profile = "Corporate/Enterprise Environment"
            } elseif ($ProductType.Number -eq 2) {
                $Result.Profile = "Domain Controller"
            } elseif ($ProductType.Number -eq 3) {
                $Result.Profile = "Member Server"
            }
            $Title= "Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators' (DC only)"
            $Result.Source = "Group Policy Settings"
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRemoteInteractiveLogonRight" -Definition $DomainController -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $Number = '2.2.9'
            $Level = 'L1'
            $Result.Profile = "Member Server"
            $Title= "Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only)"
            $Source = 'FixMe'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeRemoteInteractiveLogonRight" -Definition $MemberServer -OptionalDef $MSOptional -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
            }
    }

    end {
        return $Result
    }
}
