<#
.SYNOPSIS
2.3.10.5 (L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'

.DESCRIPTION
This policy setting determines what additional permissions are assigned for anonymous connections to the computer.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessEveryoneIncludesAnonymous

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.5   L1    Ensure 'Network access: Let Everyone permissions apply to an... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessEveryoneIncludesAnonymous {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Control\Lsa\EveryoneIncludesAnonymous"
        $Number = '2.3.10.5'
        $Level = 'L1'
        
        $Title= "Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'"
        $Source = 'FixMe'

        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
    }

    process {
        [bool]$Result.Setting = [int]$Result.Entry.SettingNumber
        if ($Result.Entry) {
            $Result.SetCorrectly = -not($Result.Setting)
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}

# 2.3.10.6 and 2.3.10.7
<#
.SYNOPSIS
2.3.10.6 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)
2.3.10.7 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only)

.DESCRIPTION
This policy setting determines which communication sessions, or pipes, will have attributes and permissions that allow anonymous access.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-NetworkAccessNullSessionPipes

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------
2.3.10.6   L1    Configure 'Network access: Named Pipes that can be accessed ... Group Policy Settings     True        

.NOTES
General notes
#>
function Test-NetworkAccessNullSessionPipes {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()]$ProductType = (Get-ProductType),
        [Parameter()]$SecEditReport = (Get-SecEditReport)
    )

    begin {
        $Result = [CISBenchmark]::new()
        $EntryName = "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes"
        # Get the current value of the setting
        $Result.Entry = Get-GPOEntry -EntryName $EntryName -Name "KeyName" -GPResult $GPResult -Results "ComputerResults"
        $Source = 'FixMe'
    }

    process {
        $Result.Setting = @()
        $Result.Entry.SettingStrings.Value | ForEach-Object {$Result.Setting += $_}
        if (-not($Result.Setting)) {
            $Result.Setting = @("")
        }
        $DomainController = @("LSARPC","NETLOGON","SAMR")
        $DCBrowser = @("LSARPC", "NETLOGON", "SAMR","BROWSER")
        $MemberServer = @('')
        $MSBrowser = @("BROWSER")
        $MSRDS = @("HydraLSPipe","TermServLicensing")
        $MSRDSBrowser = @("HydraLSPipe","TermServLicensing","BROWSER")

        if ($ProductType.Number -eq 2) {
            $Number = '2.3.10.6'
            $Level = 'L1'
            $Result.Profile = "Domain Controller"
            $Title= "Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only)"
            if ($Result.Entry) {
                if (-not(Compare-Object -ReferenceObject $DomainController -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $DCBrowser -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
            } else {
                $Result.SetCorrectly = $false
            }
        } elseif ($ProductType.Number -eq 3) {
            $Number = '2.3.10.7'
            $Level = 'L1'
            $Result.Profile = "Member Server"
            $Title= "Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only)"
            if ($Result.Entry) {
                if (-not(Compare-Object -ReferenceObject $MemberServer -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSBrowser -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSRDS -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } elseif (-not(Compare-Object -ReferenceObject $MSRDSBrowser -DifferenceObject $Result.Setting)) {
                    $Result.SetCorrectly = $true
                } else {
                    $Result.SetCorrectly = $false
                }
            } else {
                $Result.SetCorrectly = $false
            }
        }
    }

    end {
        return $Result
    }
}
