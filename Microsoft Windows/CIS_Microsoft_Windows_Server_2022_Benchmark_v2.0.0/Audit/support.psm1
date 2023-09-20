<# 
This function will import an INI file. It is not currently needed, but is retained for possible future use
function Get-IniContent ($filePath) {
    $ini = @{}
    switch -regex -file $FilePath
    {
        “^\[(.+)\]” # Section
        {
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        “^(;.*)$” # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = “Comment” + $CommentCount
            $ini[$section][$name] = $value
        }
        “(.+?)\s*=(.*)” # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
} 
#>

<#
.SYNOPSIS
Checks for any prerequisites needed to audit the machine

.DESCRIPTION
Checks for and installs any prerequisites needed to audit the machine and
confirm it meets the CIS Benchmark standards. This is only used internally
currently, as part of the checks from other scripts.

.EXAMPLE
An example

.NOTES
General notes
#>
function Install-Prerequisites {
    [CmdletBinding()]
    param (
        [Parameter()]
        [TypeName]
        $ParameterName
    )
    <#
    First, get the product type:
    1 = Workstation
    2 = Domain Controller
    3 = Member Server
    #>
    $ProductType = (Get-CimInstance -ClassName Win32_OperatingSystem).ProductType

    # Check for the presence of GP commands and if they are missing, install the version based on Workstation/Server
    if ($ProductType -eq "1") {
        try {
            Get-GpoReport
            $GPMC = "Present"
        }
        catch {
            DISM.exe /Online /add-capability /CapabilityName:Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0
            $GPMC = "Installed"
        }
    } elseif ($ProductType -eq "2" -or $ProductType -eq "3") {
        try {
            Get-GpoReport
            $GPMC = "Present"
        }
        catch {
            Install-WindowsFeature GPMC
            $GPMC = "Installed"
        }
    }

    # Return details based on everything found and done
    $return = [ordered]@{
        ProductType = $ProductType;
        GPMC = $GPMC
    }
    return $return
}

<#
.SYNOPSIS
Get and return the current GP Settings

.DESCRIPTION
Run Get-GPResultantSetOfPolicy on the machine, then take the file output, and
import it as a variable

.PARAMETER Path
The full path to the XML file, if it already exists, or where to save the file

.EXAMPLE
Get-GPResult -Path "$(get-location)\GPResult.xml"

.NOTES
General notes
#>
function Get-GPResult {
    [CmdletBinding()]
    param (
        [Parameter()][string]$Path = "$(get-location)\GPResult.xml"
    )
        # Check if a report has already been generated
        if (-not(Test-Path $Path)) {
            Get-GPResultantSetOfPolicy -ReportType Xml -Path $Path
        }

        # Load the contents of the report into a variable
        [xml]$GPResult = Get-Content $Path

        # Return the variable
        return $GPResult
}