<#
.SYNOPSIS
2.3.11.10 (L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) servers' is set to 'Require NTLMv2 session security, Require 128-bit encryption'

.DESCRIPTION
This policy setting determines which behaviors are allowed by servers for applications using the NTLM Security Support Provider (SSP).

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkSecurityNTLMMinServerSec

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.11.10  L1    Ensure 'Network security: Minimum session security for NTLM ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkSecurityNTLMMinServerSec {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\NTLMMinClientSec"
        $Number = '2.3.11.10'
        $Level = 'L1'
        
        $Title= "Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) servers' is set to 'Require NTLMv2 session security, Require 128-bit encryption'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Entry.Display.DisplayFields.Field | ForEach-Object {$Result.Setting += $_.Name + "," + $_.Value + "; "}
        if ([int]$Result.Entry.SettingNumber -eq 537395200) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
