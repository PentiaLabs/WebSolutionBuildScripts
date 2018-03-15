function Restore-NuGetPackages {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionFilePath
    )
    . "$PSScriptRoot\NuGet.exe" "restore" "$SolutionFilePath" | Write-Verbose
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to restore NuGet packages for test solution '$SolutionFilePath'."
    }
}