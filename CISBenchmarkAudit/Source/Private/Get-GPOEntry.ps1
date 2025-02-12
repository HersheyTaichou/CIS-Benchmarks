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

.PARAMETER ProductType
This is used to set the type of OS that should be tested against based on the product type:

1 = Workstation
2 = Domain Controller
3 = Member Server

.PARAMETER GPResult
This is used to define the GPO XML variable to test

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
        [Parameter(Mandatory)][ValidateSet("ComputerResults","UserResults")][string]$Results,
        [Parameter()][xml]$GPResult = (Get-GPResult),
        [Parameter()][string]$Category
    )

    process {
        if ($Category) {
            foreach ($data in $GPResult.Rsop.$Results.ExtensionData) {
                foreach ($Node in $data.Extension.ChildNodes) {
                    If ($Node.$Name -eq $EntryName -and $Node.Category -eq $Category) {
                        Return $Node
                    }
                }
            }
        } else {
            foreach ($data in $GPResult.Rsop.$Results.ExtensionData) {
                foreach ($Node in $data.Extension.ChildNodes) {
                    If ($Node.$Name -eq $EntryName) {
                        Return $Node
                    }
                }
            }
        }
    }
}