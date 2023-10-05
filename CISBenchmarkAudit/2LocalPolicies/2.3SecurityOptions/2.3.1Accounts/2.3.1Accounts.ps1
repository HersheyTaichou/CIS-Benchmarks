<# Base
.SYNOPSIS
The base function for all the tests under 2.3

.DESCRIPTION
This function provides the base test for all the CIS Benchmarks under 2.2. 
It will take the setting to check and what the setting should be, then 
compare the current setting to the benchmark and return true/false and the
current setting

.PARAMETER EntryName
This is the setting that should be evaluated, the name must be as it shows 
up in the GPResult XML file

.PARAMETER Definition
This is the CIS Benchmark definition for this setting

.EXAMPLE
Test-UserRightsAssignmentSe -EntryName "SeMachineAccountPrivilege" -Definition @('Administrator')

Result: True
Setting: Administrator

.NOTES
This is an internal only function, and should not be exported.
#>
function Test-AccountsNoConnectedUser {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check the current value of the setting
    $EntryName = "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser"
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.SecurityOptions) {
            If ($Entry.KeyName -eq $EntryName) {
                $Setting = $Entry.SettingNumber
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Setting -eq 3) {
        $result = $true
    } else {
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.3.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'"
        'Source' = 'Group Policy Settings'
        'Result'= $Result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}
