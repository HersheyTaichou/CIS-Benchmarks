#Requires -Modules @{ModuleName='InvokeBuild';ModuleVersion='3.2.1'}
#Requires -Modules @{ModuleName='PowerShellGet';ModuleVersion='1.6.0'}
#Requires -Modules @{ModuleName='Pester';ModuleVersion='5.3.0'}
#Requires -Modules @{ModuleName='ModuleBuilder';ModuleVersion='1.0.0'}
#Requires -Modules @{ModuleName='PSScriptAnalyzer';ModuleVersion='1.0.1'}

$Script:IsAppveyor = $null -ne $env:APPVEYOR
$Script:ModuleName = Get-Item -Path $BuildRoot | Select-Object -ExpandProperty Name
Get-Module -Name $ModuleName | Remove-Module -Force

task Clean {
    Remove-Item -Path ".\Bin" -Recurse -Force -ErrorAction SilentlyContinue
}

task Analyze {
    Write-Build Yellow "`n`n`nStatic code analysis"
    $SourceScriptAnalyzerParams = @{
        Path = "$BuildRoot\Source"
        ExcludeRule = "PSUseToExportFieldsInManifest"
        Recurse = $true
    }

    $TestScriptAnalyzerParams = @{
        Path = "$BuildRoot\Test"
        ExcludeRule = "PSReviewUnusedParameter", "PSUseDeclaredVarsMoreThanAssignments" # It doesn't like the way Pester uses things from different blocks
        Recurse = $true
    }

    $AnalyzerResults = @()

    $AnalyzerResults += Invoke-ScriptAnalyzer @SourceScriptAnalyzerParams
    $AnalyzerResults += Invoke-ScriptAnalyzer @TestScriptAnalyzerParams
    

    If ($AnalyzerResults) {
        $AnalyzerResults | Format-Table -AutoSize

        If($AnalyzerResults.Severity -eq "Error") {
            throw "PSScriptAnalyzer found errors"
        }
        If($AnalyzerResults.Severity -eq "Warning") {
            Write-Warning "PSScriptAnalyzer found warnings"
        }
    }
}

task TestCode {
    Write-Build Yellow "`n`n`nTesting dev code before build"
    $TestResult = Invoke-Pester -Path "$PSScriptRoot\Test\Unit" -Tag Unit -PassThru
    if($TestResult.FailedCount -gt 0) {throw 'Tests failed'}
}

task CompilePSM {
    Write-Build Yellow "`n`n`nCompiling all code into single psm1"
    try {
        $BuildParams = @{}
        if((Get-Command -ErrorAction stop -Name gitversion)) {
            $GitVersion = gitversion | ConvertFrom-Json | Select-Object -Expand FullSemVer
            $GitVersion = gitversion | ConvertFrom-Json | Select-Object -Expand InformationalVersion
            $BuildParams['SemVer'] = $GitVersion
        }
    }
    catch{
        Write-Warning -Message 'gitversion not found, keeping current version'
    }
    Push-Location -Path "$BuildRoot\Source" -StackName 'InvokeBuildTask'
    $Script:CompileResult = Build-Module @BuildParams -Passthru
    Get-ChildItem -Path "$BuildRoot\license*" | Copy-Item -Destination $Script:CompileResult.ModuleBase
    Pop-Location -StackName 'InvokeBuildTask'
}

task MakeHelp -if (Test-Path -Path "$PSScriptRoot\Docs") {

}

task TestBuild {
    Write-Build Yellow "`n`n`nTesting compiled module"

    $container = New-PesterContainer -Path "$PSScriptRoot\test\Unit" -Data @{ModulePath=$Script:CompileResult.ModuleBase}

    $config = New-PesterConfiguration
    $config.CodeCoverage.Enabled = $true
    $config.CodeCoverage.Path = (Get-ChildItem -Path $Script:CompileResult.ModuleBase -Filter *.psm1).FullName
    $config.Output.Verbosity = "None"
    $config.Run.Container = $container
    $config.Run.PassThru = $true

    $TestResult = Invoke-Pester -Configuration $config
    $TestResult.CodeCoverage|Add-Member -MemberType NoteProperty -Name MissedCommands -Value $TestResult.CodeCoverage.CommandsMissed
    Remove-Item $PSScriptRoot\coverage.xml -ErrorAction SilentlyContinue

    if($TestResult.FailedCount -gt 0) {
        Write-Warning -Message "Failing Tests:"
        $TestResult.TestResult.Where{$_.Result -eq 'Failed'} | ForEach-Object -Process {
            Write-Warning -Message $_.Name
            Write-Verbose -Message $_.FailureMessage -Verbose
        }
        throw 'Tests failed'
    }

    $CodeCoverageResult = $TestResult | Convert-CodeCoverage -SourceRoot "$PSScriptRoot\Source"
    $CodeCoveragePercent = $TestResult.CodeCoverage.CommandsExecutedCount/$TestResult.CodeCoverage.CommandsAnalyzedCount*100 -as [int]
    Write-Verbose -Message "CodeCoverage is $CodeCoveragePercent%" -Verbose
    $MissedCommands = @()
    $MissedCommands += $CodeCoverageResult | Group-Object -Property SourceFile | Sort-Object -Property Count -Descending | Select-Object -Property Count, Name -First 10

    if($MissedCommands.length -gt 0) {
        Write-Verbose -Message "Commands Missed | Source File" -Verbose
        Write-Verbose -Message "----------------|------------" -Verbose
        $MissedCommands | ForEach-Object {
            $Line = "{0,15} | {1}" -f $_.Count, $_.Name
            Write-Verbose $Line -Verbose
        }
    }
}

task . Clean, Analyze, TestCode, Build

task Build CompilePSM, MakeHelp, TestBuild

