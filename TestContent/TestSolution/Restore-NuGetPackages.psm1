Function Restore-NuGetPackages {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$SolutionFilePath
    )
    . "$PSScriptRoot\NuGet.exe" "restore" "$SolutionFilePath" | Write-Verbose
    If ($LASTEXITCODE -ne 0) {
        Throw "Failed to restore NuGet packages for test solution '$SolutionFilePath'."
    }
}