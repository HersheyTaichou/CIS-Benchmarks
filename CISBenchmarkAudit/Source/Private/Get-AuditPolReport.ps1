function Get-AuditPolReport {
    [CmdletBinding()]
    param ()
    
    begin {
        $BinaryAuditpol = "C:\Windows\System32\auditpol.exe"
        $TempFileName = [System.IO.Path]::GetTempFileName() + ".csv"
        $Area = "SECURITYPOLICY"
    }

    process {
        If (-Not (Test-Path $SecEdit)) {
            Write-Error "$SecEdit is required and was not found."
        } else {
            &$BinaryAuditpol /backup /file:$TempFileName | Out-Null
            $Data = Import-Csv $TempFileName
        }
    }

    end {
        Remove-Item $TempFileName
        return $Data
    }
}