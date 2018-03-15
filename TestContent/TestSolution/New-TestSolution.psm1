Import-Module "$PSScriptRoot\..\..\Get-MSBuild\Get-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\Copy-TestSolution.psm1" -Force
Import-Module "$PSScriptRoot\Restore-NuGetPackages.psm1" -Force

function New-TestSolution {
    [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType([string])]            
    param (
        [Parameter(Mandatory = $true)]
        [string]$TempPath
    )

    $tempTestSolutionPath = "$TempPath\TestSolution"
    if (-not $pscmdlet.ShouldProcess($tempTestSolutionPath, "Create clean test solution in directory")) {
        return $tempTestSolutionPath
    }
    Copy-TestSolution -SolutionRootPath $tempTestSolutionPath
    Restore-NuGetPackages -SolutionFilePath "$tempTestSolutionPath\TestSolution.sln"

    # Run MSBuild.exe
    $msBuildExecutable = Get-MSBuild
    if (-not $msBuildExecutable) {
        throw "Didn't find MSBuild.exe. Can't compile solution for running tests."
    }
    $output = & "$msBuildExecutable" "$tempTestSolutionPath\TestSolution.sln" | Out-String
    if ($LASTEXITCODE -eq 0) {
        Write-Verbose $output
    }
    else {
        throw "Failed to build test solution '$tempTestSolutionPath'.`r`n$output"
    }
    
    # Return temp solution path
    $tempTestSolutionPath
}