# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\..\Pentia.Get-RuntimeDependencyPackage\Pentia.Get-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Publish-RuntimeDependencyPackage\Pentia.Publish-RuntimeDependencyPackage.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Get-WebProject\Pentia.Get-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Publish-WebProject\Pentia.Publish-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Get-ConfigurationTransformFile\Pentia.Get-ConfigurationTransformFile.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Invoke-ConfigurationTransform\Pentia.Invoke-ConfigurationTransform.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.UserSettings\Pentia.UserSettings.psm1" -Force
Import-Module "$PSScriptRoot\..\Pentia.Publish-NuGetPackage\Pentia.Publish-NuGetPackage.psm1" -Force
Import-Module "$PSScriptRoot\Pentia.Publish-WebSolution.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\New-TestSolution.psm1" -Force
    
function Initialize-TestSolution {
    $solution = New-TestSolution -TempPath $TestDrive
    Initialize-TestPackageSource | Out-Null
    $solution
}

function Initialize-TestPackageSource {
    $packageSource = "$TestDrive\RuntimePackages"
    Remove-Item $packageSource -Force -Recurse -ErrorAction SilentlyContinue
    # Used by Package Management framework
    Set-Content "$solution\runtime-dependencies.config" -Value ('<packages><package id="sample-runtime-dependency" version="1.0.0" source="{0}" /></packages>' -F $packageSource) -Encoding UTF8
    # Used by NuGet
    Set-Content "$solution\packages.config" -Value '<packages><package id="sample-runtime-dependency" version="1.0.0" /></packages>' -Encoding UTF8
    Set-Content "$solution\NuGet.config" -Value ('<configuration><packageSources><add key="test-package-source" value="{0}" /></packageSources></configuration>' -F $packageSource) -Encoding UTF8
    New-Item $packageSource -ItemType Directory
    Copy-Item -Path "$PSScriptRoot\..\TestContent\TestPackages\sample-runtime-dependency.1.0.0.nupkg" -Destination $packageSource        
}

function Publish-TestSolution {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath
    )
    Publish-ConfiguredWebSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath "$TestDrive\Website" -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug"
}

function Publish-TestSolutionWithWebProjects {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SolutionRootPath,
        [Parameter(Mandatory = $true)]
        [string[]]$WebProjects
    )
    Publish-ConfiguredWebSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath "$TestDrive\Website" -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug" -WebProjects $WebProjects
}

Describe "Publish-WebSolution - solution root path" {

    InModuleScope "Pentia.Publish-WebSolution" {
        It "should determine the solution root path correctly" {
            # Arrange 
            $solutionRootPath = "Some Path"
            $expectedSolutionRootPath = [System.IO.Path]::Combine($PWD, $solutionRootPath)

            # Act
            $solutionRootPath = Get-SolutionRootPath -SolutionRootPath $solutionRootPath

            # Assert
            $solutionRootPath | Should Be $expectedSolutionRootPath
        }

        It "should determine the solution root path fallback correctly" {
            # Arrange 
            $solutionRootPath = $null
            $expectedSolutionRootPath = "$PWD"

            # Act
            $solutionRootPath = Get-SolutionRootPath -SolutionRootPath $solutionRootPath

            # Assert
            $solutionRootPath | Should Be $expectedSolutionRootPath
        }
    }

}

Describe "Publish-WebSolution - output preparation" {

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
        Test-Path $webroot | Should Be $false
        Test-Path $existingContent | Should Be $false
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
}

Describe "Publish-WebSolution - user setting integration" {    

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
        $webrootOutputPathExists | Should Be $true "Website output path doesn't exist."
        
        $dataOutputPathExists = Test-Path -Path $userSettings.dataOutputPath -PathType Container
        $dataOutputPathExists | Should Be $true "Data output path doesn't exist."
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
        $userSettingsExist | Should Be $false
    }

}

Describe "Publish-WebSolution - runtime dependency publishing" {
        
    It "should publish all runtime dependencies using Package Management" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        Remove-Item "$solutionRootPath\packages.config"
        Remove-Item "$solutionRootPath\NuGet.config"

        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath

        # Assert
        Test-Path -Path "$TestDrive\Website\WebrootSampleFile.txt" -PathType Leaf | Should Be $true 
        Test-Path -Path "$TestDrive\Data\DataSampleFile.txt" -PathType Leaf | Should Be $true
    }

    It "should publish all runtime dependencies using NuGet" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        Remove-Item "$solutionRootPath\runtime-dependencies.config"

        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath

        # Assert
        Test-Path -Path "$TestDrive\Website\WebrootSampleFile.txt" -PathType Leaf | Should Be $true 
        Test-Path -Path "$TestDrive\Data\DataSampleFile.txt" -PathType Leaf | Should Be $true
    }

}

