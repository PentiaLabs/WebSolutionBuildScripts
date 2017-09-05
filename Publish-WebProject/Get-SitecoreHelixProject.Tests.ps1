# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Get-SitecoreHelixProject.psm1" -Force

Describe "Get-SitecoreHelixProject" {
    
    $solutionDirectory = "$PSScriptRoot\TestSolution"

    It "Should return all web projects in the solution" {
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
    
    It "Should return all web projects in the foundation layer" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Foundation\WebProject\Code\Foundation.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-SitecoreHelixProject $solutionDirectory -HelixLayer "Foundation"
        
        # Assert
        $actualProjects | Should Be $expectedProjects
    }    
    
    It "Should return all web projects in the feature layer" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Feature\WebProject\Code\Feature.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-SitecoreHelixProject $solutionDirectory -HelixLayer "Feature"
        
        # Assert
        $actualProjects | Should Be $expectedProjects
    }
    
    It "Should return all web projects in the project layer" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-SitecoreHelixProject $solutionDirectory -HelixLayer "Project"
        
        # Assert
        $actualProjects | Should Be $expectedProjects
    }
}
