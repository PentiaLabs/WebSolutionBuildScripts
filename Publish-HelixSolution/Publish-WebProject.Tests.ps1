# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-WebProject.ps1" -Force
Import-Module "$PSScriptRoot\..\Shared\Get-MSBuild.ps1" -Force

Describe "Publish-WebProject" {

    $WebProjectFilePath = "$PSScriptRoot\TestSolution\src\Project\WebProject\Code\WebProject.csproj"
    $PublishWebsitePath = "$TestDrive\Website"
    $FoundationWebProjectFilePath = "$PSScriptRoot\TestSolution\src\Foundation\WebProject\Code\WebProject.csproj"
    
    Write-Host $PublishWebsitePath
    
    Function CompileTestProject {
        $msBuildExecutable = Get-MSBuild
        & "$msBuildExecutable" "$WebProjectFilePath"
    }
    
    It "should create the output directory if it doesn't exist" {
        # Arrange
        CompileTestProject

        # Act
        Publish-WebProject -WebProjectFilePath $WebProjectFilePath -OutputDirectory $PublishWebsitePath -Verbose

        # Assert
        Test-Path $PublishWebsitePath | Should Be $True
    }

    It "should publish a web project to the target directory" {
        # Arrange
        CompileTestProject

        # Act
        Publish-WebProject -WebProjectFilePath $WebProjectFilePath -OutputDirectory $PublishWebsitePath -Verbose

        # Assert
        $countOfPublishedFiles = Get-ChildItem $PublishWebsitePath -Recurse -File | Measure-Object | Select-Object -ExpandProperty Count
        $countOfPublishedFiles | Should Be 3
    }
    
    It "should throw an exception when a project fails to publish" {
        # Arrange
        $msBuildExecutable = Get-MSBuild
        & "$msBuildExecutable" "$FoundationWebProjectFilePath"
        
        # Act
        $publishWebProject = { Publish-WebProject -WebProjectFilePath $FoundationWebProjectFilePath -OutputDirectory $PublishWebsitePath -Verbose }

        # Assert
        $publishWebProject | Should Throw
    }
}

