<#
.SYNOPSIS
The base function for all the tests under 2.2 User Rights Assignment

.DESCRIPTION
This function provides the base test for all the CIS Benchmarks under 2.2. It will take the setting to check and what the setting should be, then compare the current setting to the benchmark and return true/false and the current setting

.PARAMETER EntryName
This is the setting that should be evaluated, the name must be as it shows up in the GPResult XML file

.PARAMETER Definition
This is the CIS Benchmark definition for this setting

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Test-UserRightsAssignment -EntryName "SeMachineAccountPrivilege" -Definition @('Administrator')

SetCorrectly: True
Setting: Administrator

.NOTES
This is an internal only function, and should not be exported.
#>
function Test-UserRightsAssignment {
    [CmdletBinding()]
    param (
        # The name of the setting to check
        [Parameter(Mandatory)][string]$EntryName,
        # The CIS Benchmark definition
        [Parameter(Mandatory)][array]$Definition,
        [Parameter()][array]$OptionalDef,
        [Parameter()][switch]$Include,
        [Parameter()][xml]$GPResult
    )

    $Result = @()

    # Check the current value of the setting
    $Setting = @()
    $GPOEntry = Get-GPOEntry -EntryName $EntryName -Name "Name" -GPResult $GPResult -Results "ComputerResults"
    $GPOEntry.Member | ForEach-Object {$Setting += $_.Name.'#text'}

    if (-not($Setting)) {
        $Setting = @("")
    }

    # Check if the domain setting meets the CIS Benchmark

    if ($GPOEntry) {
        if ($Include) {
            $Count = 0
            foreach ($item in $Setting) {
                if ($item -in $Definition) {
                    $count ++
                }
            }
            if ($Definition.count -eq $Count) {
                $SetCorrectly = $true
            } else {
                $SetCorrectly = $false
            }
        } else {
            if ($OptionalDef) {
                $OptionalDef += $Definition
            } else {
                $OptionalDef = @("")
            }
            if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $Setting)) {
                $SetCorrectly = $true
            } elseif (-not(Compare-Object -ReferenceObject $OptionalDef -DifferenceObject $Setting)) {
                $SetCorrectly = $true
            } else {
                $SetCorrectly = $false
            }
        }
    } else {
        $SetCorrectly = $false
    }

    $Result = [PSCustomObject]@{
        'SetCorrectly'= $SetCorrectly
        'Setting' = $Setting -join ", "
        'Entry' = $GPOEntry
    }
    return $Result
}