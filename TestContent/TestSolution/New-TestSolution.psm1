Import-Module "$PSScriptRoot\..\..\Get-MSBuild\Get-MSBuild.psm1" -Force

Function New-TestSolution {
    [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType([System.String])]            
    Param(
        [Parameter(Mandatory = $True)]
        [string]$TempPath
    )

    $tempTestSolutionPath = "$TempPath\TestSolution"
    if ($pscmdlet.ShouldProcess($tempTestSolutionPath, "Removing all files in folder")) {
        Remove-Item -Path "$tempTestSolutionPath" -Recurse -Force -ErrorAction SilentlyContinue
    }
    # Copy solution
    Copy-Item "$PSScriptRoot\src" -Destination "$tempTestSolutionPath\src" -Container -Recurse
    Copy-Item "$PSScriptRoot\TestSolution.sln" -Destination "$tempTestSolutionPath"
    Write-Verbose "TestSolution copied:"
    Get-ChildItem $tempTestSolutionPath -Recurse | Select-Object -ExpandProperty FullName | Write-Verbose
    
    # Restore NuGet packages
    $output = & "$PSScriptRoot\NuGet.exe" "restore" "$tempTestSolutionPath" | Out-String
    If ($LASTEXITCODE -eq 0) {
        Write-Verbose $output
    }
    Else {
        Throw "Failed to restore NuGet packages for test solution '$tempTestSolutionPath'.`r`n$output"
    }

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