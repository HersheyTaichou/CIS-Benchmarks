<#
.SYNOPSIS
2.2.2 Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)
2.2.3 Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)

.DESCRIPTION
This policy setting allows other users on the network to connect to the computer and is required by various network protocols that include Server Message Block (SMB)-based protocols, NetBIOS, Common Internet File System (CIFS), and Component Object Model Plus (COM+).

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignmentSeNetworkLogonRight

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.2.2      L1    Ensure 'Access this computer from the network' is set to 'Ad... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeNetworkLogonRight {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # These three entries should be the only entries 
        $DomainController = @('Administrators','Authenticated Users','ENTERPRISE DOMAIN CONTROLLERS')
        $MemberServer = @('Administrators','Authenticated Users')
    }

    process {
        if ($ProductType.Number -eq 2) {
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $DomainController -gpresult $GPResult
            $Result.Number = '2.2.2'
            $Result.Level = "L1"
            $Result.Profile = "Domain Controller"
            $Result.Title = "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)"
            $Result.Source = 'Group Policy Settings'
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        } elseif ($ProductType.Number -eq 3) {
            $UserRightsAssignment = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $MemberServer -gpresult $GPResult
            $Result.Number = '2.2.3'
            $Result.Level = "L1"
            $Result.Profile = "Member Server"
            $Result.Title = "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
            $Result.Source = 'Group Policy Settings'
            $Result.SetCorrectly = $UserRightsAssignment.SetCorrectly 
            $Result.Setting = $UserRightsAssignment.Setting
            $Result.Entry = $UserRightsAssignment.Entry.Entry
        }
    }

    end {
        return $Result
    }
}
