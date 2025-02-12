@{
    Path = "CISBenchmarkAudit.psd1"
    OutputDirectory = "..\bin\CISBenchmarkAudit"
    Prefix = '.\_PrefixCode.ps1'
    SourceDirectories = 'Classes','Private','Public'
    PublicFilter = 'Public\*.ps1'
    VersionedOutputDirectory = $true
}
