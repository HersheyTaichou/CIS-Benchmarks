<#
.SYNOPSIS
2.3.6.2 (L1) Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled'

.DESCRIPTION
This policy setting determines whether a domain member should attempt to negotiate encryption for all secure channel traffic that it initiates.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-DomainMemberSealSecureChannel

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.6.2    L1    Ensure 'Domain member: Digitally encrypt secure channel data... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-DomainMemberSealSecureChannel {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()

        # Get the current value of the setting
        $EntryName = "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\SealSecureChannel"
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.SetCorrectly = [int]$Result.Entry.SettingNumber
    }

    end {
        $Number = '2.3.6.2'
        $Level = 'L1'
        
        $Title= "Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled'"
        $Source = 'FixMe'
        return $Result
    }
}
