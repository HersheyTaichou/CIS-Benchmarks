function Test-UserRightsAssignmentTrustedCredManAccessPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check the 'Access Credential Manager as a trusted caller' setting
    $Setting = @()
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq "SeTrustedCredManAccessPrivilege") {
                $Entry.Member | ForEach-Object {$Setting += $_.Name.'#text'}
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    $Message = "2.2.1 'Access Credential Manager as a trusted caller'"
    if (-Not($Setting)) {
        $Message += " is blank or missing and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message += " contains these entries: `"" + ($setting -join ", ") + "`" and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting -join ", "
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

function Test-UserRightsAssignmentNetworkLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results
    $gpresult = Get-GPResult
    # Get the product type
    $ProductType = Get-ProductType

    # Gather the Network Logon Settings
    $Setting = @()
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq "SeNetworkLogonRight") {
                $Entry.Member | ForEach-Object {$Setting += $_.Name.'#text'}
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    # These three entries should be the only entries 
    $DomainController = @('Administrators','Authenticated Users','ENTERPRISE DOMAIN CONTROLLERS')
    $MemberServer = @('Administrators','Authenticated Users')

    
    if ((-not(Compare-Object -ReferenceObject $DomainController -DifferenceObject $setting)) -and $ProductType -eq 2) {
        $Message = "2.2.2 'Access this computer from the network'"
        $Message += " Contains only the recommended values"
        Write-Verbose $Message
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.2.2'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)"
            'Source' = 'Group Policy Settings'
            'Result'= $true
            'Setting' = $Setting -join ", "
        }
    } elseif ((-not(Compare-Object -ReferenceObject $MemberServer -DifferenceObject $setting)) -and $ProductType -eq 3) {
        $Message = "2.2.3 'Access this computer from the network'"
        $Message += " Contains only the recommended values"
        Write-Verbose $Message
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.2.3'
            'ConfigurationProfile' = @("Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
            'Source' = 'Group Policy Settings'
            'Result'= $true
            'Setting' = $Setting -join ", "
        }
    } elseif ((Compare-Object -ReferenceObject $DomainController -DifferenceObject $setting) -and $ProductType -eq 2) {
        $Message = "2.2.2 'Access this computer from the network'"
        $Message += " contains these entries: `"" + ($setting -join ", ") + "`" and does not meet the requirement."
        Write-Warning $Message
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.2.2'
            'ConfigurationProfile' = @("Level 1 - Domain Controller")
            'RecommendationName'= "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS' (DC only)"
            'Source' = 'Group Policy Settings'
            'Result'= $false
            'Setting' = $Setting -join ", "
        }
    } else {
        $Message = "2.2.3 'Access this computer from the network'"
        $Message += " contains these entries: `"" + ($setting -join ", ") + "`" and does not meet the requirement."
        Write-Warning $Message
        $Properties = [PSCustomObject]@{
            'RecommendationNumber'= '2.2.3'
            'ConfigurationProfile' = @("Level 1 - Member Server")
            'RecommendationName'= "Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only)"
            'Source' = 'Group Policy Settings'
            'Result'= $false
            'Setting' = $Setting -join ", "
        }
    }

    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

function Test-UserRightsAssignmentTcbPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Get the value for 'Act as part of the operating system'
    $Setting = @()
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq "SeTcbPrivilege") {
                $Entry.Member | ForEach-Object {$Setting += $_.Name.'#text'}
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    $Message = "2.2.4 'Act as part of the operating system'"
    if (-Not($Setting)) {
        $Message += " is blank or missing and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message += " contains these entries: `"" + ($setting -join ", ") + "`" and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.4'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Act as part of the operating system' is set to 'No One'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting -join ", "
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

function Test-UserRightsAssignmentMachineAccountPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check the 'Add workstations to domain' setting
    $Setting = @()
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq "SeMachineAccountPrivilege") {
                $Entry.Member | ForEach-Object {$Setting += $_.Name.'#text'}
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    $Message = "2.2.5 Add workstations to domain"
    if (-Not($Setting)) {
        $Message += " is only set to Administrators and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message += " contains these entries: `"" + ($setting -join ", ") + "`" and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.5'
        'ConfigurationProfile' = @("Level 1 - Domain Controller")
        'RecommendationName'= "Ensure 'Add workstations to domain' is set to 'Administrators'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting -join ", "
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

#Base function to copy:
function Test-UserRightsAssignment {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    # Check the 'Access Credential Manager as a trusted caller' setting
    $Setting = @()
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq "") {
                $Entry.Member | ForEach-Object {$Setting += $_.Name.'#text'}
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    $Message = "2.2."
    if (-Not($Setting)) {
        $Message += " is blank or missing and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message += " contains these entries: `"" + ($setting -join ", ") + "`" and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= ""
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting -join ", "
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}