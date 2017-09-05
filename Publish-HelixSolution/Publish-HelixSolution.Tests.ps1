# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\Publish-HelixSolution.psm1" -Force
Import-Module "$PSScriptRoot\..\Get-MSBuild\Get-MSBuild.psm1" -Force

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
        $buildConfiguration = "debug"

        # Act
        Publish-HelixSolution -SolutionRootPath $solution -WebrootOutputPath $webroot -DataOutputPath $data -BuildConfiguration $buildConfiguration

        # Assert
        Test-Path $webroot | Should Be $False
        Test-Path $existingContent | Should Be $False
    }
    
    Function CompileTestSolution {
        Param(
            [Parameter(Mandatory = $True)]
            [string]$ProjectFilePath
        )
        $msBuildExecutable = Get-MSBuild
        If (-not $msBuildExecutable) {
            Throw "Didn't find MSBuild.exe. Can't compile solution for running tests."
        }
        & "$msBuildExecutable" "$ProjectFilePath" | Write-Verbose
        If ($LASTEXITCODE -ne 0) {
            Throw "Failed to build solution. Make sure you have ASP.NET features installed for Visual Studio."
        }
    }

    $IsTestSolutionInitialized = $False
    $IsTestSolutionPublished = $False
    
    Function Initialize-TestSolution {
        $solution = "$TestDrive\Solution"
        If ($script:IsTestSolutionInitialized) {
            Write-Host "Skipping test solution initialization."
        }
        Else {
            . {
                $script:IsTestSolutionInitialized = $False
            
                # $TestDrive is "Describe-block" scoped, hence we clean it here.
                Remove-Item $TestDrive -Recurse -Force

                # Copy solution
                New-Item $solution -ItemType Directory
                Copy-Item -Path "$PSScriptRoot\..\Publish-WebProject\TestSolution" -Recurse -Destination $solution
        
                # Add missing Web.config to foundation project for happy-path test.
                Copy-Item -Path "$PSScriptRoot\..\Publish-WebProject\TestSolution\src\Project\WebProject\Code\Web.config" -Destination "$solution\TestSolution\src\Foundation\WebProject\Code\Web.config"
                CompileTestSolution -ProjectFilePath "$solution\TestSolution\TestSolution.sln"
        
                # Create NuGet source config
                $packageSource = "$TestDrive\RuntimePackages"
                $nugetConfig = '<configuration><packageSources><clear /><add key="sample-source" value="{0}" /></configuration>' -F $packageSource
                Set-Content "$solution\nuget.config" -Value $nugetConfig

                # Create NuGet package config
                Set-Content "$solution\TestSolution\runtime-dependencies.config" -Value '<packages><package id="sample-runtime-dependency" version="1.0.0" /></packages>'
        
                # Copy sample runtime dependency
                New-Item $packageSource -ItemType Directory
                Copy-Item -Path "$PSScriptRoot\..\Publish-RuntimeDependencyPackage\TestPackages\sample-runtime-dependency.1.0.0.nupkg" -Destination $packageSource
                $script:IsTestSolutionInitialized = $True
            
            } | Out-Null        
        }
        $solution + "\TestSolution"
    }

    Function Publish-TestSolution {
        Param(
            [Parameter(Mandatory = $True)]
            [string]$SolutionRootPath
        )
        If ($script:IsTestSolutionPublished) {
            Write-Host "Skipping test solution publication."
        }
        Else {
            $script:IsTestSolutionPublished = $False
            Publish-HelixSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath "$TestDrive\Website" -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug"            
            $script:IsTestSolutionPublished = $True
        }
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
    
    It "should invoke all configuration transforms" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        
        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath
        
        # Assert
        $transformedWebConfig = Get-Content -Path "$TestDrive\Website\Web.config" | Out-String
        $transformedWebConfig -match "Project.WebProject" | Should Be $True
        $transformedWebConfig -match "Feature.WebProject" | Should Be $True
        $transformedWebConfig -match "Foundation.WebProject" | Should Be $True        
    }
}
