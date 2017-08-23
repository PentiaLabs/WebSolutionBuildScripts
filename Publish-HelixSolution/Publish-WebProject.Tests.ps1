# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-WebProject.ps1" -Force
Import-Module "$PSScriptRoot\..\Shared\Get-MSBuild.ps1" -Force

$webProjectFilePath = "$PSScriptRoot\TestWebProject\src\Project\SampleWebApplication\SampleWebApplication.csproj"
$publishWebsitePath = "$TestDrive\Website"

Function CompileTestProject {
    $msBuildExecutable = Get-MSBuild
    & "$msBuildExecutable" "$webProjectFilePath" 
}

Describe "Publish-WebProject" {
    It "should create the output directory if it doesn't exist" {
        # Arrange
        CompileTestProject

        # Act
        Publish-WebProject -WebProjectFilePath $webProjectFilePath -OutputDirectory $publishWebsitePath -Verbose

        # Assert
        Test-Path $publishWebsitePath | Should Be $True
    }

    It "should publish a web project to the target directory" {
        # Arrange
        CompileTestProject

        # Act
        Publish-WebProject -WebProjectFilePath $webProjectFilePath -OutputDirectory $publishWebsitePath -Verbose

        # Assert
        $countOfPublishedFiles = Get-ChildItem $publishWebsitePath -Recurse -File | Measure-Object | Select-Object -ExpandProperty Count
        $countOfPublishedFiles | Should Be 4
    }
}

