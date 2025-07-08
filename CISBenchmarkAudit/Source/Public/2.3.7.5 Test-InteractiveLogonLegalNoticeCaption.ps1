<#
.SYNOPSIS
2.3.7.5 (L1) Configure 'Interactive logon: Message title for users attempting to log on'

.DESCRIPTION
This policy setting specifies the text displayed in the title bar of the window that users see when they log on to the system.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-InteractiveLogonLegalNoticeCaption

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.7.5    L1    Configure 'Interactive logon: Message title for users attemp... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-InteractiveLogonLegalNoticeCaption {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\LegalNoticeCaption"
        $Number = '2.3.7.5'
        $Level = 'L1'
        
        $Title= "Configure 'Interactive logon: Message title for users attempting to log on'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        $Result.Setting = $Result.Entry.SettingString
        if ($Result.Setting) {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
