. $PSScriptRoot\2.2UserRightsAssignment\2.2UserRightsAssignment.ps1
. $PSScriptRoot\2.3SecurityOptions\2.3SecurityOptions.ps1

function Test-UserRightsAssignment {
    [CmdletBinding()]
    param (
        [Parameter()][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][ValidateSet("1","2")][string]$Level = "1",
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    # Not ready
}

function Test-SecurityOptions {
    [CmdletBinding()]
    param (
        [Parameter()][ValidateSet("DomainController","MemberServer")][string]$ServerType,
        [Parameter()][ValidateSet("1","2")][string]$Level = "1",
        [Parameter()][bool]$NextGenerationWindowsSecurity
    )
    # Not ready
}