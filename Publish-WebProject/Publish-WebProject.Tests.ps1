# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\..\Get-MSBuild\Get-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\Publish-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\New-TestSolution.psm1" -Force

Describe "Publish-WebProject" {

    $WebProjectFilePath = "\src\Project\WebProject\Code\Project.WebProject.csproj"
    $FoundationWebProjectFilePath = "\src\Foundation\WebProject\Code\Foundation.WebProject.csproj"
    $PublishWebsitePath = "$TestDrive\Website"
    
    It "should create the output directory if it doesn't exist" {
        # Arrange
        $solutionPath = New-TestSolution -TempPath "$TestDrive"

        # Act
        Publish-WebProject -WebProjectFilePath ($solutionPath + $WebProjectFilePath) -OutputPath $PublishWebsitePath

        # Assert
        Test-Path $PublishWebsitePath | Should Be $True
    }

    It "should publish a web project to the target directory" {
        # Arrange
        $solutionPath = New-TestSolution -TempPath "$TestDrive"

        # Act
        Publish-WebProject -WebProjectFilePath ($solutionPath + $WebProjectFilePath) -OutputPath $PublishWebsitePath

        # Assert
        $publishedFiles = Get-ChildItem $PublishWebsitePath -Recurse -File | Select-Object -ExpandProperty Name
        $publishedFiles -contains "Project.WebProject.dll" | Should Be $True
        $publishedFiles -contains "Project.WebProject.pdb" | Should Be $True
    }

    It "should respect Build Actions configuration of XDT files" {
        # Arrange
        $solutionPath = New-TestSolution -TempPath "$TestDrive"
        
        # Act
        Publish-WebProject -WebProjectFilePath ($solutionPath + $WebProjectFilePath) -OutputPath $PublishWebsitePath
        
        # Assert
        $publishedFiles = Get-ChildItem $PublishWebsitePath -Recurse -File | Select-Object -ExpandProperty Name
        $publishedFiles -contains "Web.config" | Should Be $False
        $publishedFiles -contains "Web.Always.config" | Should Be $True
        $publishedFiles -contains "Web.Debug.config" | Should Be $True
        $publishedFiles -contains "Web.Release.config" | Should Be $True
    }
    
    It "should throw an exception when a project fails to publish" {
        # Arrange
        $solutionPath = New-TestSolution -TempPath "$TestDrive"
        Remove-Item -Path ($solutionPath + "\src\Foundation\WebProject\Code\Web.Debug.config")
        
        # Act
        $publishWebProject = { Publish-WebProject -WebProjectFilePath ($solutionPath + $FoundationWebProjectFilePath) -OutputPath $PublishWebsitePath }

        # Assert
        $publishWebProject | Should Throw
    }
}

