<#
.SYNOPSIS
18.10.63.1 (L2) Ensure 'Turn off KMS Client Online AVS Validation' is set to 'Enabled'

.DESCRIPTION
The Key Management Service (KMS) is a Microsoft license activation method that entails setting up a local server to store the software licenses. The KMS server itself needs to connect to Microsoft to activate the KMS service, but subsequent on-network clients can activate Microsoft Windows OS and/or their Microsoft Office via the KMS server instead of connecting directly to Microsoft. This policy setting lets you opt-out of sending KMS client activation data to Microsoft automatically.

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
function Test-SoftwareProtectionPlatformNoGenTicket {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult)
    )

    begin {
        $EntryName = "Turn off KMS Client Online AVS Validation"
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.10.63.1'
        $Result.Level = "L2"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Ensure 'Turn off KMS Client Online AVS Validation' is set to 'Enabled'"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult
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