Describe "Publish-WebSolution - web project publishing" {
        
    It "should publish all web projects" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath

        # Assert
        Test-Path -Path "$TestDrive\Website\bin\Project.WebProject.dll" -PathType Leaf | Should Be $true         
        Test-Path -Path "$TestDrive\Website\bin\Feature.WebProject.dll" -PathType Leaf | Should Be $true         
        Test-Path -Path "$TestDrive\Website\bin\Foundation.WebProject.dll" -PathType Leaf | Should Be $true                 
    }

    It "should publish all web projects to a single relative output directory" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Push-Location $TestDrive
        try {
            Publish-UnconfiguredWebSolution -SolutionRootPath $solutionRootPath -WebrootOutputPath ".\output\www" -DataOutputPath ".\output\data"
        }
        finally {
            Pop-Location
        }

        # Assert
        Test-Path -Path "$TestDrive\output\www\bin\Project.WebProject.dll" -PathType Leaf | Should Be $true         
        Test-Path -Path "$TestDrive\output\www\bin\Feature.WebProject.dll" -PathType Leaf | Should Be $true         
        Test-Path -Path "$TestDrive\output\www\bin\Foundation.WebProject.dll" -PathType Leaf | Should Be $true                 
    }

    It "should delete all configuration transform files in the output directory" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution

        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath

        # Assert
        Test-Path -Path "$TestDrive\Website\Web.Debug.config" -PathType Leaf | Should Be $false
        Test-Path -Path "$TestDrive\Website\Web.Release.config" -PathType Leaf | Should Be $false
    }
    
    It "should only publish web projects in the webproject parameter" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        $WebProjects = Get-WebProject -SolutionRootPath $solutionRootPath | Where-Object  -FilterScript {$_ -Like "*Feature.WebProject*"}
    
        # Act
        Publish-TestSolutionWithWebProjects -SolutionRootPath $solutionRootPath -WebProjects $WebProjects
    
        # Assert
        Test-Path -Path "$TestDrive\Website\bin\Project.WebProject.dll" -PathType Leaf | Should Be $false
        Test-Path -Path "$TestDrive\Website\bin\Feature.WebProject.dll" -PathType Leaf | Should Be $true    
        Test-Path -Path "$TestDrive\Website\bin\Foundation.WebProject.dll" -PathType Leaf | Should Be $false   
    }
}

Describe "Publish-WebSolution - web project publish concurrency" {

    function Test-ConcurrencyPrerequisite {
        $processorInfo = Get-WmiObject "Win32_processor" | Select-Object -Property "NumberOfEnabledCore"
        $processorInfo.NumberOfEnabledCore -gt 1
    }

    if (-not (Test-ConcurrencyPrerequisite)) {
        Write-Warning "Skipping concurrency tests - requires at least two enabled cores."
        return
    }

    It "should publish using a single MSBuild node by default" {
        # Arrange        
        $solutionRootPath = Initialize-TestSolution
        $preference = $VerbosePreference
        $VerbosePreference = "Continue"
        $buildLogPath = "$TestDrive\publish-sequential.log"
        
        # Act
        try {
            Publish-ConfiguredWebSolution -SolutionRootPath $SolutionRootPath -WebrootOutputPath "$TestDrive\Website"`
                -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug" -WebProjects $WebProjects -Verbose *> $buildLogPath
        }
        finally {
            $VerbosePreference = $preference
        }
  
        # Assert
        $buildLog = Get-Content $buildLogPath -Raw
        $buildLog | Should Match " on node 1 \(WebPublish target"
        $buildLog | Should Not Match " on node 2 \(WebPublish target"
        $buildLog | Should Not Match " on node 3 \(WebPublish target"
    }

    It "should publish using multiple MSBuild nodes when using the 'PublishParallelly' switch" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
        $preference = $VerbosePreference
        $VerbosePreference = "Continue"
        $buildLogPath = "$TestDrive\publish-parallel.log"
        
        # Act
        try {
            Publish-ConfiguredWebSolution -PublishParallelly -SolutionRootPath $SolutionRootPath -WebrootOutputPath "$TestDrive\Website"`
                -DataOutputPath "$TestDrive\Data" -BuildConfiguration "Debug" -WebProjects $WebProjects -Verbose *> $buildLogPath
        }
        finally {
            $VerbosePreference = $preference           
        }     
   
        # Assert
        $buildLog = Get-Content $buildLogPath -Raw    
        $buildLog | Should Match " on node 1 \(WebPublish target"
        $buildLog | Should Match " on node 2 \(WebPublish target"
        $buildLog | Should Match " on node 3 \(WebPublish target"
    }
}

Describe "Publish-WebSolution - configuration transformation" {

    It "should invoke all 'Always' configuration transforms" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
            
        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath
            
        # Assert
        $transformedWebConfig = Get-Content -Path "$TestDrive\Website\Web.config" | Out-String
        $transformedWebConfig -match "value=""Project.WebProject.Always""" | Should Be $true
    }
        
    It "should invoke all build configuration specific configuration transforms" {
        # Arrange    
        $solutionRootPath = Initialize-TestSolution
            
        # Act
        Publish-TestSolution -SolutionRootPath $solutionRootPath
            
        # Assert
        $transformedWebConfig = Get-Content -Path "$TestDrive\Website\Web.config" | Out-String
        $transformedWebConfig -match "value=""Project.WebProject""" | Should Be $true
        $transformedWebConfig -match "value=""Feature.WebProject""" | Should Be $true
        $transformedWebConfig -match "value=""Foundation.WebProject""" | Should Be $true        
    }

}

Describe "Publish-WebSolution - New-WebPublishProject" {

    InModuleScope "Pentia.Publish-WebSolution" {
        It "should create a valid <Project>-element in the generated .csproj-file" {
            # Arrange
            $solutionRootPath = New-TestSolution -TempPath $TestDrive
            $webProjectFiles = Get-WebProject -SolutionRootPath $solutionRootPath

            # Act
            $tempProjectFilePath = New-WebPublishProject -SolutionRootPath $solutionRootPath -WebProjects $webProjectFiles
    
            # Assert
            [xml]$content = Get-Content $tempProjectFilePath 
            $content.DocumentElement.NamespaceURI | Should Be "http://schemas.microsoft.com/developer/msbuild/2003"
        }
    }
}
