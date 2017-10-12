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

    It "should respect Build Actions of XDT files" {
        # Arrange
        $solutionPath = New-TestSolution -TempPath "$TestDrive"
        [xml]$projectFileXml = Get-Content -Path ($solutionPath + $WebProjectFilePath)
        $contentFiles = $projectFileXml.SelectNodes("//*[local-name()='Content']/@Include") | Select-Object -ExpandProperty "Value"
        
        # Act
        Publish-WebProject -WebProjectFilePath ($solutionPath + $WebProjectFilePath) -OutputPath $PublishWebsitePath
        
        # Assert
        $contentFiles.Count | Should BeGreaterThan 0 "Didn't find any files with Build Action 'Content'."
        $publishedFiles = Get-ChildItem $PublishWebsitePath -Recurse -File | Select-Object -ExpandProperty Name
        foreach ($contentFile in $contentFiles) {
            $publishedFiles -contains $contentFile | Should Be $True "Didn't find file '$contentFile' in publish output."
        }
    }
    
    It "should throw an exception when a project fails to publish" {
        # Arrange
        $solutionPath = New-TestSolution -TempPath "$TestDrive"
        Remove-Item -Path ($solutionPath + "\src\Foundation\WebProject\Code\Web.Foundation.WebProject.Debug.config") -ErrorAction Stop
        
        # Act
        $publishWebProject = { Publish-WebProject -WebProjectFilePath ($solutionPath + $FoundationWebProjectFilePath) -OutputPath $PublishWebsitePath }

        # Assert
        $publishWebProject | Should Throw
    }
}

