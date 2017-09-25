# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\..\Get-RuntimeDependencyPackage\Get-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\Publish-RuntimeDependencyPackage\Publish-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\Get-SitecoreHelixProject\Get-SitecoreHelixProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Publish-WebProject\Publish-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Get-ConfigurationTransformFile\Get-ConfigurationTransformFile.psm1" -Force
Import-Module "$PSScriptRoot\..\Invoke-ConfigurationTransform\Invoke-ConfigurationTransform.psm1" -Force
Import-Module "$PSScriptRoot\Publish-HelixSolution.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\New-TestSolution.psm1" -Force

Describe "Publish-HelixSolution" {

    InModuleScope "Publish-HelixSolution" {
        It "should determine the solution root path correctly" {
            # Arrange 
            $solutionRootPath = "Some Path"
            $expectedSolutionRootPath = $solutionRootPath

            # Act
            $solutionRootPath = Get-SolutionRootPath -SolutionRootPath $solutionRootPath

            # Assert
            $solutionRootPath | Should Be $expectedSolutionRootPath
        }

        It "should determine the solution root path fallback correctly" {
            # Arrange 
            $solutionRootPath = $Null
            $expectedSolutionRootPath = "$PSScriptRoot"

            # Act
            $solutionRootPath = Get-SolutionRootPath -SolutionRootPath $solutionRootPath

            # Assert
            $solutionRootPath | Should Be $expectedSolutionRootPath
        }
    }

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
        $buildConfiguration = "debug"

        # Act
        Publish-HelixSolution -SolutionRootPath $solution -WebrootOutputPath $webroot -DataOutputPath $data -BuildConfiguration $buildConfiguration

        # Assert
        Test-Path $webroot | Should Be $False
        Test-Path $existingContent | Should Be $False
    }
    
    Function Initialize-TestSolution {
        $solution = New-TestSolution -TempPath $TestDrive
        Initialize-TestPackageSource | Out-Null
        $solution
    }

    Function Initialize-TestPackageSource {
        $packageSource = "$TestDrive\RuntimePackages"
        Remove-Item $packageSource -Force -Recurse -ErrorAction SilentlyContinue
        Set-Content "$solution\runtime-dependencies.config" -Value ('<packages><package id="sample-runtime-dependency" version="1.0.0" source="{0}" /></packages>' -F $packageSource) -Encoding UTF8
        New-Item $packageSource -ItemType Directory
        Copy-Item -Path "$PSScriptRoot\..\TestContent\TestPackages\sample-runtime-dependency.1.0.0.nupkg" -Destination $packageSource        
    }

    Function Publish-TestSolution {
        Param(
            [Parameter(Mandatory = $True)]
            [string]$SolutionRootPath
        )
        Publish-HelixSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath "$TestDrive\Website" -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug"            
    }

    It "should publish all runtime dependencies" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath

        # Assert
        Test-Path -Path "$TestDrive\Website\WebrootSampleFile.txt" -PathType Leaf | Should Be $True 
        Test-Path -Path "$TestDrive\Data\DataSampleFile.txt" -PathType Leaf | Should Be $True
    }

    It "should publish all web projects" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath

        # Assert
        Test-Path -Path "$TestDrive\Website\bin\Project.WebProject.dll" -PathType Leaf | Should Be $True         
        Test-Path -Path "$TestDrive\Website\bin\Feature.WebProject.dll" -PathType Leaf | Should Be $True         
        Test-Path -Path "$TestDrive\Website\bin\Foundation.WebProject.dll" -PathType Leaf | Should Be $True                 
    }
    
    It "should invoke all 'Always' configuration transforms" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        
        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath
        
        # Assert
        $transformedWebConfig = Get-Content -Path "$TestDrive\Website\Web.config" | Out-String
        $transformedWebConfig -match "value=""Project.WebProject.Always""" | Should Be $True
    }
    
    It "should invoke all build configuration specific configuration transforms" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        
        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath
        
        # Assert
        $transformedWebConfig = Get-Content -Path "$TestDrive\Website\Web.config" | Out-String
        $transformedWebConfig -match "value=""Project.WebProject""" | Should Be $True
        $transformedWebConfig -match "value=""Feature.WebProject""" | Should Be $True
        $transformedWebConfig -match "value=""Foundation.WebProject""" | Should Be $True        
    }
}
