# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
#Requires -Modules Pester
Import-Module "$PSScriptRoot\Pentia.Invoke-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Get-MSBuild\Pentia.Get-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Publish-NuGetPackage\Pentia.Publish-NuGetPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\Copy-TestSolution.psm1" -Force

Describe "Invoke-MSBuild" {
    It "should compile the solution" {
        # Arrange
        $solutionRootPath = $TestDrive
        $solutionFilePath = "$solutionRootPath\TestSolution.sln"
        Copy-TestSolution -SolutionRootPath $solutionRootPath
        Push-Location $solutionRootPath
        try {
            Install-NuGetExe
            Restore-NuGetPackage -SolutionDirectory "."
        }
        finally {
            Pop-Location        
        }

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

Describe "Invoke-MSBuild" {
    It "should accept an array of additional build arguments" {
        # Arrange
        $solutionRootPath = $TestDrive
        Copy-TestSolution -SolutionRootPath $solutionRootPath
        Push-Location $solutionRootPath
        try {
            Install-NuGetExe
            Restore-NuGetPackage -SolutionDirectory "."
        }
        finally {
            Pop-Location        
        }
        $webProjectFilePath = "$solutionRootPath\src\Feature\WebProject\Code\Feature.WebProject.csproj"
        $buildArgs = @(
            "/t:Build,WebPublish",
            "/m",
            "/p:Configuration=Debug",
            "/p:PublishUrl=$TestDrive\output",
            "/p:WebPublishMethod=FileSystem"
        )

        # Act
        $webProjectFilePath | Invoke-MSBuild -BuildArgs $buildArgs

        # Assert
        $LASTEXITCODE | Should Be 0
        Test-Path -Path "$TestDrive\output\bin\Feature.WebProject.dll" | Should Be $true
    }
}
