# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-HelixSolution.ps1" -Force

Describe "Publish-HelixSolution" {
    It "should delete any existing files from the publish location" {
        # Arrange
        $solution = "$TestDrive\Solution"
        New-Item $solution -ItemType Directory
        New-Item "$TestDrive\Website" -ItemType Directory
        $webroot = "$TestDrive\Website\Webroot"
        New-Item $webroot -ItemType Directory
        $data = "$TestDrive\Website\Data"
        New-Item $data -ItemType Directory
        $existingContent = "$webroot\ExistingContent.txt"
        Set-Content $existingContent -Value "Hello World!"

        # Act
        Publish-HelixSolution -SolutionRootPath $solution -WebrootOutputPath $webroot -DataOutputPath $data

        # Assert
        Test-Path $existingContent | Should Be $False
    }
}