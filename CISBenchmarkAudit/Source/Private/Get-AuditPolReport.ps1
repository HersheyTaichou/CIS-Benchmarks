function Get-AuditPolReport {
    [CmdletBinding()]
    param ()
    
    begin {
        $Auditpol = "C:\Windows\System32\auditpol.exe"
        $TempFileName = "$env:TEMP\$(New-Guid).csv"
    }

    process {
        If (-Not (Test-Path $Auditpol)) {
            Write-Error "$Auditpol is required and was not found."
        } else {
            &$Auditpol /backup /file:$TempFileName | Out-Null
            $Data = Import-Csv $TempFileName
        }
    }

    end {
        Remove-Item $TempFileName
        return $Data
    }
}