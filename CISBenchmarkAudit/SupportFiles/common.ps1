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
Run gpresult.exe on the machine, then take the file output, and
import it as a variable

.PARAMETER Path
The full path to the XML file, if it already exists, or where to save the file

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
        [Parameter()][string]$Path = "$(get-location)\GPResult.xml"
    )
    
    begin {
        if (-not(Test-Path $Path )) {
            Write-Verbose "Updating the local group policy settings"
            gpupdate.exe /force | Out-Null
            Write-Verbose "Generating the resultant set of policies"
            gpresult.exe /x $Path /f | Out-Null
            $delete = $true
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
        if ($delete) {
            Remove-Item $Path
        }
        return $XMLgpresult
    }
}

<#
.SYNOPSIS
Get a specific GPO entry from an XML report

.DESCRIPTION
This takes some details and returns the GPO entry for those details.

.PARAMETER EntryName
This is the internal name for a GPO entry. Here are some examples:

'MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal' is the EntryName for 'Domain member: Digitally encrypt or sign secure channel data (always)' from 2.3.6.1

'Audit Credential Validation' is the EntryName for 'Audit Credential Validation' from 17.1.1

.PARAMETER Name
This is the ChildNodes name. For most entries, this is Name or KeyName. You can think of this as the name of the column where EntryName is found

.EXAMPLE
Get-GPOEntry -EntryName "MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal" -Name "KeyName"

xml                             Rsop
---                             ----
version="1.0" encoding="utf-16" Rsop

.NOTES
General notes
#>
function Get-GPOEntry {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory)][string]$EntryName,
        [Parameter(Mandatory)][string]$Name,
        [Parameter()][xml]$gpresult = (Get-GPResult)
    )
    
    process {
        foreach ($data in $gpresult.Rsop.ComputerResults.ExtensionData) {
            foreach ($Entry in $data.Extension.ChildNodes) {
                If ($Entry.$Name -eq $EntryName) {
                    Return $Entry
                }
            }
        }
    }
    
    end {}
}

class CISBenchmark {
    [string]$Number # The number of the benchmark
    [string]$Level # Level 1, 2 or Next Generation Windows Security
    [string]$Profile # Domain Controller or Member Server
    [string]$Title # The title of the recommendation
    [string]$Source # Where the setting was checked from
    [string]$SetCorrectly # if it is set correctly
    [string]$Setting # The current setting
    hidden $Entry # The XML output of the setting
}