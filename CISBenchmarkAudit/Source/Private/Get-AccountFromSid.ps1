<#
.SYNOPSIS
Find an account based on the Security Identifier (SID)

.DESCRIPTION
Take a Security Identifier (SID) and lookup the related account name, if possible

.PARAMETER AccountSid
The Security Identifier (SID) for the account to lookup

.EXAMPLE
Get-AccountFromSid -AccountSid "S-1-1-0"
Everyone

.NOTES
General notes
#>
function Get-AccountFromSid {
    [CmdletBinding()]
    param (
        # Security Identifier (SID)
        [Parameter(Mandatory)]
        [string]
        $AccountSid
    )

    process {
        try {
            $AccountObject = New-Object System.Security.Principal.SecurityIdentifier ($AccountSid)
            $AccountName = $AccountObject.Translate([System.Security.Principal.NTAccount]).Value
        } catch {
            # If translation fails, return account SID
            $AccountName = $AccountSid
        }
    }

    end {
        Return $AccountName
    }
}
