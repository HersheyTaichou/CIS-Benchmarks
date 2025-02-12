<#
.SYNOPSIS
Get and return the current GP Settings

.DESCRIPTION
Run gpresult.exe on the machine, then take the file output, and
import it as a variable

.PARAMETER Path
The full path to the XML file, if it already exists, or where to save the file

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

.EXAMPLE
Get-GPResult -Path "$(get-location)\GPResult.xml"

xml                             Rsop
---                             ----
version="1.0" encoding="utf-16" Rsop

.NOTES
General notes
#>
function Get-GPResult {
    [CmdletBinding()]
    param (
        [Parameter()][string]$Path = "$([System.IO.Path]::GetTempFileName())",
        [Parameter()][switch]$Keep
    )
    
    begin {
        if (-not(Test-Path $Path)) {
            Write-Verbose "Updating the local group policy settings"
            gpupdate.exe /force | Out-Null
            Write-Verbose "Generating the resultant set of policies"
            gpresult.exe /x $Path /f | Out-Null
        } else {
            $Message = $Path + " found, testing the local file."
            Write-Verbose $Message
        }
    }
    
    process {
        Write-Verbose "Storing the resultant set of policies in a variable"
        [xml]$XMLgpresult = Get-Content $Path
    }
    
    end {
        if (-not($Keep)) {
            Remove-Item $Path
        }
        return $XMLgpresult
    }
}