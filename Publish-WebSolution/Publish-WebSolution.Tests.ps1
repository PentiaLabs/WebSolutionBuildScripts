# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\..\Get-RuntimeDependencyPackage\Get-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\Publish-RuntimeDependencyPackage\Publish-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\Get-WebProject\Get-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Publish-WebProject\Publish-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Get-ConfigurationTransformFile\Get-ConfigurationTransformFile.psm1" -Force
Import-Module "$PSScriptRoot\..\Invoke-ConfigurationTransform\Invoke-ConfigurationTransform.psm1" -Force
Import-Module "$PSScriptRoot\..\UserSettings\UserSettings.psm1" -Force
Import-Module "$PSScriptRoot\Publish-WebSolution.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\New-TestSolution.psm1" -Force

Describe "Publish-WebSolution" {

    InModuleScope "Publish-WebSolution" {
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
            $expectedSolutionRootPath = "$PWD"

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
        Publish-ConfiguredWebSolution -SolutionRootPath $solution -WebrootOutputPath $webroot -DataOutputPath $data -BuildConfiguration $buildConfiguration

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
        Publish-ConfiguredWebSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath "$TestDrive\Website" -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug"
    }
    
    It "should save configuration files in the correct encoding" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution         
        $ae = [char]0x00E6 # This avoid issues due to the encoding of the test file itself.
        $oe = [char]0x00F8
        $aa = [char]0x00E5
            
        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath
            
        # Assert
        [xml]$transformedWebConfig = Get-Content -Path "$TestDrive\Website\Web.config" -Encoding UTF8
        $utfChars = $transformedWebConfig | Select-Xml "//@utf-chars" | Select-Object -ExpandProperty "Node"
        $utfChars.Value | Should Be "$ae$oe$aa"
    }

    It "should save function parameters as user settings by default" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        
        # Act
        Publish-ConfiguredWebSolution -SolutionRootPath $solutionRootPath -WebrootOutputPath "$TestDrive\Website" -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug"

        # Assert
        $userSettings = Get-UserSettings -SolutionRootPath $solutionRootPath
        $userSettings.webrootOutputPath | Should Be "$TestDrive\Website"
        $userSettings.dataOutputPath | Should Be "$TestDrive\Data"
        $userSettings.buildConfiguration | Should Be "Debug"
    }
    
    It "should load existing user settings by default" {
        # Arrange
        $solutionRootPath = Initialize-TestSolution
        $userSettings = @{
            webrootOutputPath  = "$TestDrive\Website-From-Settings"
            dataOutputPath     = "$TestDrive\Data-From-Settings"
            buildConfiguration = "Debug"
        }
        Set-UserSettings -SolutionRootPath $solutionRootPath -Settings $userSettings

        # Act
        Publish-ConfiguredWebSolution -SolutionRootPath $solutionRootPath

        # Assert
        $webrootOutputPathExists = Test-Path -Path $userSettings.webrootOutputPath -PathType Container
        $webrootOutputPathExists | Should Be $True "Website output path doesn't exist."
    
        $dataOutputPathExists = Test-Path -Path $userSettings.dataOutputPath -PathType Container
        $dataOutputPathExists | Should Be $True "Data output path doesn't exist."
    }

    It "should update user settings by default" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        Publish-ConfiguredWebSolution -SolutionRootPath $solutionRootPath -WebrootOutputPath "$TestDrive\Website" -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug"
        $updatedDataOutputPath = "$TestDrive\Data-" + [Guid]::NewGuid().ToString("D")
    
        # Act
        Publish-ConfiguredWebSolution -SolutionRootPath $solutionRootPath -DataOutputPath $updatedDataOutputPath

        # Assert
        $userSettings = Get-UserSettings -SolutionRootPath $solutionRootPath
        $userSettings.dataOutputPath | Should Be $updatedDataOutputPath "Didn't update user settings with parameters from call to 'Publish-ConfiguredWebSolution'."
    }
    
    It "should ignore user settings when required" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Publish-UnconfiguredWebSolution -SolutionRootPath $solutionRootPath -WebrootOutputPath "$solutionRootPath\www" -DataOutputPath "$solutionRootPath\data"

        # Assert
        $userSettingsExist = Test-Path "$solutionRootPath/.pentia/user-settings.json"
        $userSettingsExist | Should Be $False
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

    It "should publish all web projects to a single relative output directory" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Push-Location $TestDrive
        Publish-UnconfiguredWebSolution -SolutionRootPath $solutionRootPath -WebrootOutputPath ".\output\www" -DataOutputPath ".\output\data"
        Pop-Location

        # Assert
        Test-Path -Path "$TestDrive\output\www\bin\Project.WebProject.dll" -PathType Leaf | Should Be $True         
        Test-Path -Path "$TestDrive\output\www\bin\Feature.WebProject.dll" -PathType Leaf | Should Be $True         
        Test-Path -Path "$TestDrive\output\www\bin\Foundation.WebProject.dll" -PathType Leaf | Should Be $True                 
    }

    It "should delete all configuration transform files in the output directory" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath

        # Assert
        Test-Path -Path "$TestDrive\Website\Web.Debug.config" -PathType Leaf | Should Be $False
        Test-Path -Path "$TestDrive\Website\Web.Release.config" -PathType Leaf | Should Be $False
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
