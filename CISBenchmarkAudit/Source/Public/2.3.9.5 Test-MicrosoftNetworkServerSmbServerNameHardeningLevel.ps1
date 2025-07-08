<#
.SYNOPSIS
2.3.9.5 (L1) Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher (MS only)

.DESCRIPTION
This policy setting controls the level of validation a computer with shared folders or printers (the server) performs on the service principal name (SPN) that is provided by the client computer when it establishes a session using the server message block (SMB) protocol.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-MicrosoftNetworkServerSmbServerNameHardeningLevel

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.9.5    L1    Ensure 'Microsoft network server: Server SPN target name val... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-MicrosoftNetworkServerSmbServerNameHardeningLevel {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\SmbServerNameHardeningLevel"
        $Number = '2.3.9.5'
        $Level = 'L1'
        
        $Title= "Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher (MS only)"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = [int]$Result.Entry.SettingNumber
        if (($Result.Setting) -and ($Result.Setting -ge 1) -and ($ProductType.Number -eq 3)) {
            $Result.SetCorrectly = $true
        } elseif (($ProductType.Number -eq 2) -and ($Result.Setting -ge 1)) {
            Write-Warning "$($Result.Number): `"$($Result.Title)`" On Domain Controllers, if Hardened UNC Paths (18.6.14.1) is enabled, this setting can lead to significant issues."
            $Result.SetCorrectly = $false
        } elseif (($ProductType.Number -eq 2) -and (-not($Result.Setting))) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
