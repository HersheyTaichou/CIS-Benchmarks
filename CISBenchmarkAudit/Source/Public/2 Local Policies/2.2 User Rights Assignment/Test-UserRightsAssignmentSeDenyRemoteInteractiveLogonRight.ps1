<#
.SYNOPSIS
2.2.25 Ensure 'Deny log on through Remote Desktop Services' to include 'Guests' (DC only)
2.2.26 Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests, Local account' (MS only)

.DESCRIPTION
This policy setting determines whether users can log on as Remote Desktop clients. After the baseline Member Server is joined to a domain environment, there is no need to use local accounts to access the server from the network. Domain accounts can access the server for administration and end-user processing. This user right supersedes the "Allow log on through Remote Desktop Services" user right if an account is subject to both policies.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.25     L1    Ensure 'Deny log on through Remote Desktop Services' to incl... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyRemoteInteractiveLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Guests')
        $MemberServer = @('Guests','Local account')
    }

    process {
        if ($ProductType.Number -eq 2) {
            $Result = [CISBenchmark]::new()
            $Result.Number = "2.2.25"
            $Result.Level = "L1"
            if ($ProductType.Number -eq 1) {
                $Result.Profile = "Corporate/Enterprise Environment"
            } elseif ($ProductType.Number -eq 2) {
                $Result.Profile = "Domain Controller"
            } elseif ($ProductType.Number -eq 3) {
                $Result.Profile = "Member Server"
            }
            $Result.Title = "Ensure 'Deny log on through Remote Desktop Services' to include 'Guests' (DC only)"
            $Result.Source = "Group Policy Settings"
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyRemoteInteractiveLogonRight" -Definition $DomainController -Include -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $Result.Number = '2.2.26'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests, Local account' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyRemoteInteractiveLogonRight" -Definition $MemberServer -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}
