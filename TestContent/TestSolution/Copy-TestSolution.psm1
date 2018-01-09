Function Copy-TestSolution {
    Param(
        [Parameter(Mandatory = $True)]
        [string]$SolutionRootPath
    )
    # Ensure target directory is clean
    Remove-Item -Path "$SolutionRootPath" -Recurse -Force -ErrorAction SilentlyContinue    
    # Copy solution
    Copy-Item "$PSScriptRoot\src" -Destination "$SolutionRootPath\src" -Container -Recurse
    Copy-Item "$PSScriptRoot\TestSolution.sln" -Destination "$SolutionRootPath"
}