# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Pentia.Get-WebProject.psm1" -Force

Describe "Get-WebProject" {
    
    $solutionDirectory = Resolve-Path "$PSScriptRoot\..\TestContent\TestSolution"
    
    It "should return an array even if nothing is found" {
        # Act
        $actualProjects = Get-WebProject -SolutionRootPath $TestDrive
            
        # Assert
        $actualProjects.GetType() | Should Be "System.Object[]"
    }

    It "should return all web projects in the solution" {
        # Arrange 
        $expectedProjects = @(
            "$solutionDirectory\src\Feature\WebProject\Code\Feature.WebProject.csproj",
            "$solutionDirectory\src\Foundation\WebProject\Code\Foundation.WebProject.csproj",
            "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj"
        )

        # Act
        $actualProjects = Get-WebProject -SolutionRootPath $solutionDirectory 
        
        # Assert
        $actualProjects.GetType() | Should Be "System.Object[]"
        $actualProjects | Should Be $expectedProjects
    }

    It "should exclude irrelevant system folders by default" {
        # Arrange
        $nodeModules = New-Item -Path "$TestDrive\src\MyProject\code\node_modules" -ItemType Directory
        Copy-Item "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj" -Destination $nodeModules
        $bowerComponents = New-Item -Path "$TestDrive\src\MyProject\code\bower_components" -ItemType Directory
        Copy-Item "$solutionDirectory\src\Project\WebProject\Code\Project.WebProject.csproj" -Destination $bowerComponents
        
        # Act
        $actualProjects = Get-WebProject -SolutionRootPath $TestDrive
        
        # Assert
        $actualProjects.GetType() | Should Be "System.Object[]"
        $actualProjects.Count | Should Be 0
    }

    It "should include web projects in the solution root" {
        # Arrange
        Copy-Item -Path "$solutionDirectory\src\Feature\WebProject\Code\Feature.WebProject.csproj" -Destination "$TestDrive\Feature.WebProject.csproj"

        # Act
        $actualProjects = Get-WebProject -SolutionRootPath $TestDrive

        # Assert
        $actualProjects.Count | Should Be 1
    }
}
