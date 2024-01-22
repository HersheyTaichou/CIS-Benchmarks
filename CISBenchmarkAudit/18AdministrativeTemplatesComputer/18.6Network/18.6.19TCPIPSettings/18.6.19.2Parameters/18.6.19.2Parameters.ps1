<#
.SYNOPSIS
18.6.19.2.1 (L2) Disable IPv6 (Ensure TCPIP6 Parameter 'DisabledComponents' is set to '0xff (255)')

.DESCRIPTION
Internet Protocol version 6 (IPv6) is a set of protocols that computers use to exchange information over the Internet and over home and business networks. IPv6 allows for many more IP addresses to be assigned than IPv4 did.

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-ParametersDisableIPv6

Number     Level Title                                                           Source                    SetCorrectly
------     ----- -----                                                           ------                    ------------

.NOTES
General notes
#>
function Test-ParametersDisableIPv6 {
    [CmdletBinding()]
    param (
        # Get the product type (1, 2 or 3)
        [Parameter()][ValidateSet(1,2,3)][int]$ProductType = (Get-ProductType),
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][int]$CISControl = 8
    )

    begin {
        $Result = [CISBenchmark]::new()
        $Result.Number = '18.6.19.2.1'
        $Result.Level = "L2"
        if ($ProductType -eq 1) {
            $Result.Profile = "Corporate/Enterprise Environment"
        } elseif ($ProductType -eq 2) {
            $Result.Profile = "Domain Controller"
        } elseif ($ProductType -eq 3) {
            $Result.Profile = "Member Server"
        }
        $Result.Title = "Disable IPv6 (Ensure TCPIP6 Parameter 'DisabledComponents' is set to '0xff (255)')"
        $Result.Source = 'Group Policy Settings'

        # Get the current value of the setting
        foreach ($data in $GPResult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Node in $data.Extension.ChildNodes) {
                If ($Node.BaseInstanceXml.INSTANCE.PROPERTY) {
                    $polmkrHive = ($Node.BaseInstanceXml.INSTANCE.PROPERTY | Where-object {$_.Name -eq "polmkrHive"}).VALUE
                    $polmkrKey = ($Node.BaseInstanceXml.INSTANCE.PROPERTY | Where-object {$_.Name -eq "polmkrKey"}).VALUE
                    $polmkrName = ($Node.BaseInstanceXml.INSTANCE.PROPERTY | Where-object {$_.Name -eq "polmkrName"}).VALUE
                    Write-Verbose "$($polmkrHive)\$($polmkrKey)\$($polmkrName)"
                    if (($polmkrHive -eq "HKEY_LOCAL_MACHINE") -and ($polmkrKey -eq "SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters") -and ($polmkrName -eq "DisabledComponents")) {
                        $Node.BaseInstanceXml.INSTANCE.PROPERTY | ForEach-Object {$Properties += @{$_.Name = $_.Value}}
                        $Result.Entry = New-Object -TypeName PSCustomObject -Property $Properties
                    }
                }
            }
        }
    }

    process {
        $Result.Setting = $Result.Entry.polmkrValue
        if ($Result.Setting -eq "000000FF") {
            $Result.SetCorrectly = $true
        } else {
            $Result.SetCorrectly = $false
        }
    }

    end {
        return $Result
    }
}
