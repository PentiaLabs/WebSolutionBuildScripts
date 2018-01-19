Import-Module "$PSScriptRoot\..\..\Get-MSBuild\Get-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\Copy-TestSolution.psm1" -Force
Import-Module "$PSScriptRoot\Restore-NuGetPackages.psm1" -Force

Function New-TestSolution {
    [CmdletBinding(SupportsShouldProcess = $True)]
    [OutputType([System.String])]            
    Param(
        [Parameter(Mandatory = $True)]
        [string]$TempPath
    )

    $tempTestSolutionPath = "$TempPath\TestSolution"
    If (-not $pscmdlet.ShouldProcess($tempTestSolutionPath, "Create clean test solution in directory")) {
        return $tempTestSolutionPath
    }
    Copy-TestSolution -SolutionRootPath $tempTestSolutionPath
    Restore-NuGetPackages -SolutionFilePath "$tempTestSolutionPath\TestSolution.sln"

    # Run MSBuild.exe
    $msBuildExecutable = Get-MSBuild
    If (-not $msBuildExecutable) {
        Throw "Didn't find MSBuild.exe. Can't compile solution for running tests."
    }
    $output = & "$msBuildExecutable" "$tempTestSolutionPath\TestSolution.sln" | Out-String
    If ($LASTEXITCODE -eq 0) {
        Write-Verbose $output
    }
    Else {
        Throw "Failed to build test solution '$tempTestSolutionPath'.`r`n$output"
    }
    
    # Return temp solution path
    $tempTestSolutionPath
}