function Test-UserRightsAssignmentTrustedCredManAccessPrivilege {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the lockout duration applied to this machine
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq "SeTrustedCredManAccessPrivilege") {
                $Setting = $Entry.Member
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
        $Message += " has a value and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}

function Test-UserRightsAssignmentNetworkLogonRight {
    [CmdletBinding()]
    param ()

    $Return = @()

    # Run Get-GPResultantSetOfPolicy and return the results as a variable
    $gpresult = Get-GPResult

    #Find the lockout duration applied to this machine
    $Setting = @()
    foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
        foreach ($Entry in $data.Extension.UserRightsAssignment) {
            If ($Entry.Name -eq "SeNetworkLogonRight") {
                foreach ($Name in $Entry.Member) {
                    $Setting += $Name.Name.'#text'
                }
            }
        }
    }

    # Check if the domain setting meets the CIS Benchmark

    $Success = @('Administrators','Authenticated Users','ENTERPRISE DOMAIN CONTROLLERS')

    $Message = "2.2.1 'Access this computer from the network'"
    if (-not(Compare-Object -ReferenceObject $Success -DifferenceObject $setting)) {
        $Message += " is blank or missing and does meet the requirement."
        Write-Verbose $Message
        $result = $true
    } else {
        $Message += " has a value and does not meet the requirement."
        Write-Warning $Message
        $result = $false
    }

    $Properties = [PSCustomObject]@{
        'RecommendationNumber'= '2.2.1'
        'ConfigurationProfile' = @("Level 1 - Domain Controller","Level 1 - Member Server")
        'RecommendationName'= "Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
        'Source' = 'Group Policy Settings'
        'Result'= $result
        'Setting' = $Setting
    }
    $Properties.PSTypeNames.Add('psCISBenchmark')
    $Return += $Properties

    Return $Return
}
