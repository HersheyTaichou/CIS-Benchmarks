<#
.SYNOPSIS
The base function for all the tests under 2.2

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
Test-UserRightsAssignment -EntryName "SeMachineAccountPrivilege" -Definition @('Administrator')

Result: True
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
        [Parameter(Mandatory)][array]$Definition
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

    if (-not(Compare-Object -ReferenceObject $Definition -DifferenceObject $setting)) {
        $result = $true
    } else {
        $result = $false
    }

    $Return = [PSCustomObject]@{
        'Result'= $result
        'Setting' = $Setting -join ", "
    }

    Return $Return
}

# 2.2.1
function Test-UserRightsAssignmentTrustedCredManAccessPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    $Result = Test-UserRightsAssignment -EntryName "SeTrustedCredManAccessPrivilege" -Definition @("")

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

# 2.2.2 and 2.2.3
function Test-UserRightsAssignmentNetworkLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Get the product type
    $ProductType = Get-ProductType

    # These three entries should be the only entries 
    $DomainController = @('Administrators','Authenticated Users','ENTERPRISE DOMAIN CONTROLLERS')
    $MemberServer = @('Administrators','Authenticated Users')

    
    if ($ProductType -eq 2) {
        $Result = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $DomainController
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.2.2'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)"
            'Source' = 'Group Policy Settings'
            'Result'= $Result.Result
            'Setting' = $Result.Setting
        }
    } elseif ($ProductType -eq 3) {
        $Result = Test-UserRightsAssignment -EntryName "SeNetworkLogonRight" -Definition $MemberServer
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.2.3'
            'ConfigurationProfile' = @("Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
            'Source' = 'Group Policy Settings'
            'Result'= $Result.Result
            'Setting' = $Result.Setting
        }
    } else {
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.2.3'
            'ConfigurationProfile' = @("Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
            'Source' = 'Group Policy Settings'
            'Result'= $false
            'Setting' = @()
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

# 2.2.4
function Test-UserRightsAssignmentTcbPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    $Result = Test-UserRightsAssignment -EntryName "SeTcbPrivilege" -Definition @("")

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.4'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Act as part of the operating system' is set to 'No One'"
        'Source' = 'Group Policy Settings'
        'Result'= $Result.Result
        'Setting' = $Result.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

# 2.2.5
function Test-UserRightsAssignmentMachineAccountPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    $Result = Test-UserRightsAssignment -EntryName "SeMachineAccountPrivilege" -Definition @('Administrators')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.5'
        'ConfigurationProfile' = @("Level 1 - Domain Controller")
        'RecommendationName'= "Ensure 'Add workstations to domain' is set to 'Administrators' (DC only)"
        'Source' = 'Group Policy Settings'
        'Result'= $Result.Result
        'Setting' = $Result.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

# 2.2.6
function Test-UserRightsAssignmentIncreaseQuotaPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    $Result = Test-UserRightsAssignment -EntryName "SeIncreaseQuotaPrivilege" -Definition @('Administrators','LOCAL SERVICE','NETWORK SERVICE')

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'"
        'Source' = 'Group Policy Settings'
        'Result'= $Result.Result
        'Setting' = $Result.Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}
