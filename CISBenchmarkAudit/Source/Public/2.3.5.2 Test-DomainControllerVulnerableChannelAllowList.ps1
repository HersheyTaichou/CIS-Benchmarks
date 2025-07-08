<#
.SYNOPSIS
2.3.5.2 (L1) Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured' (DC Only)

.DESCRIPTION
This security setting determines whether the domain controller bypasses secure RPC for Netlogon secure channel connections for specified machine accounts.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainControllerVulnerableChannelAllowList

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.5.2    L1    Ensure 'Domain controller: Allow vulnerable Netlogon secure ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainControllerVulnerableChannelAllowList {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\VulnerableChannelAllowList"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        if ($Result.Entry) {
            $Result.SetCorrectly = $false
        } else {
            $Result.SetCorrectly = $true
        }
    }

    end {
        $Number = '2.3.5.2'
        $Level = 'L1'
        $Result.Profile = "Domain Controller"
        $Title= "Ensure 'Domain controller: Allow vulnerable Netlogon secure channel connections' is set to 'Not Configured'"
        $Source = 'FixMe'
        return $Result
    }
}
