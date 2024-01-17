<#
.SYNOPSIS
19.6.6.1.1 (L2) Ensure 'Turn off Help Experience Improvement Program' is set to 'Enabled''

.DESCRIPTION
This policy setting specifies whether users can participate in the Help Experience Improvement program. The Help Experience Improvement program collects information about how customers use Windows Help so that Microsoft can improve it.

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
function Test-UserInternetCommunicationManagementNoImplicitFeedback {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Turn off Help Experience Improvement Program"
        $Result = [CISBenchmark]::new()
        $Result.Number = '19.6.6.1.1'
        $Result.Level = "L2"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Turn off Help Experience Improvement Program' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "UserResults"
    }

    process {
        $Result.Setting = $Result.Entry.State
        if ($Result.Setting -eq "Enabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
