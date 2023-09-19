function Test-Function {
    [CmdletBinding()]
    param (
        [Parameter()][String]$FirstParam
    )
}

Export-ModuleMember -Function Test-Function