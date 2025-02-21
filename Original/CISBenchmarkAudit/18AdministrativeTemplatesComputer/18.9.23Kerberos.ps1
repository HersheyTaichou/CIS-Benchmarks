<#
.SYNOPSIS
18.9.23.1 (L2) Ensure 'Support device authentication using certificate' is set to 'Enabled: Automatic'

.DESCRIPTION
This policy setting allows you to set support for Kerberos to attempt authentication using the certificate for the device to the domain.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-KerberosDevicePKInitEnabled

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-KerberosDevicePKInitEnabled {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $EntryName = "Support device authentication using certificate"
        $Result = [CISBenchmark]::new()
        $Number = '18.9.23.1'
        $Level = 'L2'
        
        $Title= "Ensure 'Support device authentication using certificate' is set to 'Enabled: Automatic'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.DropDownList.Value.Name
        if ($Result.Setting -eq "Automatic" -and $Result.Entry.DropDownList.State -eq "Enabled") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
