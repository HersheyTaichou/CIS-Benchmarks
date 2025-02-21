<#
.SYNOPSIS
2.2.20 Ensure 'Deny access to this computer from the network' to include 'Guests' (DC only)
2.2.21 Ensure 'Deny access to this computer from the network' to include 'Guests, Local account and member of Administrators group' (MS only)

.DESCRIPTION
This policy setting prohibits users from connecting to a computer from across the network, which would allow users to access and potentially modify data remotely. In high security environments, there should be no need for remote users to access data on a computer. Instead, file sharing should be accomplished through the use of network servers. This user right supersedes the "Access this computer from the network" user right if an account is subject to both policies.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeDenyNetworkLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.20     L1    Ensure 'Deny access to this computer from the network' to in... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeDenyNetworkLogonRight {
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
        $MemberServer = @('Guests','Local account and member of Administrators group')
    }

    process {
        if ($ProductType.Number -eq 2) {
            $Result.Number = '2.2.20'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Deny access to this computer from the network' to include 'Guests' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyNetworkLogonRight" -Definition $DomainController -Include -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $Result.Number = '2.2.21'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Deny access to this computer from the network' to include 'Guests, Local account and member of Administrators group' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeDenyNetworkLogonRight" -Definition $MemberServer -Include -gpresult $GPResult
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }
    end {
        return $Result
    }
}
