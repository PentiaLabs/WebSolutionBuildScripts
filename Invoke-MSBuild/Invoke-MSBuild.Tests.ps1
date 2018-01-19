# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
#Requires -Modules Pester
Import-Module "$PSScriptRoot\Invoke-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\..\Get-MSBuild\Get-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\Copy-TestSolution.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\Restore-NuGetPackages.psm1" -Force

Describe "Invoke-MSBuild" {
    It "should compile the solution" {
        # Arrange
        $solutionRootPath = $TestDrive
        $solutionFilePath = "$solutionRootPath\TestSolution.sln"
        Copy-TestSolution -SolutionRootPath $solutionRootPath
        Restore-NuGetPackages -SolutionFilePath $solutionFilePath

        # Act
        $solutionFilePath | Invoke-MSBuild

        # Assert
        $LASTEXITCODE | Should Be 0
    }

    It "should throw an error when the solution can't be built" {
        # Arrange
        $solutionRootPath = $TestDrive
        $solutionFilePath = "$solutionRootPath\TestSolution.sln"
        Copy-TestSolution -SolutionRootPath $solutionRootPath

        # Act
        $invocation = { $solutionFilePath | Invoke-MSBuild }

        # Assert
        $invocation | Should Throw "Failed to build '$solutionFilePath'."
    }
}
