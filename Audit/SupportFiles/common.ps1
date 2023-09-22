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
Get the product type

.DESCRIPTION
Get and return the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.EXAMPLE
Get-ProductType
2

.NOTES
General notes
#>
function Get-ProductType {
    [CmdletBinding()]
    param ()
    [int]$ProductType = (Get-CimInstance -ClassName Win32_OperatingSystem).ProductType
    return $ProductType
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
        if (-not(Test-Path $Path) -or (Get-ChildItem $CustomerList | Where-Object {$_.LastWriteTime -ge (Get-Date).AddDays(-7)})) {
            Get-GPResultantSetOfPolicy -ReportType Xml -Path $Path
        }

        # Load the contents of the report into a variable
        [xml]$GPResult = Get-Content $Path

        # Return the variable
        return $GPResult
}
