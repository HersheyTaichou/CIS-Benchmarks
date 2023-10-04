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
function Test-Accounts {
    [CmdletBinding()]
    param (
        # The name of the setting to check
        [Parameter(Mandatory)][string]$EntryName,
        # The CIS Benchmark definition
        [Parameter(Mandatory)][string]$Definition
    )

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check the current value of the setting
    $Setting = @()
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq $EntryName) {
                $Entry.Member | ForEach-Object {$Setting += $_.Name.'#text'}
            }
        }
    }

    if (-not($setting)) {
        $Setting = @("")
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($Definition -eq $setting) {
        $result = $true
    } else {
        $result = $false
    }

    $Return = [PSCustomObject]@{
        'Result'= $result
        'Setting' = $Setting
    }

    Return $Return
}

<# 2.2.1
.SYNOPSIS
2.2.1 Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'

.DESCRIPTION
This security setting is used by Credential Manager during Backup and Restore. No accounts should have this user right, as it is only assigned to Winlogon. Users' saved credentials might be compromised if this user right is assigned to other entities.

.EXAMPLE
An example

.NOTES
General notes
#>
function Test-UserRightsAssignmentSeTrustedCredManAccessPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    $Result = Test-UserRightsAssignmentSe -EntryName "SeTrustedCredManAccessPrivilege" -Definition @("")

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
        'Source' = 'Group Policy Settings'
        'Result'= $Result.Result
        'Setting' = $Result.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}