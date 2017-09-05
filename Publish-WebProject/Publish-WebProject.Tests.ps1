# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Get-MSBuild\Get-MSBuild.psm1" -Force

Describe "Publish-WebProject" {

    $WebProjectFilePath = "$PSScriptRoot\TestSolution\src\Project\WebProject\Code\Project.WebProject.csproj"
    $PublishWebsitePath = "$TestDrive\Website"
    $FoundationWebProjectFilePath = "$PSScriptRoot\TestSolution\src\Foundation\WebProject\Code\Foundation.WebProject.csproj"
    
    Function CompileTestProject {
        Param(
            [Parameter(Mandatory=$True)]
            [string]$ProjectFilePath
        )
        $msBuildExecutable = Get-MSBuild
        If (-not $msBuildExecutable) {
            Throw "Didn't find MSBuild.exe. Can't compile solution for running tests."
        }
        & "$msBuildExecutable" "$ProjectFilePath"
        If ($LASTEXITCODE -ne 0) {
            Throw "Failed to build solution. Make sure you have ASP.NET features installed for Visual Studio."
        }
    }
    
    It "should create the output directory if it doesn't exist" {
        # Arrange
        CompileTestProject -ProjectFilePath $WebProjectFilePath

        # Act
        Publish-WebProject -WebProjectFilePath $WebProjectFilePath -OutputPath $PublishWebsitePath

        # Assert
        Test-Path $PublishWebsitePath | Should Be $True
    }

    It "should publish a web project to the target directory" {
        # Arrange
        CompileTestProject -ProjectFilePath $WebProjectFilePath

        # Act
        Publish-WebProject -WebProjectFilePath $WebProjectFilePath -OutputPath $PublishWebsitePath

        # Assert
        $countOfPublishedFiles = Get-ChildItem $PublishWebsitePath -Recurse -File | Measure-Object | Select-Object -ExpandProperty Count
        $countOfPublishedFiles | Should Be 3
    }
    
    It "should throw an exception when a project fails to publish" {
        # Arrange
        CompileTestProject -ProjectFilePath $FoundationWebProjectFilePath
        
        # Act
        $publishWebProject = { Publish-WebProject -WebProjectFilePath $FoundationWebProjectFilePath -OutputPath $PublishWebsitePath }

        # Assert
        $publishWebProject | Should Throw
    }
}

