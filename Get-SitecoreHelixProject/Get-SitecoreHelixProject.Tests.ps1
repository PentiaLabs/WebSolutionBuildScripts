# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Get-SitecoreHelixProject.psm1" -Force

Describe "Get-SitecoreHelixProject" {
    
    $solutionDirectory = Resolve-Path "$PSScriptRoot\..\TestContent\TestSolution"
    
    It "should return an array even if nothing is found" {
        # Act
        $actualProjects = Get-SitecoreHelixProject "$TestDrive"
            
        # Assert
        $actualProjects.Count | Should Be 0
    }

    It "should return all web projects in the solution" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Feature\WebProject\Code\Feature.WebProject.csproj",
            "$solutionDirectory\src\Foundation\WebProject\Code\Foundation.WebProject.csproj",
            "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-SitecoreHelixProject $solutionDirectory 
        
        # Assert
        $actualProjects | Should Be $expectedProjects
    }
    
    It "should return all web projects in the foundation layer" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Foundation\WebProject\Code\Foundation.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-SitecoreHelixProject $solutionDirectory -HelixLayer "Foundation"
        
        # Assert
        $actualProjects | Should Be $expectedProjects
    }    
    
    It "should return all web projects in the feature layer" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Feature\WebProject\Code\Feature.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-SitecoreHelixProject $solutionDirectory -HelixLayer "Feature"
        
        # Assert
        $actualProjects | Should Be $expectedProjects
    }
    
    It "should return all web projects in the project layer" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-SitecoreHelixProject $solutionDirectory -HelixLayer "Project"
        
        # Assert
        $actualProjects | Should Be $expectedProjects
    }

    It "should exclude irrelevant system folders by default" {
        # Arrange
        $nodeModules = New-Item -Path "$TestDrive\src\MyProject\code\node_modules" -ItemType Directory
        Copy-Item "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj" -Destination $nodeModules
        $bowerComponents = New-Item -Path "$TestDrive\src\MyProject\code\bower_components" -ItemType Directory
        Copy-Item "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj" -Destination $bowerComponents
        
        # Act
        $actualProjects = Get-SitecoreHelixProject $TestDrive
        
        # Assert
        $actualProjects.Count | Should Be 0
    }
}
