<#
.SYNOPSIS
18.6.14.1 (L1) Ensure 'Hardened UNC Paths' is set to 'Enabled, with "Require Mutual Authentication" and "Require Integrity" set for all NETLOGON and SYSVOL shares'

.DESCRIPTION
This policy setting configures secure access to UNC paths.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE


Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-NetworkProviderHardenedPaths {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Hardened UNC Paths"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.6.14.1'
        $Result.Level = "L1"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Hardened UNC Paths' is set to 'Enabled, with `"Require Mutual Authentication`" and `"Require Integrity`" set for all NETLOGON and SYSVOL shares'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
    }

    process {
        if ($Result.Entry.ListBox.Name -eq "Hardened UNC Paths:" -and $Result.Entry.ListBox.State -eq "Enabled") {
            $Result.Setting = $Result.Entry.ListBox.State
            $Return.ListBox.Value.Element | ForEach-Object {
                if ($_.Name -eq "\\*\NETLOGON" -and $_.Data -eq "RequireMutualAuthentication=1, RequireIntegrity=1") {
                    $NETLOGON = $true
                }
                if ($_.Name -eq "\\*\SYSVOL" -and $_.Data -eq "RequireMutualAuthentication=1, RequireIntegrity=1") {
                    $SYSVOL = $true
                }
                if ($NETLOGON -and $SYSVOL) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
            }
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
